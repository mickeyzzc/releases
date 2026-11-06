# 👁️ MiBeeVision

**The video-AI engine for MiBeeNvr — the NVR makes sure footage is captured, MiBeeVision makes sure it is understood.**

[English](README.md) · [简体中文](README.zh-CN.md) · [Docs](https://www.mickeybee.cn/docs/mibeevision) · [← All products](../../README.md)

| | |
|---|---|
| **Status** | ✅ v0.1.0 released (Lite) |
| **Platforms** | Linux amd64 · arm64 |
| **License** | Proprietary (bundled detection model YOLOv8n is AGPL-3.0; using it constitutes acceptance of its obligations) |
| **Downloads** | [Releases tagged `mibee-vision-v*`](https://github.com/mickeyzzc/releases/releases?q=mibee-vision) |

## What it does

MiBeeVision is the server-side AI detection component of MiBeeNvr: it runs **object detection, multi-object tracking and zone rules** over the NVR's recordings, fires events for zone intrusion / line crossing / loitering, and writes results back to the NVR — every recording gets an AI badge in the recording list, and triggered events appear on the NVR's AI events page.

It complements the NVR's built-in browser-side AI: the browser AI covers the live view while a page is open, while MiBeeVision is a standalone process that analyzes recordings segment by segment 7×24 and retains events and bounding-box snapshots.

## Key features

- **Object detection** — built-in YOLOv8n model on ONNX Runtime (CPU); recognizes people, vehicles, animals and other common objects with zero model configuration.
- **Multi-object tracking** — ByteTrack cross-frame association with stable IDs and trajectories; loitering and crossing judgment are built on top of it.
- **Three event rules** — zone intrusion, line crossing, loitering; draw zones and boundary lines per camera in the config page, effective on save.
- **Events + boxed snapshots** — structured events in a local store, each with a bounding-box snapshot, so you can see what triggered it.
- **Write-back to MiBeeNvr** — AI badges in the recording list (in progress / completed) + the AI events page; the analysis lives inside the NVR.
- **Web config page** (default `:9092`) — enter the NVR address and API key, pick a camera, draw rules; fully graphical, no hand-edited config files.

## Quick start

```bash
# 1. Download the release assets (binary + matching .so + checksums.txt) and verify:
sha256sum -c checksums.txt --ignore-missing

# 2. Put the binary and the matching .so in one directory, then run (ORT_DYLIB_PATH required):
ORT_DYLIB_PATH=/opt/mibee-vision/libonnxruntime-1.17.1-linux-aarch64.so \
  /opt/mibee-vision/mibee-vision-lite-v0.1.0-linux-aarch64 serve

# 3. Open http://<host-ip>:9092 in a browser
#    enter the NVR address → paste the mbv_ API key → "Test connection and fetch cameras"
#    → pick a camera → draw rule zones → "Save (pipeline restarts)"
```

Two must-read prerequisites (missing either shows up as "the config page opens, but no events ever appear"):

1. **`ORT_DYLIB_PATH` must point at the bundled `libonnxruntime-*.so`**;
2. **Use the NVR's `mbv_` API key** (NVR "Settings → AI Detection → Generate API Key"), not the web login token (`mbs_`).

The full manual lives in the [documentation center](https://www.mickeybee.cn/docs/mibeevision); a bundled `README.txt` ships with every release.

## Editions

- **Lite (current release, free)** — single camera, CPU inference, distributed free with the MiBeeNvr ecosystem.
- **Planned** — multiple cameras, GPU acceleration, batch re-analysis of historical footage (release date TBA).

MiBeeVision uses its own version line (`mibee-vision-vX.Y.Z`), independent of MiBeeNvr version numbers.
