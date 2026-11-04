# MiBeeReach v0.1.0 使用指南 / User Guide

自部署、隐私可控的远程接入——局域网直连版。/ Self-hosted, privacy-first remote access — LAN direct edition.

---

## 1. 安装 / Install

### Windows 被控端（被连接的机器）

运行 `MiBeeReach-Host_0.1.0_x64-setup.exe`（按用户安装到
`%LOCALAPPDATA%\MiBeeReach-Host`，可选开机自启）。安装后 host 以托盘常驻，
监听 `0.0.0.0:7777`。

Run `MiBeeReach-Host_0.1.0_x64-setup.exe` (per-user install, optional
autostart). The host runs in the tray and listens on `0.0.0.0:7777`.

### Windows 主控端（去连别人的机器）

解压 `mibeereach_windows_amd64.zip` 到任意目录，运行 `reach-config.exe`
（控制台）。

Unzip `mibeereach_windows_amd64.zip` anywhere and run `reach-config.exe`.

### Linux 被控端

解压对应架构的 `mibeereach_linux_<arch>.tar.gz`，执行：

```sh
./reach desktop host --bind 0.0.0.0:7777 --fps 20
# 或常驻：./reach-host（托盘形态仅桌面会话可用，无桌面时用 reach desktop host）
```

### macOS 主控端

解压 `mibeereach_macos_aarch64.tar.gz`，把 `MiBeeReach.app`（控制台）与
`MiBeeReach Viewer.app` 拖入「应用程序」。首次打开如被 Gatekeeper 拦截，
右键 → 打开放行（ad-hoc 签名包的常规提示）。

---

## 2. 连接 / Connect

### 方式一：控制台（推荐 / Recommended）

1. 主控端打开控制台 → 「连接」页。
2. 同网段的被控端会**自动出现**（信标发现，免登录零配置）→ 点「连接」。
3. 没出现就手输地址：快速连接框填 `ip:port`（如 `192.168.1.10:7777`）→ 连接。

同一台机器上打开的桌面/终端/SSH 会话都收进「工作区」页签，工具栏可调
画质/音频/缩放/显示器/录屏，`Ctrl+Alt+I` 开状态浮窗。

### 方式二：命令行 / CLI

```sh
# 被控端（host 侧），三选一：
reach desktop host  --bind 0.0.0.0:7777        # 远程桌面
reach terminal host --bind 0.0.0.0:7778        # 远程终端
reach tunnel host   --bind 0.0.0.0:7779        # 隧道

# 主控端（viewer 侧）：
reach desktop connect  --host 192.168.1.10:7777
reach terminal connect --host 192.168.1.10:7778
reach tunnel connect   --host 192.168.1.10:7779 --local 127.0.0.1:2223 --target 127.0.0.1:22
```

### 局域网访问码（LAN 访问码 / LAN key）

被控端可加 `--lan-key <64位hex>` 开启配对门禁：无凭据连接直接拒绝。
主控端连接时用 `--lan-key` 携带同一密钥（控制台快速连接框也有对应输入位）。

```sh
reach desktop host    --bind 0.0.0.0:7777 --lan-key 00112233...ff
reach desktop connect --host 192.168.1.10:7777 --lan-key 00112233...ff
```

用 `reach desktop lan-key` 可查看/生成本机持久化的默认 key（不带 `--lan-key`
启动时自动启用）。开放模式（完全不带 key）即任何局域网机器可连。

---

## 3. 会话能力 / Session features

远程桌面会话内：视频 + 键鼠、剪贴板（文本/图片/文件）、文件互传、音频、
多显示器切换（`Ctrl+Alt+N`）、画质档位（`Ctrl+Alt+Q`）、只读模式、
背景置黑（`Ctrl+Alt+B`）、录屏输出（`Ctrl+Alt+R`）。

Inside a desktop session: video + input, clipboard (text/image/files),
file transfer, audio, monitor switching, quality presets, view-only mode.

## 4. 故障排查 / Troubleshooting

| 症状 / Symptom | 排查 / Fix |
|---|---|
| 主控端看不到被控端 / device not discovered | 确认同网段、被控端 host 在跑；检查路由器是否隔离广播（AP 隔离） |
| 连接超时 / connect timeout | 被控端防火墙放行 **UDP 7777**（终端/隧道 7778/7779）；`ip:port` 填被控端地址 |
| 提示认证失败 / auth rejected | 双方 LAN key 不一致——`--lan-key` 或控制台输入位核对 |
| 画面卡顿 / stutter | 画质档位切「省流」；弱网下自动降帧；确认非无线中转 |
| macOS 打不开 / won't open | 右键 → 打开放行 Gatekeeper |

## 5. 许可 / License

专有软件——随包 `LICENSE` 为准。/ Proprietary — see the bundled `LICENSE`.

MiBeeReach © Mi-Bee Studio. All rights reserved.
