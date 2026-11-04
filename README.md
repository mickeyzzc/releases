<div align="center">

# 📦 releases · 发布会

**The public release stage for projects developed in private repositories.**
Ready-to-run binaries, SHA-256 checksums and feature guides — the source code stays private.

[English](README.md) · [简体中文](README.zh-CN.md)

![binaries: public](https://img.shields.io/badge/binaries-public-2ea44f?style=flat)
![source: private](https://img.shields.io/badge/source-private-6e7681?style=flat)
![checksums: SHA-256](https://img.shields.io/badge/checksums-SHA--256-0969da?style=flat)

</div>

---

> The name is an English take on **发布会** — a launch event. Every time a privately developed project ships, it takes the stage here.

Binaries are published as [GitHub Releases](https://github.com/mickeyzzc/releases/releases), each with a `checksums.txt`. This repository holds no source code — only public feature guides and release tooling.

## Product matrix

<p align="center">
  <a href="https://github.com/Mi-Bee-Studio" title="Mi&amp;Bee Studio on GitHub">
    <img src="https://raw.githubusercontent.com/Mi-Bee-Studio/.github/main/profile/product-matrix.svg" alt="Mi&amp;Bee Studio product matrix: devices → protocol libraries → platform; MiBeeBell and MiBeeReach are closed-source products released here">
  </a>
</p>

The core line of the Mi&Bee ecosystem: devices → protocol libraries → platform. Dashed green chips are closed-source products whose binaries are released here. More views — observability, boards & edge, docs & portals — are on the [organization profile](https://github.com/Mi-Bee-Studio).

## Products released here

| Product | What it does | Platforms | License | Downloads |
|---|---|---|---|---|
| 🔔 **[MiBeeBell](products/mibeebell/README.md)** | Lightweight self-hosted alert hub — collects alerts from everything, denoises them and delivers to WeCom / DingTalk / Feishu / Telegram / email | Linux amd64 · arm64 · 32-bit ARM, Windows amd64; native fnOS packages (ARM64 / x86) | TBA | ✅ [v0.1.0 released](https://github.com/mickeyzzc/releases/releases/tag/mibeebell-v0.1.0) |
| 🖥️ **[MiBeeReach](products/mibeereach/README.md)** | Self-hosted, privacy-first remote access — remote desktop, terminal, SSH and intranet tunnels | Windows x64 · Linux (controlled side) | Proprietary | 🚧 [Coming soon](https://github.com/mickeyzzc/releases/releases?q=mibeereach) |

## Download & verify

1. Open **[Releases](https://github.com/mickeyzzc/releases/releases)** and type the product name into the search box — every tag starts with it (`<product>-vX.Y.Z`).
2. Download the archive for your OS / CPU architecture, plus `checksums.txt`.
3. Verify, extract, and follow the *Quick start* in the product guide.

```bash
sha256sum -c checksums.txt --ignore-missing              # Linux
shasum -a 256 -c checksums.txt --ignore-missing          # macOS
```

```powershell
Get-FileHash .\<file>.zip -Algorithm SHA256              # Windows: compare with checksums.txt
```

A mismatch means the file is corrupted or is not the one published here — do not run it.

Archives are named `<name>_<os>_<arch>.tar.gz` (`.zip` on Windows); pre-releases carry a `-rc.N` / `-beta.N` suffix and are flagged *Pre-release*. GitHub's "Latest" badge only marks the most recent launch across all products — pick the newest release with your product's prefix.

## Feedback & security

- **Bugs and questions:** open an [issue](https://github.com/mickeyzzc/releases/issues/new/choose) with the product, release tag and your OS / architecture — **never paste passwords, tokens or private addresses**.
- **Security vulnerabilities:** report them privately via **[Security → Report a vulnerability](https://github.com/mickeyzzc/releases/security/advisories/new)**.

## For maintainers

Publishing workflow and rules: [RELEASING.md](RELEASING.md) · helper script: [`scripts/publish.sh`](scripts/publish.sh) · product guide template: [`products/TEMPLATE.md`](products/TEMPLATE.md).

## License

This repository holds documentation and release tooling only. Each product is distributed under its own license — stated in its guide and in the license file shipped with every release.

Maintained by [@mickeyzzc](https://github.com/mickeyzzc).
