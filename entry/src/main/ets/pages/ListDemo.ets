/**
 * 3.2.6 列表 List
 * 书中片段用 // ... 省掉了外层结构，且依赖两个资源：
 *   $r('app.string.peopleOne' / 'peopleTwo')、$r('app.media.iconA' / 'iconB')
 * 补齐内容：
 *   1. 补 @Entry 页面、List 的父容器
 *   2. peopleOne/peopleTwo 已写入 resources/base/element/string.json
 *   3. iconA/iconB 已放 resources/base/media（svg 占位图）
 *   4. JSON.stringify(item) 作为 keyGenerator，保证每条数据唯一标识
 */
import { util } from '@kit.ArkTS';

class Contact {
  public key: string = util.generateRandomUUID(true);   // 随机 UUID 作为唯一键
  public name: ResourceStr;
  public icon: Resource;

  constructor(name: ResourceStr, icon: Resource) {
    this.name = name;
    this.icon = icon;
  }
}

@Entry
@Component
struct ListDemo {
  private contacts: Array<Contact> = [
    new Contact($r('app.string.peopleOne'), $r('app.media.iconA')),
    new Contact($r('app.string.peopleTwo'), $r('app.media.iconB'))
  ];

  build() {
    Column() {
      Text('3.2.6 列表 List')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#2F5FD0')
        .width('100%')
        .padding({ left: 16, top: 16, bottom: 8 })

      List({ space: 4 }) {
        ForEach(this.contacts, (item: Contact) => {
          ListItem() {
            Row() {
              Image(item.icon)
                .width(40)
                .height(40)
                .margin(10)
                .borderRadius(20)
              Text(item.name).fontSize(20)
            }
            .width('100%')
            .justifyContent(FlexAlign.Start)
          }
        }, (item: Contact) => JSON.stringify(item))   // 键值生成器
      }
      .width('100%')
      .layoutWeight(1)
      .divider({ strokeWidth: 1, color: '#EEEEEE' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}
