/**
 * 3.3.2 导航与切换 Navigation
 * 书中给了三段：NavPathStack 控制器、router_map.json 配置、拦截示例。
 * 这一段需要 4 个文件配合，工程里都已补齐：
 *   pages/NavDemo.ets          —— 导航页（本文件，Navigation 根容器）
 *   pages/NavPageOne.ets       —— 子页（NavDestination + @Builder 入口函数）
 *   resources/base/profile/router_map.json —— 系统路由表
 *   module.json5               —— "routerMap": "$profile:router_map"
 *
 * 修复点：
 *   1. 书中拦截示例里写了 'pageTwo' / 'pageOne'，和路由表里的 'PageOne' 大小写不一致，
 *      系统会找不到页面 —— 这里统一成 NavPageOne
 *   2. 拦截回调参数 operation/animated 缺类型，补全
 */
import { hilog } from '@kit.PerformanceAnalysisKit';

const DOMAIN = 0x0000;

@Entry
@Component
struct NavDemo {
  pageStack: NavPathStack = new NavPathStack();

  aboutToAppear(): void {
    // 跳转拦截：把目标为 NavPageTwo 的跳转重定向到 NavPageOne
    this.pageStack.setInterception({
      willShow: (from: NavDestinationContext | 'navBar', to: NavDestinationContext | 'navBar',
        operation: NavigationOperation, isAnimated: boolean) => {
        if (typeof to === 'string') {
          hilog.info(DOMAIN, 'testTag', 'target page is navigation home');
          return;
        }
        let target: NavDestinationContext = to as NavDestinationContext;
        if (target.pathInfo.name === 'NavPageTwo') {
          target.pathStack.pop();
          target.pathStack.pushPathByName('NavPageOne', '被拦截后重定向过来的参数');
        }
      }
    });
  }

  build() {
    Navigation(this.pageStack) {
      Column({ space: 16 }) {
        Text('3.3.2 导航与切换 Navigation')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2F5FD0')
          .width('100%')

        Text('Navigation 需要配合 NavPathStack 使用，子页用 NavDestination 作根容器，\n' +
          '页面信息登记在 resources/base/profile/router_map.json 里。')
          .fontSize(13)
          .fontColor('#8A8F99')
          .width('100%')

        Button('跳转到 NavPageOne（带参数）')
          .width('100%')
          .onClick(() => {
            this.pageStack.pushPathByName('NavPageOne', 'PageOne Param');
          })

        Button('跳转 NavPageTwo（会被拦截重定向）')
          .width('100%')
          .backgroundColor('#7A8BAA')
          .onClick(() => {
            this.pageStack.pushPathByName('NavPageTwo', null);
          })

        Text(`导航栈深度：${this.pageStack.size()}`).fontSize(13).fontColor('#8A8F99')
      }
      .width('100%')
      .padding(20)
      .alignItems(HorizontalAlign.Start)
    }
    .title('Navigation 导航示例')
    .titleMode(NavigationTitleMode.Mini)
    .mode(NavigationMode.Stack)          // 单栏模式，手机上常用
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}
