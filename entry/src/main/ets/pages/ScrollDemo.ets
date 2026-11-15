/**
 * 3.3.5 滚动与滑动 - Scroll
 * 书中 ScrollExample 结构完整，补齐：
 *   1. Column 外层加背景色和圆角，滚动区域更清晰
 *   2. onWillScroll 的回调参数补全类型（xOffset/yOffset/scrollState）
 */
import { curves } from '@kit.ArkUI';

@Entry
@Component
struct ScrollDemo {
  scroller: Scroller = new Scroller();
  private arr: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Scroll(this.scroller) {
        Column() {
          ForEach(this.arr, (item: number) => {
            Text(item.toString())
              .width('90%')
              .height(150)
              .backgroundColor(0xFFFFFF)
              .borderRadius(15)
              .fontSize(16)
              .textAlign(TextAlign.Center)
              .margin({ top: 10 })
          }, (item: number) => item.toString())
        }
        .width('100%')
      }
      .scrollable(ScrollDirection.Vertical)   // 纵向滚动
      .scrollBar(BarState.On)                 // 滚动条常驻
      .scrollBarColor(Color.Gray)
      .scrollBarWidth(10)
      .friction(0.6)                          // 摩擦系数
      .edgeEffect(EdgeEffect.None)
      .onWillScroll((xOffset: number, yOffset: number, scrollState: ScrollState) => {
        console.info(`${xOffset} ${yOffset} ${scrollState}`);
      })
      .onScrollEdge((side: Edge) => {
        console.info('To the edge');
      })
      .onScrollStop(() => {
        console.info('Scroll Stop');
      })
      .width('100%')
      .height('100%')

      Button('scroll 150')
        .height('5%')
        .onClick(() => {
          this.scroller.scrollBy(0, 150);     // 相对当前位置滚动 150vp
        })
        .margin({ top: 10, left: 20 })

      Button('scroll 100')
        .height('5%')
        .onClick(() => {
          const yOffset: number = this.scroller.currentOffset().yOffset;
          this.scroller.scrollTo({ xOffset: 0, yOffset: yOffset + 100 });
        })
        .margin({ top: 60, left: 20 })

      Button('scroll 100 + 动画')
        .height('5%')
        .onClick(() => {
          let curve = curves.interpolatingSpring(10, 1, 228, 30);  // 弹簧曲线
          const yOffset: number = this.scroller.currentOffset().yOffset;
          this.scroller.scrollTo({
            xOffset: 0,
            yOffset: yOffset + 100,
            animation: { duration: 1000, curve: curve }
          });
        })
        .margin({ top: 110, left: 20 })

      Button('back top')
        .height('5%')
        .onClick(() => {
          this.scroller.scrollEdge(Edge.Top);  // 回到顶部
        })
        .margin({ top: 160, left: 20 })

      Button('next page')
        .height('5%')
        .onClick(() => {
          this.scroller.scrollPage({ next: true, animation: true });
        })
        .margin({ top: 210, left: 20 })

      Button('fling -3000')
        .height('5%')
        .onClick(() => {
          this.scroller.fling(-3000);          // 惯性滚动
        })
        .margin({ top: 260, left: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(0xDCDCDC)
  }
}
