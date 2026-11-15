/**
 * 3.3.4 手势事件 Gesture
 * 书中这一节全是零散片段（.gesture(...) 挂在谁身上都没写），这里补成 4 个可交互的方块：
 *   ① TapGesture 双击      ② PanGesture 滑动方向
 *   ③ GestureGroup 单击+双击共存   ④ PinchGesture 捏合缩放
 * 说明：书中最后的“隔空手势”依赖 inputKit.AIR_GESTURE 与相机权限，属于设备能力，
 *       模拟器不支持，这里不纳入可运行示例（保留在文档对照表里说明）。
 */
@Entry
@Component
struct GestureDemo {
  @State doubleTapText: string = '双击我';
  @State panText: string = '左右滑动我';
  @State groupText: string = '单击/双击我';
  @State scaleValue: number = 1;

  build() {
    Scroll() {
      Column({ space: 16 }) {
        Text('3.3.4 手势事件')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2F5FD0')

        // ① 双击
        Column() {
          Text(this.doubleTapText).fontSize(16).fontColor(Color.White)
        }
        .width('90%')
        .height(100)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#5C6BC0')
        .borderRadius(10)
        .gesture(
          TapGesture({ count: 2 })                 // count:2 表示双击
            .onAction(() => {
              this.doubleTapText = '双击成功！';
              console.info('双击事件触发');
            })
        )

        // ② 滑动方向：根据 offsetX 判断左右
        Column() {
          Text(this.panText).fontSize(16).fontColor(Color.White)
        }
        .width('90%')
        .height(100)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#26A69A')
        .borderRadius(10)
        .gesture(
          PanGesture()
            .onActionUpdate((event: GestureEvent) => {
              if (event.offsetX > 0) {
                this.panText = '向右滑 →';
              }
              if (event.offsetX < 0) {
                this.panText = '← 向左滑';
              }
            })
        )

        // ③ 单击与双击共存：GestureGroup 并行模式
        Column() {
          Text(this.groupText).fontSize(16).fontColor(Color.White)
        }
        .width('90%')
        .height(100)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#EF5350')
        .borderRadius(10)
        .gesture(
          GestureGroup(
            GestureMode.Parallel,
            TapGesture({ count: 1 }).onAction(() => {
              this.groupText = '单击';
            }),
            TapGesture({ count: 2 }).onAction(() => {
              this.groupText = '双击';
            })
          )
        )

        // ④ 捏合缩放（书中用于相机变焦，这里用缩放一个方块代替）
        Column() {
          Text('双指捏合').fontSize(16).fontColor(Color.White)
        }
        .width(120)
        .height(120)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#FFA726')
        .borderRadius(10)
        .scale({ x: this.scaleValue, y: this.scaleValue })
        .gesture(
          PinchGesture({ fingers: 2 })             // 双指操作
            .onActionUpdate((event: GestureEvent) => {
              this.scaleValue = event.scale;
            })
            .onActionEnd(() => {
              console.info(`最终缩放比例：${this.scaleValue}`);
            })
        )

        Text(`当前缩放比例：${this.scaleValue.toFixed(2)}`).fontSize(12).fontColor('#8A8F99')
      }
      .width('100%')
      .padding(20)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}
