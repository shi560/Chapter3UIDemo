/**
 * 3.1.5 输入 TextInput
 * 书中给了两个 TextInput 片段（学号/密码），这里补成完整页面并加上 TextArea。
 * 修复点：
 *   1. 两个 TextInput 只是并列语句，缺 @Entry/@Component/build() 外层结构
 *   2. .height('18vp') 这类带单位的写法必须加引号（书中已有注释说明）
 */
@Entry
@Component
struct InputDemo {
  @State stuNo: string = '';
  @State pwd: string = '';
  @State remark: string = '';

  build() {
    Column({ space: 16 }) {
      Text('3.1.5 输入 TextInput')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2F5FD0')

      // ① 学号：只能输入数字 + 四边不同的边框
      TextInput({ placeholder: '请输入你的学号' })
        .type(InputType.Number)
        .fontColor(Color.Blue)
        .height('48vp')
        .border({
          width: { left: 1, right: 2 },
          color: { left: Color.Red, right: Color.Blue },
          style: { left: BorderStyle.Dashed, right: BorderStyle.Dotted }
        })
        .onChange((value: string) => {
          this.stuNo = value;
        })

      // ② 密码：密码态 + 最长 8 位 + 提示语颜色 + px 转 vp
      TextInput({ placeholder: '请输入你的密码' })
        .type(InputType.Password)
        .maxLength(8)
        .placeholderColor(Color.Orange)
        .width(px2vp(600))          // 物理像素转虚拟像素
        .height('48vp')
        .onChange((value: string) => {
          this.pwd = value;
        })

      // ③ 多行文本 TextArea（书中提到的另一类输入组件）
      TextArea({ placeholder: '多行文本输入，超过宽度会自动换行' })
        .height(100)
        .onChange((value: string) => {
          this.remark = value;
        })

      Text(`学号：${this.stuNo}　密码长度：${this.pwd.length}　备注字数：${this.remark.length}`)
        .fontSize(13)
        .fontColor('#8A8F99')
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor(Color.White)
  }
}
