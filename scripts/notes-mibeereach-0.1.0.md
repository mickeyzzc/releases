## Highlights

- First release of MiBeeReach: a self-hosted, privacy-first remote access
  platform. Remote desktop, terminal, SSH and port forwarding share one
  connection layer and one device identity — everything stays inside your
  network.
- Zero-configuration LAN discovery: controlled machines running the host
  service appear automatically on the console; no accounts, no cloud.
- Full remote desktop: video, keyboard/mouse, clipboard (text / image /
  files), file transfer, audio, multi-monitor switching, view-only mode,
  adaptive quality under weak network, optional hardware video encoding.
- One desktop console (Windows) as the controller hub: quick connect,
  device grid, embedded terminal and SSH tabs, session monitor with live
  speed / RTT / FPS / bitrate.
- Pairing-gated security: credential-less connections are rejected; paired
  devices connect silently; session-level permissions (control / clipboard /
  files) and view-only mode.

## Changes

### Added

- First public release. Windows x64 (host, console) and Linux x86_64 /
  arm64 (host).

### Fixed

- n/a (initial release)

## Upgrade notes

- None (initial release).

## Downloads

| Platform | File | Contents |
|---|---|---|
| Windows x64 (controller) | `mibeereach_windows_amd64.zip` | console `reach-config.exe` + `reach.exe` |
| Windows x64 (controlled) | `MiBeeReach-Host_0.1.0_x64-setup.exe` | host installer (per-user, tray autostart) |
| Linux x86_64 (controlled) | `mibeereach_linux_amd64.tar.gz` | `reach-host`, `reach` |
| Linux arm64 (controlled) | `mibeereach_linux_arm64.tar.gz` | `reach-host`, `reach` |
| macOS arm64 (controller) | `mibeereach_macos_aarch64.tar.gz` | console `.app` + viewer `.app` |

Verify with `sha256sum -c checksums.txt --ignore-missing` · Product guide: [products/mibeereach](https://github.com/mickeyzzc/releases/tree/main/products/mibeereach)

<sub>Built from private source commit `d5c091d`.</sub>
