/**
 * 3.3.3 弹窗与对话框
 * 书中给了两个完整度较高的例子（TipsDialog、AlertDialog），这里合并成一页。
 * 补齐内容：
 *   1. 两段代码原来都是独立的 @Entry 页面，合并后共用同一个 dialogController
 *   2. AlertDialog 用 this.getUIContext().showAlertDialog(...)，必须依赖 UI 上下文
 */
import { TipsDialog } from '@kit.ArkUI';

@Entry
@Component
struct DialogDemo {
  dialogControllerImage: CustomDialogController = new CustomDialogController({
    builder: TipsDialog({
      imageRes: $r('sys.media.ohos_ic_public_voice'),
      content: '想要卸载这个APP嘛?',
      primaryButton: {
        value: '取消',
        action: () => {
          console.info('Callback when the first button is clicked');
        }
      },
      secondaryButton: {
        value: '删除',
        role: ButtonRole.ERROR,
        action: () => {
          console.info('Callback when the second button is clicked');
        }
      },
      onCheckedChange: () => {
        console.info('Callback when the checkbox is clicked');
      }
    })
  });

  build() {
    Column({ space: 16 }) {
      Text('3.3.3 弹窗与对话框')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2F5FD0')

      // ① 上图下文弹出框 TipsDialog
      Button('上图下文弹出框')
        .width(180)
        .height(40)
        .onClick(() => {
          this.dialogControllerImage.open();
        })

      // ② 警告弹窗 AlertDialog（带显示/消失动画）
      Button('AlertDialog Set Duration')
        .width(180)
        .height(40)
        .backgroundColor(0x317aff)
        .onClick(() => {
          this.getUIContext().showAlertDialog(
            {
              title: 'AlertDialog 1',
              message: 'Set Animation Duration open 3 second, close 100ms',
              autoCancel: true,
              alignment: DialogAlignment.Top,
              offset: { dx: 0, dy: -20 },
              gridCount: 3,
              transition: TransitionEffect.asymmetric(
                TransitionEffect.OPACITY
                  .animation({ duration: 3000, curve: Curve.Sharp })
                  .combine(TransitionEffect.scale({ x: 1.5, y: 1.5 })
                    .animation({ duration: 3000, curve: Curve.Sharp })),
                TransitionEffect.OPACITY
                  .animation({ duration: 100, curve: Curve.Smooth })
                  .combine(TransitionEffect.scale({ x: 0.5, y: 0.5 })
                    .animation({ duration: 100, curve: Curve.Smooth }))
              ),
              confirm: {
                value: 'button',
                action: () => {
                  console.info('Button-clicking callback');
                }
              },
              cancel: () => {
                console.info('Closed callbacks');
              }
            }
          );
        })
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(Color.White)
  }
}
