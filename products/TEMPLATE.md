<!--
Product guide template.
Copy to products/<product>/README.md (English) and products/<product>/README.zh-CN.md (中文), then fill in.

This page is public. Describe features only — no internal hostnames or IPs, credentials,
private repository links, internal issue numbers or unannounced project names.
Use documentation addresses (192.0.2.x, RFC 5737) in examples.
-->

# <emoji> <Product name>

**<One-sentence pitch: what it is and who it is for.>**

[English](README.md) · [简体中文](README.zh-CN.md) · [← All products](../../README.md)

| | |
|---|---|
| **Status** | <In development — no release published yet> / <Latest: vX.Y.Z> |
| **Platforms** | <Linux amd64 · arm64, Windows amd64, …> |
| **License** | <License> |
| **Downloads** | [Releases tagged `<product>-v*`](https://github.com/mickeyzzc/releases/releases?q=<product>) |

## What it does

<Two or three short paragraphs: the problem, the approach, and how it fits into a typical setup.>

## Key features

- **<Feature>** — <one line>
- **<Feature>** — <one line>

## Quick start

```bash
# 1. Download the archive for your platform and checksums.txt, then verify
sha256sum -c checksums.txt --ignore-missing

# 2. Extract and run
tar -xzf <name>_linux_amd64.tar.gz
./<name> --help
```

## Roadmap

- ✅ <Done>
- 🚧 <In progress>
- 📋 <Planned>
