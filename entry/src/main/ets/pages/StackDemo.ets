/**
 * 3.2.2 层叠布局 Stack
 * 书中片段只有 struct StackExample { build() {...} }，缺装饰器、缺 zIndex 状态变量。
 * 修复点：
 *   1. 补 @Entry @Component，页面才能独立运行
 *   2. this.zIndex 未定义 -> 补 @State zIndex: number = 0
 *   3. 两个 Text('Item 2') 重名 -> 改为 Item 1/2/3
 *   4. .backgroundColor(0xd2cab3). 换行后接 .align(...) 的写法可读性差，这里排成一行链式调用
 */
@Entry
@Component
struct StackDemo {
  @State zIndexBase: number = 0;   // 不能叫 zIndex，会和组件通用属性方法同名

  build() {
    Column({ space: 10 }) {
      Text('3.2.2 层叠布局 Stack')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2F5FD0')
        .margin({ top: 10 })

      // Stack 内的子元素依次入栈，后入的盖住先入的
      Stack({ alignContent: Alignment.Center }) {
        Text('Stack')
          .width('90%')
          .height('100%')
          .backgroundColor('#e1dede')
          .align(Alignment.BottomEnd)

        Text('Item 1')
          .width('70%')
          .height('80%')
          .backgroundColor(0xd2cab3)
          .align(Alignment.BottomEnd)
          .zIndex(this.zIndexBase)

        Text('Item 2')
          .width('50%')
          .height('60%')
          .backgroundColor(0xc1cbac)
          .align(Alignment.BottomEnd)
          .zIndex((this.zIndexBase + 1) % 3)

        Text('Item 3')
          .width('40%')
          .height('40%')
          .backgroundColor(Color.Yellow)
          .align(Alignment.BottomEnd)
          .zIndex((this.zIndexBase + 2) % 3)
      }
      .width('100%')
      .height(150)
      .margin({ top: 5 })

      Text(`当前 zIndex 基准值：${this.zIndexBase}`).fontSize(13).fontColor('#8A8F99')

      Button('改变堆叠次序')
        .onClick(() => {
          this.zIndexBase = (this.zIndexBase + 1) % 3;
        })
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor(Color.White)
  }
}
