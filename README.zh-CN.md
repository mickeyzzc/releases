<div align="center">

# 📦 releases · 发布会

**私有仓库项目的公开发布台。**
开箱即用的二进制、SHA-256 校验文件与功能介绍——源码保持私有。

[English](README.md) · [简体中文](README.zh-CN.md)

![binaries: public](https://img.shields.io/badge/binaries-public-2ea44f?style=flat)
![source: private](https://img.shields.io/badge/source-private-6e7681?style=flat)
![checksums: SHA-256](https://img.shields.io/badge/checksums-SHA--256-0969da?style=flat)

</div>

---

> 仓库名取自 **「发布会」**：私有仓里开发的项目，每一次发版都在这里登台亮相。

二进制以 [GitHub Releases](https://github.com/mickeyzzc/releases/releases) 形式发布，每个版本附带 `checksums.txt`。本仓库不含源码，只放公开的功能介绍与发布工具。

## 产品矩阵

<p align="center">
  <a href="https://github.com/Mi-Bee-Studio" title="Mi&amp;Bee Studio GitHub 组织">
    <img src="https://raw.githubusercontent.com/Mi-Bee-Studio/.github/main/profile/product-matrix.svg" alt="Mi&amp;Bee Studio 产品矩阵：终端设备 → 协议库 → 平台服务；MiBeeBell 与 MiBeeReach 为在此发布的闭源产品">
  </a>
</p>

Mi&Bee 生态的核心主线：终端设备 → 协议库 → 平台服务。虚线绿框是闭源产品，二进制在本仓库发布。可观测、开发板与边缘、文档与门户三张专题图见[组织主页](https://github.com/Mi-Bee-Studio)。

## 在此发布的产品

| 产品 | 简介 | 平台 | 许可证 | 下载 |
|---|---|---|---|---|
| 🔔 **[MiBeeBell 蜂铃](products/mibeebell/README.zh-CN.md)** | 轻量自托管告警通知中心：把各处告警统一去噪、聚合，送达企微 / 钉钉 / 飞书 / Telegram / 邮件 | Linux amd64 · arm64 · 32 位 ARM，Windows amd64 | 待公布 | 🚧 [即将发布](https://github.com/mickeyzzc/releases/releases?q=mibeebell) |
| 🖥️ **[MiBeeReach](products/mibeereach/README.zh-CN.md)** | 自部署、隐私可控的统一远程接入：远程桌面、终端、SSH、内网隧道 | Windows x64 · Linux（被控端） | 专有软件 | 🚧 [即将发布](https://github.com/mickeyzzc/releases/releases?q=mibeereach) |

## 下载与校验

1. 打开 **[Releases](https://github.com/mickeyzzc/releases/releases)**，在搜索框输入产品名——每个 tag 都以它开头（`<product>-vX.Y.Z`）。
2. 下载与你的系统 / CPU 架构匹配的归档包，以及 `checksums.txt`。
3. 校验后解压，按产品介绍里的「快速上手」运行。

```bash
sha256sum -c checksums.txt --ignore-missing              # Linux
shasum -a 256 -c checksums.txt --ignore-missing          # macOS
```

```powershell
Get-FileHash .\<file>.zip -Algorithm SHA256              # Windows：与 checksums.txt 比对
```

哈希不一致说明文件已损坏或并非本仓库发布的文件——请勿运行。

归档包命名为 `<name>_<os>_<arch>.tar.gz`（Windows 为 `.zip`）；预发布版本带 `-rc.N` / `-beta.N` 后缀并标记为 *Pre-release*。GitHub 的 “Latest” 标签只代表所有产品中最近一次发布——请以带有你所用产品前缀的最新 Release 为准。

## 反馈与安全

- **问题反馈**：提交 [issue](https://github.com/mickeyzzc/releases/issues/new/choose)，写明产品、Release tag 与系统 / 架构——**切勿粘贴密码、令牌或内网地址**。
- **安全漏洞**：请通过 **[Security → Report a vulnerability](https://github.com/mickeyzzc/releases/security/advisories/new)** 私下报告。

## 维护者

发布流程与规则见 [RELEASING.md](RELEASING.md)，辅助脚本见 [`scripts/publish.sh`](scripts/publish.sh)，产品介绍模板见 [`products/TEMPLATE.md`](products/TEMPLATE.md)。

## 许可

本仓库只包含文档与发布工具。各产品按其自身许可证分发——见各产品介绍及每个 Release 随附的许可证文件。

维护者：[@mickeyzzc](https://github.com/mickeyzzc)
