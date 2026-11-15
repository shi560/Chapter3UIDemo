# 运行与上传 GitHub 操作手册（中文界面版）

工程位置：`C:\Users\Justing\WorkBuddy\2026-11-15-12-55-37\Chapter3UIDemo`
本机环境：DevEco Studio 26.0.0（安装目录 `C:\Program Files\Huawei\DevEco Studio`），界面语言：中文
当前状态：**代码已全部补齐，命令行 `assembleHap` 编译通过**（产物 `entry/build/default/outputs/default/entry-default-unsigned.hap`），本地 git 仓库已初始化并完成提交（分支 `main`）。

下面的菜单名同时给出中文和英文（括号内），两种界面都能对上。

---

## 第 1 步：在 DevEco Studio 里打开工程

1. 启动 **DevEco Studio**。
2. 欢迎页点「**打开**」（Open）；已进入主界面就用菜单「**文件** > **打开**」（File > Open）。
3. 地址栏粘贴下面这行（**一定不能漏掉中间的 `2026-11-15-12-55-37`**）：

   ```
   C:\Users\Justing\WorkBuddy\2026-11-15-12-55-37\Chapter3UIDemo
   ```

   输入框太长时会显示成 `C:\Users\Justing\WorkBu...Chapter3UIDemo`，中间省略号是折叠显示，不影响。
4. 弹出「**信任项目**」（Trust Project）点信任。
5. 右下角出现「**立即同步**」（Sync Now）就点它，等进度条走完。

**成功标志**：左侧 `entry/src/main/ets/pages` 下 23 个 `.ets` 文件没有红色波浪线，底部「构建」窗口出现 `BUILD SUCCESSFUL`。

> 如果同步报「找不到 SDK」：菜单「**文件** > **项目结构** > **SDK**」，确认选的是 `HarmonyOS 26.0.0 (API 26)`，路径 `C:\Program Files\Huawei\DevEco Studio\sdk`。

---

## 第 2 步：登录华为账号 + 自动签名

鸿蒙应用必须签名才能装进模拟器/手机。个人学习用**自动签名**最省事。用**你自己的**华为账号即可（跟老师的账号无关，也不需要借用）。

1. 点右上角头像图标 →「**登录**」（Sign In），用华为账号登录（没有就注册，免费；如提示实名认证按提示完成）。
2. 菜单「**文件** > **项目结构...**」（File > Project Structure...）→ 左侧选「**项目** > **签名配置**」（Project > Signing Configs）。
3. 勾选「**自动生成签名**」（Automatically generate signature），等 10 秒左右。
4. 看到 Store file / Key alias / 两个密码框共 4 项**自动填满**，点「**确定**」。

**成功标志**：`build-profile.json5` 里 `signingConfigs` 从 `[]` 变成一段带证书路径的配置。

> 这段配置含证书密码，**不能推到 GitHub**。第 6 步推送前请执行「推送前一键清理」。

---

## 第 3 步：创建并启动模拟器

1. 菜单「**工具** > **设备管理器**」（Tools > Device Manager）。
2. 切到「**本地模拟器**」（Local Emulator）标签 → 点「**+**」（新建模拟器 / New Emulator）。
3. 机型选 **Phone**，系统镜像选 **HarmonyOS 7.0.0**（本机已下载，无需再等）。
4. 点「**完成**」创建 → 回到列表点 **▶** 启动。

**成功标志**：弹出一个小窗口，显示鸿蒙手机桌面。**这个窗口要一直开着**，关掉应用就断连。

> 用真机也可以：手机「设置 > 系统 > 开发者选项」开启 **USB 调试**，数据线连电脑，手机上点「允许调试」，然后跳过本步。

---

## 第 4 步：运行

1. 回到主窗口，顶部工具栏的设备下拉框选中刚启动的模拟器（显示 `emulator-xxxx`）。
2. 点绿色 **▶ 运行 'entry'**（Run 'entry'，快捷键 `Shift+F10`）。
3. 首次安装约 30 秒。

**成功标志**：模拟器里打开应用，首页是「**第3章 UI设计**」目录页，分 3.1 组件 / 3.2 页面布局 / 3.3 事件三组共 20 条。

---

## 第 5 步：验收这几页

| 点哪里 | 应该看到 |
|---|---|
| 3.2.2 层叠布局 →「改变堆叠次序」 | 三个方块谁盖住谁变了 |
| 3.3.2 导航与切换 → 第二个按钮 | 跳转被拦截、重定向到 NavPageOne |
| 3.3.4 手势事件 | 双击 / 滑动 / 捏合都有文字反馈 |
| 3.3.1 拖拽事件 | 长按图标拖动到目标框，弹出提示 |

其余页面逐个点一遍能正常显示、按返回键能回目录，第三章就算跑通了。

> 不建模拟器也能看大部分页面：菜单「**视图** > **工具窗口** > **预览器**」（View > Tool Windows > Previewer），选中某个 `.ets` 文件点预览。但 3.3.2 导航页和 3.3.1 拖拽在预览器里失效，必须用模拟器。

---

## 第 6 步：上传到 GitHub

### 推送前一键清理（必做）

签名配置里带着证书密码，推送前把它清空：

```bash
cd "C:/Users/Justing/WorkBuddy/2026-11-15-12-55-37/Chapter3UIDemo"
python - <<'PY'
import re
p = 'build-profile.json5'
s = open(p, encoding='utf-8').read()
s = re.sub(r'"signingConfigs"\s*:\s*\[.*?\n  \]', '"signingConfigs": []', s, flags=re.S)
open(p, 'w', encoding='utf-8').write(s)
print('signingConfigs 已清空')
PY
git add -A && git commit -m "推送前清空本机签名配置"
```

清空后本地仍能编译，只是不能再安装到设备（需要时重做第 2 步勾一次自动签名即可）。

### 方式 A：图形界面（推荐）

1. 菜单「**文件** > **设置**」（File > Settings）→ 左侧「**版本控制** > **GitHub**」（Version Control > GitHub）→ 点 **+** →「**使用令牌登录**」（Log In with Token）。
   - 令牌生成：浏览器打开 https://github.com/settings/tokens → Generate new token (classic) → 勾 `repo` → 生成后复制粘贴进来。
2. 回到主界面，菜单「**Git** > **GitHub** > **在 GitHub 上共享项目**」（Git > GitHub > Share Project on GitHub）。
3. 填写：
   - 仓库名（Repository name）：`Chapter3UIDemo`
   - 描述：`HarmonyOS NEXT 教材第3章 UI设计 示例代码补全版`
   - 建议勾选「**私有**」（Private）
4. 点「**共享**」（Share），等待右下角提示 `Successfully shared project on GitHub`。

> 菜单里没有「在 GitHub 上共享项目」：说明当前工程没被识别为 git 仓库，确认打开的是 `Chapter3UIDemo` 目录（里面有隐藏文件夹 `.git`）。

### 方式 B：命令行

1. 先在 GitHub 网页 **New repository** 建一个空仓库（**不要**勾 Add README / .gitignore），名字 `Chapter3UIDemo`。
2. 本机 Git Bash 执行：

```bash
cd "C:/Users/Justing/WorkBuddy/2026-11-15-12-55-37/Chapter3UIDemo"
git remote add origin https://github.com/你的用户名/Chapter3UIDemo.git
git push -u origin main
```

3. 弹窗要密码时，填 **Personal Access Token**（不是 GitHub 登录密码）。

---

## 注意事项

1. **不要提交签名材料**：`.p12` / `.cer` / `.p7b` 和证书密码都属个人私钥，不要提交、不要发给别人。
2. `.gitignore` 已排除 `build/`、`.hvigor/`、`oh_modules/`、`.idea/`、`local.properties`、`.preview/`，仓库里只有源码，约 100KB。
3. 老师拿到你的仓库后，clone 下来用他自己的华为账号做一遍第 1、2 步就能运行——签名不需要共用。
4. 以后改完代码上传三步：`git add -A` → `git commit -m "说明"` → `git push`；或在 DevEco 用「**Git** > **提交**」和「**Git** > **推送**」。

---

## 常见问题（中文界面报错对照）

| 现象 | 原因 | 处理 |
|---|---|---|
| 打开工程提示「找不到指定的路径」 | 路径里漏了 `2026-11-15-12-55-37` 这一层 | 用鼠标逐层点开，别手打 |
| 同步报 `Cannot find SDK` | SDK 路径未配置 | 「文件 > 项目结构 > SDK」选 API 26 |
| 运行报 `Install failed, signature verify failed` | 没做自动签名 | 回到第 2 步 |
| 运行按钮灰着 / 提示没有设备 | 模拟器没启动或真机没开 USB 调试 | 「工具 > 设备管理器」启动模拟器 |
| 3.3.2 点跳转没反应 | 用了预览器，不支持系统路由表 | 改用模拟器或真机 |
| 3.1.4 网络图片不显示 | 模拟器无网络 | 正常现象，`.alt()` 显示占位图 |
| 3.3.1 拖拽没反应 | 用了预览器 | 模拟器里用鼠标按住拖 |
