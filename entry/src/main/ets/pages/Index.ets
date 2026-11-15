import { BusinessError } from '@kit.BasicServicesKit';

/**
 * 第三章 UI设计 —— 示例总目录
 * 教材第3章共 3 节 20 个示例，每节的示例代码都在本工程里补成了可以独立运行的一个页面。
 */
interface DemoItem {
  code: string;   // 小节号
  title: string;  // 小节标题
  desc: string;   // 演示内容
  url: string;    // 对应页面（main_pages.json 中注册过）
}

interface DemoGroup {
  group: string;
  items: DemoItem[];
}

@Entry
@Component
struct Index {
  private groups: DemoGroup[] = [
    {
      group: '3.1 组件',
      items: [
        { code: '3.1.2', title: '文本 Text', desc: '字体/颜色/边界/内外边距/跑马灯', url: 'pages/TextDemo' },
        { code: '3.1.3', title: '按钮 Button', desc: '点击事件 + 页面跳转', url: 'pages/ButtonDemo' },
        { code: '3.1.4', title: '图片 Image', desc: '本地图/网络图/objectFit/SVG着色', url: 'pages/ImageDemo' },
        { code: '3.1.5', title: '输入 TextInput', desc: '输入类型/占位提示/单位换算', url: 'pages/InputDemo' },
        { code: '3.1.6', title: '单选框 Radio', desc: '同组互斥 + onChange 回调', url: 'pages/RadioDemo' },
        { code: '3.1.7', title: '滑动条 Slider', desc: '气泡提示 + 实时数值', url: 'pages/SliderDemo' }
      ]
    },
    {
      group: '3.2 页面布局',
      items: [
        { code: '3.2.1', title: '线性布局', desc: 'Row/Column 还原登录页', url: 'pages/LoginDemo' },
        { code: '3.2.2', title: '层叠布局', desc: 'Stack + zIndex 改变堆叠次序', url: 'pages/StackDemo' },
        { code: '3.2.3', title: '弹性布局', desc: 'flexBasis/flexGrow/flexShrink/alignSelf', url: 'pages/FlexDemo' },
        { code: '3.2.4', title: '相对容器', desc: 'RelativeContainer + alignRules 锚点', url: 'pages/RelativeDemo' },
        { code: '3.2.5', title: '栅格布局', desc: 'GridRow/GridCol 断点适配', url: 'pages/GridDemo' },
        { code: '3.2.6', title: '列表', desc: 'List + ForEach 渲染联系人', url: 'pages/ListDemo' },
        { code: '3.2.7', title: '轮播', desc: 'Swiper + 自定义导航点', url: 'pages/SwiperDemo' }
      ]
    },
    {
      group: '3.3 事件',
      items: [
        { code: '3.3.1', title: '通用事件-触摸', desc: 'onTouch 四种触摸类型', url: 'pages/TouchDemo' },
        { code: '3.3.1', title: '通用事件-拖拽', desc: 'onDragStart/onDrop + UDMF 数据', url: 'pages/DragDemo' },
        { code: '3.3.2', title: '导航与切换', desc: 'Navigation + 系统路由表', url: 'pages/NavDemo' },
        { code: '3.3.3', title: '弹窗与对话框', desc: 'TipsDialog / AlertDialog', url: 'pages/DialogDemo' },
        { code: '3.3.4', title: '手势事件', desc: 'Tap/Pan/Pinch/GestureGroup', url: 'pages/GestureDemo' },
        { code: '3.3.5', title: '滚动与滑动', desc: 'Scroll 控制器 + ScrollBar', url: 'pages/ScrollDemo' }
      ]
    }
  ];

  build() {
    Column() {
      // 顶部标题栏
      Column({ space: 4 }) {
        Text('第3章 UI设计').fontSize(22).fontWeight(FontWeight.Bold).fontColor(Color.White)
        Text('教材示例代码补全版 · 共 20 个可运行示例').fontSize(12).fontColor('#D6E1FF')
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .padding({ left: 20, right: 20, top: 48, bottom: 16 })
      .backgroundColor('#2F5FD0')

      List({ space: 8 }) {
        ForEach(this.groups, (g: DemoGroup) => {
          // 分组标题
          ListItem() {
            Text(g.group)
              .fontSize(15)
              .fontWeight(FontWeight.Bold)
              .fontColor('#2F5FD0')
              .width('100%')
              .padding({ left: 4, top: 14, bottom: 6 })
          }

          // 分组内的每个示例
          ForEach(g.items, (item: DemoItem) => {
            ListItem() {
              Row({ space: 12 }) {
                Text(item.code)
                  .fontSize(11)
                  .fontColor(Color.White)
                  .backgroundColor('#2F5FD0')
                  .borderRadius(4)
                  .padding({ left: 6, right: 6, top: 2, bottom: 2 })

                Column({ space: 2 }) {
                  Text(item.title).fontSize(16).fontColor('#182431')
                  Text(item.desc).fontSize(12).fontColor('#8A8F99')
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Text('›').fontSize(20).fontColor('#B5BAC4')
              }
              .width('100%')
              .padding(12)
              .backgroundColor(Color.White)
              .borderRadius(10)
            }
            .onClick(() => {
              this.getUIContext().getRouter().pushUrl({ url: item.url })
                .catch((err: BusinessError) => {
                  console.error(`跳转失败: code=${err.code}, message=${err.message}`);
                });
            })
          }, (item: DemoItem) => item.code + item.url)
        }, (g: DemoGroup) => g.group)
      }
      .layoutWeight(1)
      .width('100%')
      .padding({ left: 12, right: 12, bottom: 12 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}
