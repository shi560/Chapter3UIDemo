/**
 * 3.2.3 弹性布局 Flex
 * 书中 FlexExample 已是完整结构，这里保留原样并做两处整理：
 *   1. 补页面标题，方便从目录页进入后知道自己在哪一节
 *   2. 外层 Column 高度撑满，避免内容贴顶
 */
@Entry
@Component
struct FlexDemo {
  build() {
    Scroll() {
      Column({ space: 5 }) {
        Text('3.2.3 弹性布局 Flex')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2F5FD0')
          .width('90%')
          .margin({ top: 10 })

        // ① flexBasis：主轴方向的基准尺寸
        Text('flexBasis').fontSize(9).fontColor(0xCCCCCC).width('90%')
        Flex() {
          Text('flexBasis(100)')
            .flexBasis(100)              // 相当于宽度 100vp
            .height(100)
            .backgroundColor(0xF5DEB3)
            .textAlign(TextAlign.Center)
          Text(`flexBasis('auto')`)
            .flexBasis('auto')           // 保持自身设置的 60% 宽度
            .width('60%')
            .height(100)
            .backgroundColor(0xD2B48C)
            .textAlign(TextAlign.Center)
        }
        .width('90%')
        .height(120)
        .padding(10)
        .backgroundColor(0xAFEEEE)

        // ② flexGrow：剩余空间的分配比例
        Text('flexGrow').fontSize(9).fontColor(0xCCCCCC).width('90%')
        Flex() {
          Text('flexGrow(2)')
            .flexGrow(2)                 // 占剩余宽度的 2/3
            .height(100)
            .backgroundColor(0xF5DEB3)
            .textAlign(TextAlign.Center)
          Text('flexGrow(1)')
            .flexGrow(1)                 // 占剩余宽度的 1/3
            .height(100)
            .backgroundColor(0xD2B48C)
            .textAlign(TextAlign.Center)
        }
        .width('90%')
        .height(120)
        .padding(10)
        .backgroundColor(0xAFEEEE)

        // ③ flexShrink：超出总尺寸时的压缩比例
        Text('flexShrink').fontSize(9).fontColor(0xCCCCCC).width('90%')
        Flex({ direction: FlexDirection.Row }) {
          Text('flexShrink(0)')
            .flexShrink(0)               // 不压缩
            .width('50%')
            .height(100)
            .backgroundColor(0xF5DEB3)
            .textAlign(TextAlign.Center)
          Text('default flexShrink')     // 默认值为 1
            .width('40%')
            .height(100)
            .backgroundColor(0xD2B48C)
            .textAlign(TextAlign.Center)
          Text('flexShrink(1)')
            .flexShrink(1)
            .width('40%')
            .height(100)
            .backgroundColor(0xF5DEB3)
            .textAlign(TextAlign.Center)
        }
        .width('90%')
        .height(120)
        .padding(10)
        .backgroundColor(0xAFEEEE)

        // ④ alignSelf：覆盖容器的 alignItems
        Text('alignSelf').fontSize(9).fontColor(0xCCCCCC).width('90%')
        Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Center }) {
          Text('no alignSelf,height:70')
            .width('33%')
            .height(70)
            .backgroundColor(0xF5DEB3)
            .textAlign(TextAlign.Center)
          Text('alignSelf End')
            .alignSelf(ItemAlign.End)
            .width('33%')
            .height(70)
            .backgroundColor(0xD2B48C)
            .textAlign(TextAlign.Center)
          Text('no alignSelf,height:100%')
            .width('34%')
            .height('100%')
            .backgroundColor(0xF5DEB3)
            .textAlign(TextAlign.Center)
        }
        .width('90%')
        .height(120)
        .padding(10)
        .backgroundColor(0xAFEEEE)
      }
      .width('100%')
      .margin({ top: 5, bottom: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}
