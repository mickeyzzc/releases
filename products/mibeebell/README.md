# 🔔 MiBeeBell

**Lightweight self-hosted alert hub — one small binary between everything that alerts and everyone who needs to hear about it.**

[English](README.md) · [简体中文](README.zh-CN.md) · [Product site](https://bell.mickeyzzc.tech) · [Documentation](https://www.mickeybee.cn/docs/mibeebell) · [← All products](../../README.md)

| | |
|---|---|
| **Status** | In development — no release published yet |
| **Platforms** | Linux amd64 · arm64 · 32-bit ARM, Windows amd64 |
| **License** | AGPL-3.0 (source code planned to be opened) |
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

## Quick start (once a release is available)

```bash
tar -xzf mibee-bell_linux_arm64.tar.gz
./mibee-bell hash-password --password 'your-admin-password'   # prints a password_hash

cat > config.yaml <<'EOF'
server:
  listen: ":9080"
auth:
  password_hash: "$2a$10$..."      # from the previous command
storage:
  path: ./mibee-bell.db
ingest:
  webhook_tokens:
    - token: "a-long-random-token"
      default_source: "myapp"
  alertmanager: true
EOF

./mibee-bell -config config.yaml
```

Open `http://<host>:9080`, log in, add a channel and fire a test alert. The full manual is in the [documentation center](https://www.mickeybee.cn/docs/mibeebell).
