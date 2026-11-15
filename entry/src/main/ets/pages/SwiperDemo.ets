/**
 * 3.2.7 轮播 Swiper
 * 书中的片段有两个导致编译失败的地方：
 *   1. `.indicator{` 语法错误 —— indicator 是属性，必须写成 .indicator(构造器)
 *      自定义导航点用 DotIndicator 对象
 *   2. Image 上写了 .textAlign()/.fontSize() —— 那是 Text 的属性，Image 没有，删掉
 *   3. Swiper 未闭合、未写宽高
 *   4. app.media.Image1~3 书中未提供，工程里用三张 svg 占位图补齐
 */
@Entry
@Component
struct SwiperDemo {
  @State currentIndex: number = 0;

  build() {
    Column({ space: 12 }) {
      Text('3.2.7 轮播 Swiper')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2F5FD0')

      Swiper() {
        Image($r('app.media.image1'))
          .width('90%')
          .height('100%')
          .backgroundColor(Color.Gray)
          .objectFit(ImageFit.Cover)
        Image($r('app.media.image2'))
          .width('90%')
          .height('100%')
          .backgroundColor(Color.Green)
          .objectFit(ImageFit.Cover)
        Image($r('app.media.image3'))
          .width('90%')
          .height('100%')
          .backgroundColor(Color.Pink)
          .objectFit(ImageFit.Cover)
      }
      .width('100%')
      .height(220)
      .loop(true)                       // 循环播放
      .autoPlay(true)                   // 自动播放
      .interval(2000)                   // 播放间隔
      .indicator(new DotIndicator()     // 自定义导航点
        .left(0)
        .itemWidth(15)
        .itemHeight(15)
        .selectedItemWidth(30)
        .selectedItemHeight(15)
        .color(Color.Red)
        .selectedColor(Color.Blue))
      .onChange((index: number) => {
        this.currentIndex = index;
      })

      Text(`当前第 ${this.currentIndex + 1} 张`).fontSize(13).fontColor('#8A8F99')
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(Color.White)
  }
}
