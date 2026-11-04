# 🔔 MiBeeBell

**Lightweight self-hosted alert hub — one small binary between everything that alerts and everyone who needs to hear about it.**

[English](README.md) · [简体中文](README.zh-CN.md) · [Product site](https://bell.mickeyzzc.tech) · [Documentation](https://www.mickeybee.cn/docs/mibeebell) · [← All products](../../README.md)

| | |
|---|---|
| **Status** | ✅ v0.1.0 released (2026-11-04) |
| **Platforms** | Linux amd64 · arm64 · 32-bit ARM, Windows amd64; native fnOS packages (ARM64 / x86) |
| **License** | To be announced |
| **Downloads** | [Releases tagged `mibeebell-v*`](https://github.com/mickeyzzc/releases/releases?q=mibeebell) |

## What it does

MiBeeBell collects events from everything that "alerts" in your home or office — NVRs, monitoring, scripts, IoT devices, Prometheus — runs them through one configurable pipeline, and delivers clean notifications to WeCom, DingTalk, Feishu, Telegram, email and more: **no notification storms, quiet recoveries, and a hub that never becomes a silent single point of failure**.

```
MiBeeNvr (NVR) ─────────────┐
MiBeeSteward (assets) ──────┤                      ┌─ WeCom / DingTalk / Feishu
Prometheus / Alertmanager ──┼──▶  MiBeeBell  ──────┼─ Telegram / Slack / Discord / Email
any script / cron / IoT ────┘    (pipeline +       ├─ generic Webhook
                                  denoise)          └─ MiBeeScout app
```

## Key features

- **Seven ingest formats** — generic Webhook, Alertmanager-compatible, PagerDuty Events v2-compatible, Grafana native, simple JSON (ntfy / Gotify style), Bark-compatible and MQTT. Existing senders usually only need a new URL.
- **Alert pipeline** — dedup, aggregation, cooldown, escalation and silence windows, plus automatic recovery notices: a camera flapping 30 times a minute becomes one message.
- **Channels for China and the world** — WeCom, DingTalk, Feishu, Telegram, Slack, Discord, SMTP email, generic Webhook and the MiBeeScout app. One channel is one adapter, so a platform policy change only ever affects that channel.
- **High availability** — run 2–5 all-active nodes; any node can fail without interrupting notifications.
- **Optional AI triage** — off by default; AI can only downgrade severity and never drops an event, so notifications keep flowing without it.
- **Truly self-hosted** — zero cloud dependency; channel credentials are stored encrypted on your own disk.
- **Small and complete** — one CGO-free binary with an embedded web UI (English / Chinese) and built-in SQLite storage; about 20 MB of memory, designed to run on a Raspberry Pi.

## Quick start

**fnOS**: download the fpk matching your NAS from Releases (`-arm64.fpk` for ARM64 models, `-amd64.fpk` for Intel/AMD models), install it via the App Center, and open BeeBell from the desktop — the first visit walks you through setting the admin password.

**Binary**:

```bash
tar -xzf mibee-bell_linux_arm64.tar.gz
./mibee-bell -listen :9080
```

Open `http://<host>:9080` — the first visit guides you through setting the admin password (≥8 characters, stored locally), then add a channel and fire a test alert.

**Your first alert**: Settings → ingest tokens, create one, then

```bash
curl -X POST "http://<host>:9080/api/ingest/webhook/<token>" \
  -H "Content-Type: application/json" \
  -d '{"type":"device_lost","severity":"warning","title":"Camera offline","body":"unreachable for 10 minutes","source_ref":"cam-01"}'
```

The full user guide ships as `user-guide.md` in each release; the online version lives in the [documentation center](https://www.mickeybee.cn/docs/mibeebell).
