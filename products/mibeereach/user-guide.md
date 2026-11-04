# MiBeeReach User Guide

**v0.1.0 — LAN direct edition** · [简体中文](user-guide.zh-CN.md) · [Product page](README.md)

Self-hosted, privacy-first remote access: remote desktop, terminal, SSH and
port forwarding over your local network — no accounts, no cloud, no
third-party relay.

---

## 1. Thirty-second overview

| Role | Machine | What you install |
|---|---|---|
| **Controlled side** (the machine you connect TO) | Windows / Linux | **Host** — runs in the background, waits for connections |
| **Controller side** (the machine you connect FROM) | Windows / macOS | **Console** (desktop app) — discover devices, open sessions |

Both sides must be on the same local network. The controller discovers
controlled machines automatically — no accounts, no configuration.

## 2. Install

### 2.1 Windows — controlled side

1. Download `MiBeeReach-Host_0.1.0_x64-setup.exe` from the
   [release page](https://github.com/mickeyzzc/releases/releases/tag/mibeereach-v0.1.0).
2. Run the installer (per-user install to `%LOCALAPPDATA%\MiBeeReach-Host`,
   optional "start on boot").
3. The host runs in the system tray and listens on `0.0.0.0:7777`.

### 2.2 Windows — controller side

1. Download `mibeereach_windows_amd64.zip`.
2. Extract anywhere and run `reach-config.exe` — that is the console.
3. (`reach.exe` next to it is the engine the console launches for sessions;
   keep the two files in the same folder.)

### 2.3 Linux — controlled side

1. Download `mibeereach_linux_amd64.tar.gz` (x86_64) and extract:

   ```sh
   tar xzf mibeereach_linux_amd64.tar.gz
   ```

2. Start the host:

   ```sh
   ./reach desktop host --bind 0.0.0.0:7777 --fps 20
   ```

3. To keep it running across sessions, wrap that command in your service
   manager of choice (systemd user unit, tmux, rc.local, …).

### 2.4 macOS — controller side (Apple Silicon)

1. Download `mibeereach_macos_aarch64.tar.gz` and extract — you get
   `MiBeeReach.app` (console) and `MiBeeReach Viewer.app`.
2. Copy both to **Applications**.
3. First launch: right-click → **Open** to pass Gatekeeper (the bundle is
   ad-hoc signed).

## 3. First connection

1. Start a controlled machine's host (section 2.1 / 2.3).
2. Open the console on the controller machine (section 2.2 / 2.4) — the
   **Connect** page is the default.
3. Machines on the same network segment **appear automatically** in the
   device grid within a few seconds. Click **Connect** on one.
4. Nothing discovered? Type the address directly into **Quick Connect** as
   `ip:port`, e.g. `192.168.1.10:7777`, and press **Connect**.
5. The remote desktop opens as a tab in the **Workspace** page.

All open sessions (desktop / terminal / SSH) live as tabs in the Workspace;
the toolbar controls quality, audio, zoom, monitor switching, and screen
recording.

## 4. LAN access key (optional pairing gate)

By default the host generates a persistent **LAN key** on first start and
rejects connections that do not present it (pairing-gated security).
Manage it on the controlled machine:

```sh
reach desktop lan-key          # show / generate the persisted key
reach desktop host --bind 0.0.0.0:7777 --lan-key 00112233...ff   # explicit key
reach desktop host --bind 0.0.0.0:7777 --lan-open               # open mode (any LAN machine may connect)
```

On the controller side, paste the same key into the console's
**LAN access code** field (Quick Connect row), or pass it on the CLI:

```sh
reach desktop connect --host 192.168.1.10:7777 --lan-key 00112233...ff
```

## 5. Inside a desktop session

| Feature | How |
|---|---|
| Clipboard (text / image / files) | copy & paste as usual, both directions |
| File transfer | drag & drop or the session toolbar |
| Audio | toolbar **Audio** toggle (`Ctrl+Alt+M`) |
| Quality presets | toolbar **Quality** (`Ctrl+Alt+Q`): original / data-saver / balanced |
| Monitor switching | toolbar **Monitor** (`Ctrl+Alt+N`) |
| View-only mode | granted at pairing; input is disabled |
| Zoom / fill / 100% | toolbar (`Ctrl+Alt+0` fit, `Ctrl+Alt+±` zoom) |
| Stats overlay (fps / latency / bitrate) | toolbar **Stats** (`Ctrl+Alt+I`) |
| Fullscreen | `Ctrl+Alt+F` / `F11`; `Esc` exits |
| Screen recording output | toolbar **Record** (`Ctrl+Alt+R`; host must run with `--record`) |

## 6. Other session types

```sh
# Terminal (remote shell over the same transport)
reach terminal host  --bind 0.0.0.0:7778     # controlled side
reach terminal connect --host 192.168.1.10:7778   # controller side

# Port forwarding (expose an intranet TCP service)
reach tunnel host   --bind 0.0.0.0:7779      # controlled side
reach tunnel connect --host 192.168.1.10:7779 --local 127.0.0.1:2223 --target 127.0.0.1:22
# then: ssh -p 2223 anyone@127.0.0.1  → lands on the controlled machine's :22
```

The console also has an **SSH sessions** card: store "device + username"
presets and open them as embedded terminal tabs.

## 7. Troubleshooting

| Symptom | Fix |
|---|---|
| Device not discovered | Same subnet? Host running? Router AP/client isolation blocks broadcast discovery — use Quick Connect `ip:port` instead |
| Connect timeout | Allow **UDP 7777** (terminal 7778 / tunnel 7779) through the controlled machine's firewall |
| Auth rejected | LAN key mismatch — compare `reach desktop lan-key` output with the controller's access code |
| Stutter / low fps | Switch quality preset to data-saver; weak links adapt automatically |
| macOS app won't open | Right-click → Open to pass Gatekeeper |
| Quick Connect rejects a bare device ID | This edition connects by address — enter `ip:port` |

## 8. License

Proprietary — see the `LICENSE` file shipped in every package and the
[product page](README.md).

MiBeeReach © Mi-Bee Studio. All rights reserved.
