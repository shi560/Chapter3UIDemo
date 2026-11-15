/**
 * 3.1.6 单选框 Radio
 * 书中片段的大括号是错位的（Column 里多一个 }、Row 被写在 Column 外面），
 * 这里按“两个 Row 各放一个 Radio + Text”的结构补完整。
 * 修复点：
 *   1. 书中 Column(){ Row(){...} } } 多了一个右括号 -> 结构重排
 *   2. Radio 只有图标，必须配 Text 使用，通常用 Row/Column 组合
 *   3. Radio 的 value 必须不同、group 必须相同，才能互斥
 */
@Entry
@Component
struct RadioDemo {
  @State gender: string = '男';

  build() {
    Column({ space: 20 }) {
      Text('3.1.6 单选框 Radio')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2F5FD0')

      Column({ space: 8 }) {
        Row({ space: 8 }) {
          Radio({ value: 'r1', group: 'group1' })
            .checked(this.gender === '男')
            .onChange((isChecked: boolean) => {
              if (isChecked) {
                this.gender = '男';
                console.info('我是男生');
              }
            })
          Text('男').fontSize(16)
        }

        Row({ space: 8 }) {
          Radio({ value: 'r2', group: 'group1' })
            .checked(this.gender === '女')
            .onChange((isChecked: boolean) => {
              if (isChecked) {
                this.gender = '女';
                console.info('我是女生');
              }
            })
          Text('女').fontSize(16)
        }
      }
      .alignItems(HorizontalAlign.Start)
      .padding(12)
      .borderRadius(8)
      .backgroundColor('#F1F3F5')

      Text(`当前选择：${this.gender}`).fontSize(16).fontColor('#2F5FD0')

      // 书中提到的 Toggle（勾选框/开关）也演示一下
      Row({ space: 12 }) {
        Text('消息通知').fontSize(16)
        Toggle({ type: ToggleType.Switch, isOn: true })
      }
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(Color.White)
  }
}
