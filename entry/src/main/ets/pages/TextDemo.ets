/**
 * 3.1.2 文本 Text
 * 书中给了两段零散属性写法（.Height(100)、字体、边界等），这里补成一个完整页面。
 * 修复点：
 *   1. .Height(100)   -> .height(100)     组件属性名首字母必须小写
 *   2. 资源 $r('app.float.page_text_font_size') 需要在 float.json 中定义（已补：24fp）
 */
@Entry
@Component
struct TextDemo {
  @State message: string = 'Application Development based on Harmony Next OS';

  build() {
    Column({ space: 24 }) {
      Text('3.1.2 文本 Text')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2F5FD0')

      // ① 书中“组件通用属性”示例：字体颜色/大小/粗细/对齐/风格/字体/高/背景色
      Text('鸿蒙应用开发')
        .fontColor(Color.Blue)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .textAlign(TextAlign.Center)
        .fontStyle(FontStyle.Italic)
        .fontFamily('宋体')
        .height(100)                       // 书中写成 .Height(100)，首字母大写会编译报错
        .width('90%')
        .backgroundColor(Color.Red)
        .borderRadius(8)

      // ② 书中“边界/内边距/外边距”示例 + 跑马灯溢出效果
      Text(this.message)
        .fontSize($r('app.float.page_text_font_size'))
        .fontColor(Color.White)
        .backgroundColor('#345566ff')      // 8 位十六进制：ARGB，前两位是透明度
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.MARQUEE })
        .width('90%')
        .margin(20)
        .padding(12)
        .border({
          width: 1,
          color: '#3274f6',
          style: BorderStyle.Solid
        })

      // ③ Span 行内富文本（3.2.1 登录页也用到）
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
      .fontSize(16)
      .margin(10)
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor(Color.White)
  }
}
