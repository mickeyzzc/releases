# 发布手册（维护者）

> 面向本仓库维护者。下载用户请看 [README](README.zh-CN.md)。

## 基本规则

1. **上架什么、何时发布，由 owner 决定。** 哪个产品进入本仓库、哪个版本公开，都须 owner 明确同意；协作者与自动化只负责准备制品和草稿，不代为上架或公开发布。
2. **一个 Release = 一个产品的一个版本。** tag 为 `<product>-v<semver>`，标题为 `<Product> v<semver>`。
3. **只放可公开的内容。** 归档包只含编译产物与随附文件（`LICENSE`、简短 `README`、示例配置），不含源码；发布说明与产品介绍不写内网地址、主机名、凭据、私有仓库链接、内部 issue 编号或未公开的项目名称。
4. **必须可校验。** 每个 Release 附 `checksums.txt`（SHA-256）；未提供时 `scripts/publish.sh` 自动生成，提供了则逐个核对。
5. **先草稿，后公开。** 脚本默认创建草稿，在网页上复核资产与说明后再公开。

## 上架一个产品（owner 决定后）

1. 在 [`products/registry.txt`](products/registry.txt) 加一行：`<product> <显示名>`。`<product>` 为小写短名（a-z、0-9、`-`），同时用作 tag 前缀和 `products/` 下的目录名。
2. 按 [`products/TEMPLATE.md`](products/TEMPLATE.md) 写 `products/<product>/README.md`（英文）与 `README.zh-CN.md`（中文），只写可以公开的功能介绍。
3. 在 `README.md`、`README.zh-CN.md` 的产品目录中加一行（目录下方的注释里有表格模板）。
4. 提交前自检：用本地维护的 `RELEASES_DENYLIST` 对全仓执行 `grep -rnEi "$RELEASES_DENYLIST" .`，确认没有不该公开的内容。

`scripts/publish.sh` 只接受已登记、且已有 `products/<product>/README.md` 的产品。

## 一次性准备

- 安装并登录 [GitHub CLI](https://cli.github.com/)：`gh auth status` 显示的账号须对本仓库有写权限。
- 如需从私有仓库的 CI 直接上传（可选）：创建一个 **fine-grained personal access token**，Repository access 只选 `mickeyzzc/releases`，权限 *Contents: Read and write*，存为私有仓库的 Actions secret `RELEASES_TOKEN`。

## 发布一个版本

### 1. 构建制品（在私有仓库）

归档命名 `<name>_<os>_<arch>.tar.gz`（Windows 用 `.zip`）：`<os>` 取 `linux` / `windows` / `darwin`，`<arch>` 取 `amd64` / `arm64` / `armv7` 等，与 Go / goreleaser 的命名一致。归档内至少包含：可执行文件、`LICENSE`、一份指向本仓库产品介绍的简短 `README`。

常见做法（示意）：

| 技术栈 | 构建 |
|---|---|
| Go + goreleaser | `goreleaser release --clean --skip=publish`：`dist/` 下即为归档包与 `checksums.txt` |
| Go（手工） | `CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -trimpath -ldflags "-s -w" -o <name> ./cmd/<name>`，再按命名打包 |
| Rust | `cargo build --release --target <triple>`，每个目标平台一个归档包 |

### 2. 写发布说明

复制 [`scripts/release-notes.md`](scripts/release-notes.md)，按模板填写亮点、变更、升级注意和下载表。

### 3. 创建草稿

```bash
# 演练：只打印将要执行的 gh 命令，不做任何改动
DRY_RUN=1 scripts/publish.sh <product> <X.Y.Z> notes.md dist/*.tar.gz dist/*.zip dist/checksums.txt

# 创建草稿 Release
scripts/publish.sh <product> <X.Y.Z> notes.md dist/*.tar.gz dist/*.zip dist/checksums.txt
```

脚本依次执行：检查产品已登记且有产品介绍 → 校验 semver（不带 `v`）→ 若设置了 `RELEASES_DENYLIST` 则扫描发布说明 → 检查资产存在且不重名 → 核对或生成 `checksums.txt` → 以 `<product>-v<version>` 创建草稿。版本带 `-rc.1` 之类后缀时会标记为 Pre-release。

| 环境变量 | 作用 |
|---|---|
| `RELEASES_DENYLIST` | 扩展正则，发布说明命中即中止。真实规则只保存在本地，**不要提交到本仓库** |
| `PUBLISH=1` | 跳过草稿、直接公开（仅在制品已复核时使用） |
| `DRY_RUN=1` | 只打印命令 |
| `RELEASES_REPO` | 目标仓库，默认 `mickeyzzc/releases` |

### 4. 复核并公开

在 Releases 页打开草稿，核对资产列表、发布说明与校验文件后点 **Publish release**，或执行：

```bash
gh release edit <product>-v<X.Y.Z> --repo mickeyzzc/releases --draft=false
```

公开时 GitHub 会在本仓库 `main` 上创建该 tag。它指向本文档仓库的提交，与产品源码无关；对应的源码提交写在发布说明末尾。

### 5. 发布之后

- 任选一个资产下载，用 `sha256sum -c checksums.txt --ignore-missing` 自检。
- 产品首次发布时，更新 `README.md`、`README.zh-CN.md` 产品目录中该行的下载链接，以及产品介绍顶部的状态。

## 从私有仓库 CI 自动上传（可选）

私有仓库推送 tag 时构建并上传到本仓库。上传后仍是草稿，由 owner 公开：

```yaml
# 私有仓库 .github/workflows/publish.yml（示意）
on:
  push:
    tags: ["v*"]

jobs:
  publish:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v5
      # …构建步骤：在 dist/ 下产出归档包、checksums.txt 与 notes.md …
      - uses: actions/checkout@v5
        with:
          repository: mickeyzzc/releases
          path: releases-hub
      - name: Upload draft to mickeyzzc/releases
        env:
          GH_TOKEN: ${{ secrets.RELEASES_TOKEN }}
        run: >
          releases-hub/scripts/publish.sh <product> "${GITHUB_REF_NAME#v}"
          dist/notes.md dist/*.tar.gz dist/*.zip dist/checksums.txt
```
