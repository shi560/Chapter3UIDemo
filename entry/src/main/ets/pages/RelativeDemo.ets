/**
 * 3.2.4 相对容器 RelativeContainer
 * 书中用 Record<string, Record<string, string | VerticalAlign | HorizontalAlign>>
 * 声明 alignRules 的锚点表，alignRules() 的真实参数类型是 AlignRuleOption，
 * 直接传 Record 在 ArkTS 严格模式下会类型不匹配。
 * 修复点：
 *   1. 锚点表改用 AlignRuleOption 显式类型
 *   2. .border(BWC) 里的 BWC 是 Record<string, number | string>，同样不是 BorderOptions，
 *      改成 .border({ width: 2, color: '#6699FF' })
 *   3. 补 @Entry（书中只有 @Component），否则不能作为独立页面运行
 */
const AlignRus: AlignRuleOption = {
  top: { anchor: '__container__', align: VerticalAlign.Top },
  left: { anchor: '__container__', align: HorizontalAlign.Start }
};

const AlignRue: AlignRuleOption = {
  top: { anchor: '__container__', align: VerticalAlign.Top },
  right: { anchor: '__container__', align: HorizontalAlign.End }
};

const marginLeft: Margin = { left: 20 };

@Entry
@Component
struct RelativeDemo {
  build() {
    Column({ space: 16 }) {
      Text('3.2.4 相对容器 RelativeContainer')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2F5FD0')

      RelativeContainer() {
        Row() {
          Text('row1')
        }
        .justifyContent(FlexAlign.Center)
        .width(100)
        .height(100)
        .backgroundColor('#a3cf62')
        .alignRules(AlignRus)
        .id('row1')

        Row() {
          Text('row2')
        }
        .justifyContent(FlexAlign.Center)
        .width(100)
        .height(100)
        .backgroundColor('#00ae9d')
        .alignRules(AlignRue)
        .id('row2')
      }
      .width(300)
      .height(300)
      .margin(marginLeft)
      .border({ width: 2, color: '#6699FF' })

      Text('row1 锚定左上角、row2 锚定右上角（锚点都是父容器 __container__）')
        .fontSize(12)
        .fontColor('#8A8F99')
        .width(300)
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(Color.White)
  }
}
