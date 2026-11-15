/**
 * 3.3.1 通用事件 - 拖拽事件 onDragStart / onDrop
 * 书中代码较长，主要问题在类型上：
 *   1. `let data: UnifiedData` —— UnifiedData 不是全局类型，必须写成
 *      unifiedDataChannel.UnifiedData（从 @kit.ArkData 导入）
 *   2. getDataFromUdmfRetry 返回 true/false，但没写返回类型，补成 : boolean
 *   3. 图片资源 app.media.icon 书中未提供，工程里已放 svg 占位图
 */
import { unifiedDataChannel, uniformTypeDescriptor } from '@kit.ArkData';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct DragDemo {
  @State targetImage: string = '';
  @State targetText: string = 'Drag Text';
  @State imageWidth: number = 100;
  @State imageHeight: number = 100;
  @State imgState: Visibility = Visibility.Visible;
  @State abstractContent: string = 'abstract';
  @State textContent: string = '';
  @State backGroundColor: Color = Color.Transparent;

  @Builder
  pixelMapBuilder() {
    Column() {
      Image($r('app.media.icon'))
        .width(120)
        .height(120)
        .backgroundColor(Color.Yellow)
    }
  }

  // 获取 UDMF 数据（第一次可能拿不到，返回 false 让上层重试）
  getDataFromUdmfRetry(event: DragEvent, callback: (data: DragEvent) => void): boolean {
    try {
      let data: unifiedDataChannel.UnifiedData = event.getData();
      if (!data) {
        return false;
      }
      let records: Array<unifiedDataChannel.UnifiedRecord> = data.getRecords();
      if (!records || records.length <= 0) {
        return false;
      }
      callback(event);
      return true;
    } catch (e) {
      console.error(`getData failed, code = ${(e as BusinessError).code}, message = ${(e as BusinessError).message}`);
      return false;
    }
  }

  // 首次获取失败后 1.5s 自动重试
  getDataFromUdmf(event: DragEvent, callback: (data: DragEvent) => void) {
    if (this.getDataFromUdmfRetry(event, callback)) {
      return;
    }
    setTimeout(() => {
      this.getDataFromUdmfRetry(event, callback);
    }, 1500);
  }

  // 根据拖拽发起前的不同阶段改变背景色
  private PreDragChange(preDragStatus: PreDragStatus): void {
    if (preDragStatus == PreDragStatus.READY_TO_TRIGGER_DRAG_ACTION) {
      this.backGroundColor = Color.Red;
    } else if (preDragStatus == PreDragStatus.ACTION_CANCELED_BEFORE_DRAG
      || preDragStatus == PreDragStatus.PREVIEW_LANDING_FINISHED) {
      this.backGroundColor = Color.Blue;
    }
  }

  build() {
    Column() {
      Text('3.3.1 拖拽事件（把左边内容拖到右边区域）')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2F5FD0')
        .width('100%')
        .padding({ top: 14, bottom: 6 })

      Row() {
        // 左：拖出方
        Column() {
          Text('start Drag')
            .fontSize(18)
            .width('100%')
            .height(40)
            .margin(10)
            .backgroundColor('#008888')

          Image($r('app.media.icon'))
            .width(100)
            .height(100)
            .draggable(true)
            .margin({ left: 15 })
            .visibility(this.imgState)
            .onDragEnd((event) => {
              // onDragEnd 里取到的 result 值由接收方 onDrop 设置
              if (event.getResult() === DragResult.DRAG_SUCCESSFUL) {
                this.getUIContext().getPromptAction().showToast({ duration: 1000, message: 'Drag Success' });
              } else if (event.getResult() === DragResult.DRAG_FAILED) {
                this.getUIContext().getPromptAction().showToast({ duration: 1000, message: 'Drag failed' });
              }
            })

          Text('test drag event')
            .width('100%')
            .height(100)
            .draggable(true)
            .margin({ left: 15 })
            .copyOption(CopyOptions.InApp)

          TextArea({ placeholder: 'please input words' })
            .copyOption(CopyOptions.InApp)
            .width('100%')
            .height(50)
            .draggable(true)

          Search({ placeholder: 'please input you word' })
            .searchButton('Search')
            .width('100%')
            .height(80)
            .textFont({ size: 20 })

          Column() {
            Text('this is abstract')
              .fontSize(20)
              .width('100%')
          }
          .margin({ left: 40, top: 20 })
          .width('100%')
          .height(100)
          .onDragStart((event) => {
            this.backGroundColor = Color.Transparent;
            let data: unifiedDataChannel.PlainText = new unifiedDataChannel.PlainText();
            data.abstract = 'this is abstract';
            data.textContent = 'this is content this is content';
            (event as DragEvent).setData(new unifiedDataChannel.UnifiedData(data));
          })
          .onPreDrag((status: PreDragStatus) => {
            this.PreDragChange(status);
          })
          .backgroundColor(this.backGroundColor)
        }
        .width('45%')
        .height('100%')

        // 右：接收方
        Column() {
          Text('Drag Target Area')
            .fontSize(20)
            .width('100%')
            .height(40)
            .margin(10)
            .backgroundColor('#008888')

          Image(this.targetImage)
            .width(this.imageWidth)
            .height(this.imageHeight)
            .draggable(true)
            .margin({ left: 15 })
            .border({ color: Color.Black, width: 1 })
            .allowDrop([uniformTypeDescriptor.UniformDataType.IMAGE])
            .onDrop((dragEvent?: DragEvent) => {
              this.getDataFromUdmf((dragEvent as DragEvent), (event: DragEvent) => {
                let records: Array<unifiedDataChannel.UnifiedRecord> = event.getData().getRecords();
                let rect: Rectangle = event.getPreviewRect();
                this.imageWidth = Number(rect.width);
                this.imageHeight = Number(rect.height);
                this.targetImage = (records[0] as unifiedDataChannel.Image).imageUri;
                event.useCustomDropAnimation = false;
                this.imgState = Visibility.None;
                // 显式设置 result 为 successful，会把结果传回拖出方的 onDragEnd
                event.setResult(DragResult.DRAG_SUCCESSFUL);
              });
            })

          Text(this.targetText)
            .width('100%')
            .height(100)
            .border({ color: Color.Black, width: 1 })
            .margin(15)
            .allowDrop([uniformTypeDescriptor.UniformDataType.PLAIN_TEXT])
            .onDrop((dragEvent?: DragEvent) => {
              this.getDataFromUdmf((dragEvent as DragEvent), (event: DragEvent) => {
                let records: Array<unifiedDataChannel.UnifiedRecord> = event.getData().getRecords();
                let plainText: unifiedDataChannel.PlainText = records[0] as unifiedDataChannel.PlainText;
                this.targetText = plainText.textContent;
              });
            })

          Column() {
            Text(this.abstractContent).fontSize(20).width('100%')
            Text(this.textContent).fontSize(15).width('100%')
          }
          .width('100%')
          .height(100)
          .margin(20)
          .border({ color: Color.Black, width: 1 })
          .allowDrop([uniformTypeDescriptor.UniformDataType.PLAIN_TEXT])
          .onDrop((dragEvent?: DragEvent) => {
            this.getDataFromUdmf((dragEvent as DragEvent), (event: DragEvent) => {
              let records: Array<unifiedDataChannel.UnifiedRecord> = event.getData().getRecords();
              let plainText: unifiedDataChannel.PlainText = records[0] as unifiedDataChannel.PlainText;
              this.abstractContent = plainText.abstract as string;
              this.textContent = plainText.textContent;
            });
          })
        }
        .width('45%')
        .height('100%')
        .margin({ left: '5%' })
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding(10)
    .backgroundColor(Color.White)
  }
}
