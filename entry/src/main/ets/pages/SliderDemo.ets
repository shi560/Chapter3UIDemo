/**
 * 3.1.7 滑动条 Slider
 * 书中 SliderExample 少了 3 个右括号（Column/builder/struct 都没闭合），
 * 这里补齐成完整可运行的结构。
 * 修复点：
 *   1. build() 里 Column({ space: 8 }){ ... } 未闭合
 *   2. .width('80%') 后面缺 Column 的 } 和 build() 的 }
 *   3. 缺少最外层 struct 的 }
 */
@Entry
@Component
struct SliderDemo {
  @State outSetValueOne: number = 20;
  @State inSetValue: number = 40;

  build() {
    Column({ space: 8 }) {
      Text('3.1.7 滑动条 Slider')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2F5FD0')

      Text('outset slider').fontSize(12).fontColor(0xCCCCCC).width('90%').margin(15)
      Row() {
        Slider({
          value: this.outSetValueOne,
          min: 0,
          max: 100,
          style: SliderStyle.OutSet
        })
          .showTips(true)                                  // 滑动时显示气泡提示
          .onChange((value: number, mode: SliderChangeMode) => {
            this.outSetValueOne = value;
            console.info('value:' + value + ' mode:' + mode.toString());
          })
        // toFixed(0) 把返回值处理成整数精度
        Text(this.outSetValueOne.toFixed(0)).fontSize(12)
      }
      .width('80%')

      Text('inset slider + 刻度').fontSize(12).fontColor(0xCCCCCC).width('90%').margin(15)
      Row() {
        Slider({
          value: this.inSetValue,
          min: 0,
          max: 100,
          step: 10,
          style: SliderStyle.InSet
        })
          .showSteps(true)                                  // 显示刻度点
          .blockColor(Color.Blue)
          .onChange((value: number) => {
            this.inSetValue = value;
          })
        Text(this.inSetValue.toFixed(0)).fontSize(12)
      }
      .width('80%')
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(Color.White)
  }
}
