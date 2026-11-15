/**
 * 3.2.5 栅格布局 GridRow / GridCol
 * 书中代码结构完整，补齐两处：
 *   1. .onBreakpointChange((breakpoint) => ...) 的参数缺类型，补成 (breakpoint: string)
 *   2. 增加断点文字显示，方便观察不同屏宽下的变化
 */
@Entry
@Component
struct GridDemo {
  @State bgColors: Color[] = [Color.Red, Color.Orange, Color.Yellow, Color.Green, Color.Pink,
    Color.Grey, Color.Blue, Color.Brown];
  @State currentBp: string = 'unknown';

  build() {
    Column({ space: 12 }) {
      Text('3.2.5 栅格布局 GridRow')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2F5FD0')

      Text(`当前断点：${this.currentBp}（xs 手机竖屏 / sm 手机横屏 / md 折叠屏 / lg 平板）`)
        .fontSize(12)
        .fontColor('#8A8F99')

      GridRow({
        columns: 5,                     // 5 列
        gutter: { x: 5, y: 10 },        // 列间距 / 行间距
        breakpoints: {
          value: ['400vp', '600vp', '800vp'],
          reference: BreakpointsReference.WindowSize
        },
        direction: GridRowDirection.Row
      }) {
        ForEach(this.bgColors, (color: Color) => {
          GridCol({ span: { xs: 1, sm: 2, md: 3, lg: 4 }, offset: 0, order: 0 }) {
            Row().width('100%').height('20vp')
          }
          .borderColor(color)
          .borderWidth(2)
        }, (color: Color) => color.toString())
      }
      .width('100%')
      .height(200)
      .onBreakpointChange((breakpoint: string) => {
        this.currentBp = breakpoint;
      })
    }
    .width('80%')
    .height('100%')
    .margin({ left: 10, top: 5, bottom: 5 })
    .border({ color: '#880606', width: 2 })
    .padding(8)
  }
}
