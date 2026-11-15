import { BusinessError } from '@kit.BasicServicesKit';

/**
 * 3.1.3 按钮 Button
 * 书中给了 / 三种零散片段：属性版点击事件、Smart Hint 自动生成版、跳转版。
 * 这里补成一个完整页面：点击改文字 + 跳转到 PageOne。
 * 修复点：
 *   1. “Button .onClick(...)” 少了括号，必须是 Button('文字').onClick(...)
 *   2. pushUrl 是 Promise，书中未处理失败回调；这里补 .catch
 */
@Entry
@Component
struct ButtonDemo {
  @State message: string = 'Application Development based on Harmony Next OS';
  @State clickCount: number = 0;

  build() {
    Column({ space: 20 }) {
      Text('3.1.3 按钮 Button')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2F5FD0')

      Text(this.message)
        .fontSize(16)
        .textAlign(TextAlign.Center)
        .width('90%')
        .margin({ top: 10 })

      Text(`点击次数：${this.clickCount}`).fontSize(14).fontColor('#8A8F99')

      // ① 书中“按钮属性 + 点击事件”
      Button('点击事件')
        .type(ButtonType.Capsule)      // 按钮形状：胶囊
        .stateEffect(true)             // 点击时的波纹/高亮反馈
        .padding({
          top: 10,
          right: 20,
          bottom: 10,
          left: 20
        })
        .onClick(() => {               // 箭头函数实现点击事件
          this.clickCount++;
          this.message = '鸿蒙应用开发课程是双语课程！';
        })

      // ② Smart Hint 自动生成的写法（带 ClickEvent 参数）
      Button('Smart Hint 写法')
        .onClick((event: ClickEvent) => {
          console.info(`按钮被点击，时间戳：${event.timestamp}`);
          this.clickCount++;
        })

      // ③ 页面跳转：需要先新建 PageOne 页面，并在 main_pages.json 中注册
      Button('跳转到 PageOne')
        .backgroundColor('#2F5FD0')
        .width('60%')
        .onClick(() => {
          this.getUIContext().getRouter().pushUrl({ url: 'pages/PageOne' })
            .catch((err: BusinessError) => {
              console.error(`跳转失败: code=${err.code}, message=${err.message}`);
            });
        })
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor(Color.White)
  }
}
