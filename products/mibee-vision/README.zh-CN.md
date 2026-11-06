# 👁️ MiBeeVision

**MiBeeNvr 的视频 AI 引擎——NVR 负责「录得下」，MiBeeVision 负责「看得懂」。**

[English](README.md) · [简体中文](README.zh-CN.md) · [文档](https://www.mickeybee.cn/docs/mibeevision) · [← 全部产品](../../README.zh-CN.md)

| | |
|---|---|
| **状态** | ✅ v0.1.0 已发布（Lite） |
| **平台** | Linux amd64 · arm64 |
| **许可证** | 专有软件（内置检测模型 YOLOv8n 采用 AGPL-3.0，使用即视为接受其义务） |
| **下载** | [以 `mibee-vision-v` 开头的 Releases](https://github.com/mickeyzzc/releases/releases?q=mibee-vision) |

## 它做什么

MiBeeVision 是 MiBeeNvr 的服务端 AI 检测组件：对 NVR 录下的视频做**目标检测、多目标跟踪与区域规则判定**，按区域入侵 / 越界 / 徘徊生成事件，并把结果回写 NVR——录像列表上每一段视频被打上 AI 标记，触发的事件可在 NVR 的 AI 事件页查看。

与 NVR 内置的浏览器端 AI 检测互补：浏览器端面向「打开页面时的实时画框」，MiBeeVision 是独立进程，7×24 逐段分析录像并留存事件与带框快照，不依赖页面开着。

## 核心能力

- **目标检测**：内置 YOLOv8n 模型（ONNX Runtime CPU 推理），识别画面中的人、车、动物等常见目标，无需单独配置模型。
- **多目标跟踪**：ByteTrack 跨帧关联，目标有稳定 ID 与轨迹——徘徊与越界判定都建立在轨迹之上。
- **三类事件规则**：区域入侵、越界、徘徊；在配置页按摄像头画区域 / 边界线，保存即生效。
- **事件 + 带框快照**：结构化事件落本地库，每条事件附带检测框快照，直接看懂「是什么触发了它」。
- **回写 MiBeeNvr**：录像列表 AI 标记（处理中 / 完成）+ AI 事件页——分析结果长在 NVR 里，不用另开一套系统。
- **Web 配置页**（默认 `:9092`）：填 NVR 地址与 API Key、选摄像头、画规则，全流程图形化，无需手工编辑配置文件。

## 快速上手

```bash
# 1. 下载发布资产（二进制 + 对应架构的 .so + checksums.txt），校验：
sha256sum -c checksums.txt --ignore-missing

# 2. 把二进制与对应 .so 放到同一目录，运行（ORT_DYLIB_PATH 必须设置）：
ORT_DYLIB_PATH=/opt/mibee-vision/libonnxruntime-1.17.1-linux-aarch64.so \
  /opt/mibee-vision/mibee-vision-lite-v0.1.0-linux-aarch64 serve

# 3. 浏览器打开 http://<本机IP>:9092
#    填 NVR 地址 → 粘贴 mbv_ 开头的 API Key → 「测试连接并拉取摄像头」
#    → 选择摄像头 → 设置规则区域 → 「保存(自动重启管线)」
```

两个必读前置（漏掉的表现为「配置页能打开，但永远不出事件」）：

1. **必须设置 `ORT_DYLIB_PATH`** 指向随包的 `libonnxruntime-*.so`；
2. **必须用 NVR 的 `mbv_` API Key**（NVR「设置 → AI 检测 → 生成 API Key」），不是网页登录 token（`mbs_`）。

完整手册见[文档中心](https://www.mickeybee.cn/docs/mibeevision)，发布附件内也有随包 `README.txt`。

## 版本形态

- **Lite（当前发布，免费）**：单摄像头、CPU 推理，随 MiBeeNvr 生态免费分发。
- **规划中**：多摄像头、GPU 加速、历史录像批量补分析（发布时间待公布）。

MiBeeVision 使用独立版本线（`mibee-vision-vX.Y.Z`），与 MiBeeNvr 的版本号相互独立。
