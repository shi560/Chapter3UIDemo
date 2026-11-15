/**
 * 3.2.1 线性布局（Login 登录页）
 * 书中这一节的源码基本完整，但有两处会导致编译/运行不符预期：
 *   修复点：
 *   1. `.borderRadius(5) 圆角边框` —— 中文没注释掉，编译器直接报错，改成 // 圆角边框
 *   2. `Blank().height(150)` —— Blank 是靠 layoutWeight 撑满剩余空间的，height 不生效，改为 Blank()
 *   3. 图片资源 weixin/alipay/huawei 书中未提供，工程里已用占位 svg 补齐
 */
@Entry
@Component
struct LoginDemo {
  @State message: string = 'Hello World';
  @State account: string = '';
  @State password: string = '';

  build() {
    Column() {
      // ① 顶部品牌区：Image + Text，垂直排列
      Column() {
        Image($r('app.media.startIcon'))
          .width(78)
          .height(78)
          .margin(8)

        Text('登录界面')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor('#182431')
          .borderRadius(5)          // 圆角边框

        Text() {
          Span('登录').letterSpacing(-2)
          Span('login').textCase(TextCase.LowerCase)
          Span('账号').decoration({
            type: TextDecorationType.Underline,
            color: Color.Blue,
            style: TextDecorationStyle.WAVY
          })
          Span(' 以获得更多服务').letterSpacing(3)
        }
        .fontSize(14)
        .margin({ top: 8, bottom: 12 })
      }
      .width('100%')
      .padding({ top: 60, bottom: 40 })
      .backgroundColor('#f1f3f5')
      .justifyContent(FlexAlign.Center)

      // ② 输入区：两个 TextInput，中间一条分割线
      Column({ space: 6 }) {
        TextInput({ placeholder: '请输入你的账号', text: this.account })
          .type(InputType.Number)
          .height('48vp')
          .onChange((value: string) => {
            this.account = value;
          })

        Line()
          .width('100%')
          .height(1)
          .backgroundColor('#0d182431')

        TextInput({ placeholder: '请输入你密码', text: this.password })
          .type(InputType.Password)
          .height('48vp')
          .onChange((value: string) => {
            this.password = value;
          })
      }
      .margin(20)
      .padding({ left: 12, right: 12 })
      .backgroundColor(Color.White)
      .borderRadius(24)

      // ③ 辅助操作：两端对齐的两个 Text
      Row() {
        Text('短信验证码登录').fontColor(Color.Blue).fontSize(14)
        Text('忘记密码').fontColor(Color.Blue).fontSize(14)
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .margin({ top: 12 })
      .padding({ left: 12, right: 12 })

      // ④ 按钮区
      Column({ space: 8 }) {
        Button('登录')
          .onClick((event: ClickEvent) => {
            this.getUIContext().getPromptAction().showToast({
              message: `账号 ${this.account || '(空)'} 正在登录`
            });
          })
          .type(ButtonType.Capsule)
          .width('90%')

        Text('注册账号')
          .onClick((event: ClickEvent) => {
            this.getUIContext().getPromptAction().showToast({ message: '跳转注册页' });
          })
          .textAlign(TextAlign.Center)
          .fontSize(14)
          .fontColor('#2F5FD0')
          .width('100%')
      }
      .margin(40)

      Blank()   // 撑开剩余空间，把第三方登录推到底部

      // ⑤ 第三方登录
      Row({ space: 50 }) {
        Image($r('app.media.weixin')).width(28).height(28).borderRadius(14)
        Image($r('app.media.alipay')).width(28).height(28).borderRadius(14)
        Image($r('app.media.huawei')).width(28).height(28).borderRadius(14)
      }
      .margin({ bottom: 30 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}
