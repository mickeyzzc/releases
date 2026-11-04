# MiBeeReach 使用指南

**v0.1.0 — 局域网直连版** · [English](user-guide.md) · [产品介绍](README.zh-CN.md)

自部署、隐私可控的远程接入：远程桌面、终端、SSH、端口转发，全程走你的局域网——
无账号、无云、不经第三方。

---

## 1. 三十秒概览

| 角色 | 机器 | 安装什么 |
|---|---|---|
| **被控端**（被连接的机器） | Windows / Linux | **Host**——后台常驻，等待连接 |
| **主控端**（发起连接的机器） | Windows / macOS | **控制台**（桌面应用）——发现设备、打开会话 |

两端须在同一局域网。主控端**自动发现**被控端——免账号、零配置。

## 2. 安装

### 2.1 Windows 被控端

1. 从 [发布页](https://github.com/mickeyzzc/releases/releases/tag/mibeereach-v0.1.0)
   下载 `MiBeeReach-Host_0.1.0_x64-setup.exe`。
2. 运行安装（按用户安装到 `%LOCALAPPDATA%\MiBeeReach-Host`，可选开机自启）。
3. host 以托盘常驻，监听 `0.0.0.0:7777`。

### 2.2 Windows 主控端

1. 下载 `mibeereach_windows_amd64.zip`。
2. 解压到任意目录，运行 `reach-config.exe`——这就是控制台。
3. （旁边的 `reach.exe` 是控制台拉起会话用的引擎，两个文件保持同目录。）

### 2.3 Linux 被控端

1. 下载 `mibeereach_linux_amd64.tar.gz`（x86_64）并解压：

   ```sh
   tar xzf mibeereach_linux_amd64.tar.gz
   ```

2. 启动 host：

   ```sh
   ./reach desktop host --bind 0.0.0.0:7777 --fps 20
   ```

3. 需要跨会话常驻时，把该命令包进你惯用的服务管理方式（systemd user unit、
   tmux、rc.local 等）。

### 2.4 macOS 主控端（Apple Silicon）

1. 下载 `mibeereach_macos_aarch64.tar.gz` 并解压——得到 `MiBeeReach.app`
   （控制台）与 `MiBeeReach Viewer.app`。
2. 两个 .app 拖入「应用程序」。
3. 首次打开被 Gatekeeper 拦截时：右键 → **打开** 放行（ad-hoc 签名包的常规提示）。

## 3. 首次连接

1. 被控端启动 host（见 2.1 / 2.3）。
2. 主控端打开控制台（见 2.2 / 2.4）——默认落在「连接」页。
3. 同网段的被控端会在几秒内**自动出现**在设备区——点「连接」。
4. 没出现就手输地址：快速连接框填 `ip:port`（如 `192.168.1.10:7777`）→ 连接。
5. 远程桌面以页签形式在「工作区」打开。

所有会话（桌面 / 终端 / SSH）都收进工作区页签；工具栏可调画质、音频、缩放、
显示器切换与录屏。

## 4. LAN 访问码（可选配对门禁）

被控端首次启动会生成并持久化一把 **LAN 访问码**，没有它的连接直接拒绝
（必须配对的安全语义）。在被控端管理它：

```sh
reach desktop lan-key          # 查看 / 生成本机持久化 key
reach desktop host --bind 0.0.0.0:7777 --lan-key 00112233...ff   # 显式指定
reach desktop host --bind 0.0.0.0:7777 --lan-open               # 开放模式（任何局域网机器可连）
```

主控端在控制台快速连接框的 **LAN 访问码** 输入位填同一把 key，或命令行携带：

```sh
reach desktop connect --host 192.168.1.10:7777 --lan-key 00112233...ff
```

## 5. 桌面会话内能力

| 能力 | 用法 |
|---|---|
| 剪贴板（文本 / 图片 / 文件） | 正常复制粘贴，双向 |
| 文件互传 | 拖拽或会话工具栏 |
| 音频 | 工具栏「音频」开关（`Ctrl+Alt+M`） |
| 画质档位 | 工具栏「画质」（`Ctrl+Alt+Q`）：原画 / 省流 / 均衡 |
| 显示器切换 | 工具栏「显示器」（`Ctrl+Alt+N`） |
| 只读模式 | 配对时授权；开启后本端输入被禁用 |
| 缩放 / 铺满 / 100% | 工具栏（`Ctrl+Alt+0` 适应，`Ctrl+Alt+±` 缩放） |
| 状态浮窗（帧率 / 延迟 / 码率） | 工具栏「状态」（`Ctrl+Alt+I`） |
| 全屏 | `Ctrl+Alt+F` / `F11`；`Esc` 退出 |
| 录屏输出 | 工具栏「录制」（`Ctrl+Alt+R`；被控端需 `--record` 启动） |

## 6. 其它会话类型

```sh
# 远程终端（同一传输层）
reach terminal host  --bind 0.0.0.0:7778     # 被控端
reach terminal connect --host 192.168.1.10:7778   # 主控端

# 端口转发（对外暴露内网 TCP 服务）
reach tunnel host   --bind 0.0.0.0:7779      # 被控端
reach tunnel connect --host 192.168.1.10:7779 --local 127.0.0.1:2223 --target 127.0.0.1:22
# 之后：ssh -p 2223 anyone@127.0.0.1  → 落到被控端的 :22
```

控制台还有 **SSH 会话** 卡片：保存「设备 + 用户名」预设，一键以内嵌终端页签打开。

## 7. 故障排查

| 症状 | 排查 |
|---|---|
| 发现不了设备 | 是否同网段？host 在跑吗？路由器开 AP/客户端隔离会拦广播发现——改用快速连接 `ip:port` |
| 连接超时 | 被控端防火墙放行 **UDP 7777**（终端 7778 / 隧道 7779） |
| 提示认证失败 | 两端 LAN 访问码不一致——对照 `reach desktop lan-key` 输出与主控端输入 |
| 卡顿 / 帧率低 | 画质档位切「省流」；弱网自动降帧 |
| macOS 应用打不开 | 右键 → 打开，放行 Gatekeeper |
| 快速连接只输设备 ID 被拒 | 本版本按地址连接——请填 `ip:port` |

## 8. 许可

专有软件——以每个包内 `LICENSE` 文件与 [产品介绍](README.zh-CN.md) 为准。

MiBeeReach © Mi-Bee Studio. All rights reserved.
