/**
 * 3.1.4 图片 Image
 * 书中给出：本地图/网络图/SVG 着色三段片段。
 * 修复点：
 *   1. fillColor(Colo.Red)        -> fillColor(Color.Red)      拼写错误
 *   2. 加载网络图必须在 module.json5 中申请 ohos.permission.INTERNET（已在 module.json5 补好）
 */
@Entry
@Component
struct ImageDemo {
  build() {
    Scroll() {
      Column({ space: 18 }) {
        Text('3.1.4 图片 Image')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2F5FD0')

        // ① 本地图片（media 目录）+ objectFit 缩放模式
        Text('本地图 + ImageFit.Contain').fontSize(13).fontColor('#8A8F99')
        Image($r('app.media.startIcon'))
          .width(200)
          .height(120)
          .objectFit(ImageFit.Contain)   // 保持比例，完整显示
          .backgroundColor('#F1F3F5')
          .borderRadius(8)

        Image($r('app.media.startIcon'))
          .width(200)
          .height(120)
          .objectFit(ImageFit.Cover)     // 保持比例，铺满并裁剪
          .backgroundColor('#F1F3F5')
          .borderRadius(8)

        // ② SVG 矢量图着色：一张图三种颜色（fillColor 只对 svg 生效）
        Text('SVG 矢量图 + fillColor').fontSize(13).fontColor('#8A8F99')
        Row({ space: 12 }) {
          Image($r('app.media.icon'))
            .fillColor(Color.Red)
            .height(40)
            .width(40)
          Image($r('app.media.icon'))
            .fillColor('#0000ff')
            .height(40)
            .width(40)
          Image($r('app.media.icon'))
            .fillColor(0x00ff99)
            .height(40)
            .width(40)
        }

        // ③ 网络图片：需要 INTERNET 权限
        Text('网络图片').fontSize(13).fontColor('#8A8F99')
        Image('https://developer.huawei.com/allianceCmsResource/resource/HUAWEI_Developer_VUE/images/080644.png')
          .height(90)
          .objectFit(ImageFit.Contain)
          .alt($r('app.media.icon'))     // 网络图加载失败时的占位图
          .borderRadius(8)
      }
      .width('100%')
      .padding(20)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}
