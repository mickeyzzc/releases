# 🖥️ MiBeeReach

**Self-hosted, privacy-first unified remote access — reach and control any machine, on your own terms.**

[English](README.md) · [简体中文](README.zh-CN.md) · [← All products](../../README.md)

| | |
|---|---|
| **Status** | In development — no release published yet |
| **Platforms** | Windows x64 (controlling side, controlled side, management console) · Linux (controlled side) |
| **License** | Proprietary — © Mi&Bee Studio, all rights reserved; see the license file shipped with each release |
| **Downloads** | [Releases tagged `mibeereach-v*`](https://github.com/mickeyzzc/releases/releases?q=mibeereach) |

## What it does

MiBeeReach is a single-binary remote operations platform written from scratch in Rust. Remote desktop, remote terminal, SSH and intranet tunneling share one connection layer and one device identity — over your local network or your own self-hosted P2P infrastructure, with **no third-party relay in the path**.

| The problem with commercial remote-desktop services | MiBeeReach's answer |
|---|---|
| Speed / bandwidth caps and quotas | Your own infrastructure — no caps, no quotas |
| Ads and upsells | A pure tool, no ads |
| Privacy black box (traffic through vendor servers) | Self-hosted, encrypted, no third party |
| Uncontrollable quality and latency | The whole stack is owned and tunable |

## Capabilities

| Capability | Description | Platforms |
|---|---|---|
| **Remote desktop** | Video, keyboard & mouse, clipboard (text / images / files), audio, file transfer, multi-monitor, view-only mode | Controlled: Windows · Linux — Controlling: Windows |
| **Remote terminal** | Remote shell over LAN or P2P | Windows · Linux |
| **Remote SSH** | Built-in SSH server — connect with any standard `ssh` client | Windows · Linux |
| **Intranet tunnel** | Expose internal TCP services securely | Windows · Linux |
| **Cross-network access** *(pilot)* | Reach machines on other networks through your own self-hosted P2P service | Across networks |
| **Management console** | Desktop app: connection profiles, workspaces, embedded terminal, SSH tabs, LAN discovery, device enrollment | Windows |

Built for real networks: adaptive quality on weak links, automatic LAN-or-P2P selection, near-zero CPU while nobody is watching, and optional hardware video encoding.

## Security

- **Encrypted end to end** on every connection, LAN or P2P.
- **Pairing required** — connections without credentials are rejected; paired devices connect without prompts.
- **Per-session permissions** for control, clipboard and files, plus a view-only mode.

More platforms are planned. Usage documentation ships with each release.
