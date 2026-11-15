# 运行与上传 GitHub 操作手册

工程位置：`C:\Users\Justing\WorkBuddy\2026-11-15-12-55-37\Chapter3UIDemo`
本机环境：DevEco Studio 26.0.0（安装目录 `C:\Program Files\Huawei\DevEco Studio`）
当前状态：**代码已全部补齐，命令行 `assembleHap` 编译通过**（产物 `entry/build/default/outputs/default/entry-default-unsigned.hap`），本地 git 仓库已初始化并完成第一次提交（分支 `main`）。

下面四步分别对应：打开工程 → 签名 → 运行 → 上传 GitHub。

---

## 第 1 步：在 DevEco Studio 里打开工程

1. 启动 **DevEco Studio**。
2. 欢迎页点 **Open**（或菜单 `File > Open`）。
3. 选择目录 `C:\Users\Justing\WorkBuddy\2026-11-15-12-55-37\Chapter3UIDemo`，点 **OK**。
   - ⚠️ 选的是 **Chapter3UIDemo 这一层**（里面有 `build-profile.json5` 的那层），不要往上选到 WorkBuddy 目录。
4. 如果右下角弹出提示，点 **Trust Project**。
5. 打开后右上角会出现 **Sync Now**（或提示 “hvigor sync”），点它等进度条走完。
   - 成功标志：左下角 `Build` 窗口输出 `BUILD SUCCESSFUL`，左侧 `entry` 目录不再有红色波浪线。

> 如果 Sync 报错说找不到 SDK：`File > Project Structure > SDK`，确认 SDK 选的是 `HarmonyOS 26.0.0 (API 26)`，路径 `C:\Program Files\Huawei\DevEco Studio\sdk`。

---

## 第 2 步：配置签名（跑真机/模拟器必须要）

鸿蒙应用必须签名才能安装。个人学习用**自动签名**最省事：

1. 右上角点 **Sign In**，用华为账号登录（没有就注册一个，免费）。
2. 菜单 `File > Project Structure...` → 左侧 **Project > Signing Configs**。
3. 勾选 **Automatically generate signature**，等待 10 秒左右，DevEco 会自动申请调试证书并填好 4 个字段（Store file / Key alias / Store password / Key password）。
4. 点 **OK**。

成功后 `build-profile.json5` 的 `signingConfigs` 里会自动写入一段配置（这段含密码，**不要上传到 GitHub**，`.gitignore` 里已排除 `local.properties`，但签名配置是写在 build-profile.json5 里的，上传前建议删掉或改成环境变量，见文末“注意事项”）。

---

## 第 3 步：把应用跑起来

### 用模拟器

1. 菜单 `Tools > Device Manager` → **Local Emulator** → **New Emulator**（若已有模拟器直接 Start）。
2. 选一个 Phone 机型（如 Phone），系统镜像选 `HarmonyOS 7.0.0`（本机已下载），点 **Finish** 创建。
3. 点模拟器右侧 ▶ 启动，等到出现手机桌面。
4. 回到 DevEco，顶部工具栏设备下拉框选中这个模拟器，点绿色 ▶ **Run 'entry'**。

### 用真机

1. 手机打开 `设置 > 系统 > 开发者选项`，开启 **USB 调试**，用数据线连电脑。
2. 手机上弹出“允许调试”时点允许。
3. DevEco 顶部设备框选中你的手机，点 ▶ Run。

### 运行后应该看到什么

- 首页是 **「第3章 UI设计」目录页**，分三组：3.1 组件 / 3.2 页面布局 / 3.3 事件，共 20 个条目。
- 点任意条目进入对应示例页；手机返回手势/返回键可以回到目录。
- 建议重点看：
  - 3.2.2 层叠布局：点“改变堆叠次序”，看三个方块谁盖住谁变了；
  - 3.3.2 导航与切换：点第二个按钮“跳转 NavPageTwo”，会被拦截重定向到 NavPageOne（这是书里拦截逻辑的正确版本）；
  - 3.3.4 手势事件：双击/滑动/捏合四种手势。

### 只用命令行编译（不打开 IDE 也能验证）

```bash
cd "C:/Users/Justing/WorkBuddy/2026-11-15-12-55-37/Chapter3UIDemo"
export DEVECO_SDK_HOME="C:/Program Files/Huawei/DevEco Studio/sdk"
export PATH="/c/Program Files/Huawei/DevEco Studio/jbr/bin:$PATH"
node "C:/Program Files/Huawei/DevEco Studio/tools/hvigor/bin/hvigorw.js" \
     --mode module -p product=default assembleHap --no-daemon
```

看到 `BUILD SUCCESSFUL` 即编译通过（这条命令我已经跑过，你本地可以直接复用）。

---

## 第 4 步：上传到 GitHub

本地仓库已经 init + commit 好了（分支 `main`，1 次提交，69 个文件）。
现在只差“连到远程仓库”。二选一。

### 方式 A：DevEco Studio 图形界面（推荐，不用敲命令）

1. **先登录 GitHub**：`File > Settings > Version Control > GitHub` → 点 **+** → 选 `Log In with Token` 或 `Log In via GitHub...`，按提示完成授权。
   - 用 Token 的话：浏览器打开 https://github.com/settings/tokens → Generate new token (classic) → 勾 `repo` → 生成后复制粘贴进来。
2. 回到主界面，菜单 **`Git`**（老版本叫 `VCS`）→ **`GitHub`** → **`Share Project on GitHub`**。
3. 填写：
   - **Repository name**：`Chapter3UIDemo`（建议就用这个）
   - **Description**：`HarmonyOS NEXT 教材第3章 UI设计 示例代码补全版`
   - 勾 **Private**（作业/课程代码建议私有）或 Public 都行。
4. 点 **Share**，等待右下角提示 `Successfully shared project on GitHub`。
5. 浏览器打开你的 GitHub 主页，就能看到这个仓库。

> 如果菜单里找不到 `Share Project on GitHub`，说明当前工程没被识别为 git 仓库：确认打开的是 `Chapter3UIDemo` 目录（里面应有隐藏文件夹 `.git`）。

### 方式 B：命令行 push（DevEco 登录不上时的备选）

1. 先在 GitHub 网页上 **New repository**，建一个空仓库（**不要**勾 Add README / .gitignore），名字如 `Chapter3UIDemo`，拿到地址。
2. 在本机 Git Bash 里执行：

```bash
cd "C:/Users/Justing/WorkBuddy/2026-11-15-12-55-37/Chapter3UIDemo"
git remote add origin https://github.com/你的用户名/Chapter3UIDemo.git
git push -u origin main
```

3. 弹出登录窗口时，**用户名**填 GitHub 用户名，**密码**要填 **Personal Access Token**（不是登录密码；生成方式同上：Settings > Developer settings > Tokens (classic) > 勾 repo）。

---

## 注意事项（重要）

1. **不要提交签名材料**：`build-profile.json5` 里自动签名生成的 `signingConfigs` 含证书密码。
   上传前如果已经自动签名，建议把 `signingConfigs` 清空成 `[]` 再提交，本地仍能编译（只是不能安装）。
2. `.gitignore` 已排除：`build/`、`.hvigor/`、`oh_modules/`、`.idea/`、`local.properties`、`.preview/`，
   所以仓库里只有源码和配置，干净且体积小（约 100KB）。
3. 每次改完代码再上传，只需要三步：
   ```bash
   git add -A
   git commit -m "说明这次改了什么"
   git push
   ```
   或者在 DevEco 里用 `Git > Commit` 面板提交、`Git > Push` 推送。
4. 换电脑/换人复现：`git clone` 下来用 DevEco 打开，重新做第 1、2 步（Sync + 签名）即可运行。

---

## 常见问题

| 现象 | 原因 | 处理 |
|---|---|---|
| Sync 报 `Cannot find SDK` | SDK 路径没配 | `File > Project Structure > SDK` 选 API 26 |
| Run 报 `Install failed, signature verify failed` | 没配签名 | 回到第 2 步自动签名 |
| Run 时提示没有设备 | 模拟器没启动 / 真机没开 USB 调试 | `Tools > Device Manager` 启动模拟器 |
| 3.3.2 点跳转没反应 | 预览器不支持系统路由表 | 必须用模拟器或真机运行（书里也写了这条） |
| 3.1.4 网络图片显示不出来 | 模拟器无网络 / 域名访问受限 | 属正常，`.alt()` 会显示占位图；真机连网即可 |
| 3.3.1 拖拽没反应 | 用了预览器 | 模拟器里用鼠标按住拖，真机用手指长按拖 |
