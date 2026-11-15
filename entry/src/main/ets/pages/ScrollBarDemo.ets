/**
 * 3.3.5 滚动与滑动 - ScrollBar 自定义滚动条
 * 书中 ScrollBarExample 结构完整，补齐：
 *   1. 书中 `ScrollBar({ ... direction: ScrollBarDirection.\nVertical ...})` 是排版换行，
 *      代码里必须写在一行（或合法换行），这里整理成单行
 *   2. 外层 Column 补高度，否则 ScrollBar 高度算不出来
 */
@Entry
@Component
struct ScrollBarDemo {
  private scroller: Scroller = new Scroller();
  private arr: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];

  build() {
    Column() {
      Text('3.3.5 自定义滚动条 ScrollBar')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2F5FD0')
        .width('100%')
        .padding({ top: 14, bottom: 8 })

      Stack({ alignContent: Alignment.End }) {
        Scroll(this.scroller) {
          Flex({ direction: FlexDirection.Column }) {
            ForEach(this.arr, (item: number) => {
              Row() {
                Text(item.toString())
                  .width('80%')
                  .height(60)
                  .backgroundColor('#3366CC')
                  .borderRadius(15)
                  .fontSize(16)
                  .textAlign(TextAlign.Center)
                  .margin({ top: 5 })
              }
            }, (item: number) => item.toString())
          }
          .margin({ right: 15 })
        }
        .width('90%')
        .height('100%')
        .scrollBar(BarState.Off)
        .scrollable(ScrollDirection.Vertical)

        // ScrollBar 三个主要属性：scroller / direction / state
        ScrollBar({
          scroller: this.scroller,
          direction: ScrollBarDirection.Vertical,
          state: BarState.Auto
        }) {
          Text()
            .width(20)
            .height(100)
            .borderRadius(10)
            .backgroundColor('#C0C0C0')
        }
        .width(20)
        .backgroundColor('#ededed')
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}
