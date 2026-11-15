/**
 * 3.3.2 子页 NavPageOne
 * 书中这一段有三处错误，已修正：
 *   1. 声明的是 pathStack，返回按钮里却写 this.navPathStack.pop() —— 变量名不一致
 *   2. NavDestination 的大括号错位（.title 挂到了 build 外面）
 *   3. pop() 返回的 popDestinationInfo 没用到，改成直接 pop()
 * 另外：@Builder 入口函数名必须与 router_map.json 里的 buildFunction 完全一致。
 */
@Builder
export function NavPageOneBuilder() {
  NavPageOne();
}

@Component
struct NavPageOne {
  pathStack: NavPathStack = new NavPathStack();
  @State param: string = '';

  build() {
    NavDestination() {
      Column({ space: 16 }) {
        Text('NavPageOne')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2F5FD0')

        Text(`收到的参数：${this.param}`)
          .fontSize(14)
          .fontColor('#8A8F99')

        Button('返回')
          .width('60%')
          .onClick((event: ClickEvent) => {
            this.pathStack.pop();
          })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
    }
    .title('NavPageOne')
    .backgroundColor(Color.White)
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack;
      this.param = context.pathInfo.param as string;
    })
  }
}
