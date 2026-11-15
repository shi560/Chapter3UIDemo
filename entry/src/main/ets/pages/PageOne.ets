/**
 * 3.1.3 配套页面 PageOne
 * 书中“如果实现跳转，需要提前另新建一页面”，这个文件就是那个新页面。
 * 注意：必须在 resources/base/profile/main_pages.json 里注册 "pages/PageOne"。
 */

@Entry
@Component
struct PageOne {
  build() {
    Column({ space: 20 }) {
      Text('PageOne')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2F5FD0')

      Text('这一页是 router.pushUrl 跳转过来的')
        .fontSize(14)
        .fontColor('#8A8F99')

      Button('返回上一页')
        .width('60%')
        .onClick(() => {
          // Router.back() 返回 void，不能接 .catch()
          this.getUIContext().getRouter().back();
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor(Color.White)
  }
}
