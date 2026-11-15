# Chapter3UIDemo —— 《基于 HarmonyOS NEXT 的应用开发》第3章 UI设计 代码补全版

把教材**第3章 UI设计**（3.1 组件 / 3.2 页面布局 / 3.3 事件，共 19 个小节）里给出的
代码片段，逐段补成能在 DevEco Studio 里直接运行的完整页面。

仓库地址：<https://github.com/shi560/Chapter3UIDemo>（Private）

- 开发环境：DevEco Studio 26.0.0（SDK API 26）、hvigor 6.26.8
- 工程类型：Stage 模型 / ArkTS
- 兼容版本：compatibleSdkVersion 5.0.0(12)
- 编译结果：`hvigorw assembleHap` **BUILD SUCCESSFUL**，产物 `entry/build/default/outputs/default/entry-default-unsigned.hap`

## 一、目录结构

```
Chapter3UIDemo/
├── AppScope/                               应用级配置（bundleName、图标、应用名）
├── entry/                                  主模块
│   ├── src/main/
│   │   ├── ets/
│   │   │   ├── entryability/EntryAbility.ets   应用入口，加载 pages/Index
│   │   │   └── pages/                          第3章全部示例页面（22 个）
│   │   ├── module.json5                    模块配置（网络权限 + 系统路由表）
│   │   └── resources/base/
│   │       ├── element/{string,color,float}.json
│   │       ├── media/                      占位图（svg：图标、轮播图、联系人头像）
│   │       └── profile/
│   │           ├── main_pages.json         页面注册表
│   │           └── router_map.json         Navigation 系统路由表
├── docs/
│   ├── 第三章代码补充对照表.md              ← 每一节：书中原样 → 问题 → 补充了什么
│   └── 运行与上传GitHub操作手册.md          ← DevEco 里怎么跑起来、怎么传到 GitHub
├── build-profile.json5                     工程级构建配置
├── hvigorfile.ts / oh-package.json5
└── hvigor/hvigor-config.json5
```

## 二、页面清单（首页是目录，点进去看效果）

| 小节 | 页面 | 演示内容 |
|---|---|---|
| 3.1.2 | `TextDemo.ets` | Text 字体/颜色/边界/内外边距/跑马灯/Span 行内富文本 |
| 3.1.3 | `ButtonDemo.ets` + `PageOne.ets` | Button 属性、三种点击事件写法、router 跳转 |
| 3.1.4 | `ImageDemo.ets` | 本地图/网络图/objectFit/SVG fillColor 着色 |
| 3.1.5 | `InputDemo.ets` | TextInput 输入类型、四边不同边框、px2vp、TextArea |
| 3.1.6 | `RadioDemo.ets` | Radio 同组互斥 + onChange、Toggle |
| 3.1.7 | `SliderDemo.ets` | Slider 气泡/刻度/实时值 |
| 3.2.1 | `LoginDemo.ets` | Row/Column 还原登录页 |
| 3.2.2 | `StackDemo.ets` | Stack 层叠 + zIndex 动态换序 |
| 3.2.3 | `FlexDemo.ets` | flexBasis/flexGrow/flexShrink/alignSelf |
| 3.2.4 | `RelativeDemo.ets` | RelativeContainer + alignRules 锚点 |
| 3.2.5 | `GridDemo.ets` | GridRow/GridCol 断点适配 |
| 3.2.6 | `ListDemo.ets` | List + ForEach + 键值生成器 |
| 3.2.7 | `SwiperDemo.ets` | Swiper + DotIndicator 自定义导航点 |
| 3.3.1 | `TouchDemo.ets` | onTouch 的 Down/Move/Up/Cancel |
| 3.3.1 | `DragDemo.ets` | onDragStart/onDrop + UDMF 数据搬运 |
| 3.3.2 | `NavDemo.ets` + `NavPageOne.ets` | Navigation + NavPathStack + 系统路由表 + 跳转拦截 |
| 3.3.3 | `DialogDemo.ets` | TipsDialog（上图下文）/ AlertDialog（带动画） |
| 3.3.4 | `GestureDemo.ets` | TapGesture / PanGesture / GestureGroup / PinchGesture |
| 3.3.5 | `ScrollDemo.ets` | Scroll 控制器全部方法 |
| 3.3.5 | `ScrollBarDemo.ets` | ScrollBar 自定义滚动条 |

## 三、怎么跑（已实测）

见 `docs/运行与上传GitHub操作手册.md`，完整流程三步：

1. **打开工程**：DevEco Studio →「文件 > 打开」选本目录 →「立即同步」，等构建窗口出现 `BUILD SUCCESSFUL`
2. **启动模拟器**：「工具 > 设备管理器 > 本地模拟器」，选 `Mate 90 Pro`（HarmonyOS 7.0.0）点 ▶
3. **运行**：顶部设备框选中该模拟器 → 点绿色 ▶「运行 'entry'」

> **不需要签名**。本地模拟器接受未签名的 HAP，直接安装即可（真机才需要华为账号自动签名）。
> 若 IDE 报签名相关错误，用命令行装：
>
> ```bash
> HDC="C:/Program Files/Huawei/DevEco Studio/sdk/default/openharmony/toolchains/hdc.exe"
> "$HDC" install -r entry/build/default/outputs/default/entry-default-unsigned.hap
> "$HDC" shell aa start -a EntryAbility -b com.example.chapter3uidemo
> ```

运行后首页是「第3章 UI设计」目录页，点条目进入各节示例，返回键回目录。

## 四、说明

- 教材里的图片资源（weixin/alipay/huawei、iconA/iconB、Image1~3、icon）未随书提供，
  工程里用等尺寸的 svg 占位图代替，换成真图只需替换 `resources/base/media` 下同名文件。
- 3.1.4 的网络图片需要 `ohos.permission.INTERNET`，已在 `module.json5` 声明。
- 3.3.4 书中最后的“隔空手势”（inputKit AIR_GESTURE）依赖相机等设备能力，模拟器不支持，
  未纳入可运行示例，原因写在对照表里。
