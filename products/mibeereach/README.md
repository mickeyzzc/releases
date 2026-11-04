# 🖥️ MiBeeReach

**Self-hosted, privacy-first unified remote access — reach and control any machine, on your own terms.**

[English](README.md) · [简体中文](README.zh-CN.md) · [← All products](../../README.md)

| | |
|---|---|
| **Status** | **v0.1.0 published** — 2026-11 |
| **Platforms** | Windows x64 (controlling side, controlled side, management console) · Linux (controlled side) · macOS arm64 (controlling side) |
| **Documentation** | [User guide](user-guide.md) · [使用指南](user-guide.zh-CN.md) |
| **License** | Proprietary — © Mi&Bee Studio, all rights reserved; see the license file shipped with each release |
| **Downloads** | [Releases tagged `mibeereach-v*`](https://github.com/mickeyzzc/releases/releases?q=mibeereach) |

## What it does

MiBeeReach is a remote operations platform written from scratch in Rust. Remote desktop, remote terminal, SSH and intranet tunneling share one connection layer and one device identity — everything stays inside your local network, with **no third party in the path**.

| The problem with commercial remote-desktop services | MiBeeReach's answer |
|---|---|
| Speed / bandwidth caps and quotas | Your own infrastructure — no caps, no quotas |
| Ads and upsells | A pure tool, no ads |
| Privacy black box (traffic through vendor servers) | Self-hosted, encrypted, traffic never leaves your network |
| Uncontrollable quality and latency | The whole stack is owned and tunable |

## Capabilities

| Capability | Description | Platforms |
|---|---|---|
| **Remote desktop** | Video, keyboard & mouse, clipboard (text / images / files), audio, file transfer, multi-monitor, view-only mode | Controlled: Windows · Linux — Controlling: Windows · macOS |
| **Remote terminal** | Remote shell over the local network | Windows · Linux |
| **Remote SSH** | Built-in SSH server — connect with any standard `ssh` client | Windows · Linux |
| **Intranet tunnel** | Expose internal TCP services securely | Windows · Linux |
| **Management console** | Desktop app: quick connect, LAN device discovery, workspaces, embedded terminal, SSH tabs, session monitor | Windows · macOS |

Built for real networks: adaptive quality on weak links, near-zero CPU while nobody is watching, and optional hardware video encoding.

## Security

- **Encrypted** connections on your network, no third party in the path.
- **Pairing required** — connections without credentials are rejected; paired devices connect without prompts.
- **Per-session permissions** for control, clipboard and files, plus a view-only mode.

More platforms are planned. Usage documentation ships with each release.
