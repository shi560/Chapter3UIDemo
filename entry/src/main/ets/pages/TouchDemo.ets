/**
 * 3.3.1 通用事件 - 触摸事件 onTouch
 * 书中代码结构完整，补齐两点：
 *   1. @State text 初始为空，页面进入后是大片空白，给个默认提示
 *   2. 手指在按钮上按下时，按钮自身的点击涟漪会影响观感，这里保留原样只补说明
 */
@Entry
@Component
struct TouchDemo {
  @State text: string = '在按钮上按下、移动、抬起试试';
  @State eventType: string = '';

  build() {
    Column() {
      Text('3.3.1 触摸事件 onTouch')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2F5FD0')

      Button('Touch')
        .height(40)
        .width(100)
        .margin({ top: 12 })
        .onTouch((event?: TouchEvent) => {
          if (event && event.sourceTool === SourceTool.Finger) {   // 只处理手指触摸
            if (event.type === TouchType.Down) {
              this.eventType = 'Down';
            }
            if (event.type === TouchType.Up) {
              this.eventType = 'Up';
            }
            if (event.type === TouchType.Move) {
              this.eventType = 'Move';
            }
            // 1. 按住屏幕同时点 Home 键返回桌面会触发 Cancel
            // 2. 折叠屏在按住时折叠，切换到外屏会触发 Cancel
            if (event.type === TouchType.Cancel) {
              this.eventType = 'Cancel';
            }
            if (event.touches) {
              this.text = 'TouchType:' + this.eventType
                + '\nDistance between touch point and touch element:'
                + '\n  x: ' + event.touches[0].x + '\n  y: ' + event.touches[0].y
                + '\n  width: ' + event.touches[0].width + '\n  height: ' + event.touches[0].height
                + '\n  pressedTime: ' + event.touches[0].pressedTime
                + '\n  pressure: ' + event.touches[0].pressure
                + '\nComponent globalPos:'
                + '\n  x: ' + event.target.area.globalPosition.x
                + '\n  y: ' + event.target.area.globalPosition.y
                + '\n  width: ' + event.target.area.width + '\n  height: ' + event.target.area.height
                + '\ntargetDisplayId: ' + event.targetDisplayId;
            }
          }
        })

      Button('Touch')
        .height(50)
        .width(200)
        .margin(20)
        .onTouch((event?: TouchEvent) => {
          if (event) {
            if (event.type === TouchType.Down) {
              this.eventType = 'Down';
            }
            if (event.type === TouchType.Up) {
              this.eventType = 'Up';
            }
            if (event.type === TouchType.Move) {
              this.eventType = 'Move';
            }
            if (event.type === TouchType.Cancel) {
              this.eventType = 'Cancel';
            }
            if (event.touches) {
              this.text = 'TouchType:' + this.eventType
                + '\nDistance between touch point and touch element:'
                + '\n  x: ' + event.touches[0].x + '\n  y: ' + event.touches[0].y
                + '\n  width: ' + event.touches[0].width + '\n  height: ' + event.touches[0].height
                + '\n  pressedTime: ' + event.touches[0].pressedTime
                + '\n  pressure: ' + event.touches[0].pressure
                + '\nComponent globalPos:'
                + '\n  x: ' + event.target.area.globalPosition.x
                + '\n  y: ' + event.target.area.globalPosition.y
                + '\n  width: ' + event.target.area.width + '\n  height: ' + event.target.area.height
                + '\ntargetDisplayId: ' + event.targetDisplayId;
            }
          }
        })

      Text(this.text)
        .fontSize(12)
        .width('100%')
        .padding(8)
        .backgroundColor('#F1F3F5')
        .borderRadius(6)
        .margin({ top: 10 })
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(Color.White)
  }
}
