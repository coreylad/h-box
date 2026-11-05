# H-BOX (Docker)

H-BOX downloads videos from websites to local storage and lets you play, favourite, tag and manage them. This repository runs the desktop app inside a Docker container and exposes it in your browser through noVNC.

## Quick start

```bash
docker compose up --build -d
```

Open <http://localhost:6080/vnc.html?autoconnect=1&resize=scale>.

Stop with `docker compose down` (data is kept in the `hbox-data` volume; add `-v` to delete it).

## Plain Docker

```bash
docker build -t hbox .
docker run -d --name hbox -p 6080:6080 --shm-size=1g -v hbox-data:/data hbox
```

## Persistent data

Everything lives in the `/data` volume:

| Path | Contents |
|------|----------|
| `/data/datadir` | Downloaded videos, covers and previews |
| `/data/db.sqlite3` | Application database |
| `/data/userdir` | Chromium profile used by Selenium |
| `/data/img` | Tag backgrounds and favourite snapshots |

To use a host folder instead, replace the volume in `docker-compose.yml`, e.g. `./data:/data`.

## Configuration

| Item | Default | Notes |
|------|---------|-------|
| Port | `6080` | Change the left side of `ports` in `docker-compose.yml` |
| `HBOX_DATA_DIR` | `/data/datadir` | Download location inside the container |
| `FFMPEG_BIN` / `CHROMEDRIVER_BIN` | `ffmpeg` / `chromedriver` | Preinstalled in the image |
| `shm_size` | `1gb` | Needed by Chromium |

Proxies are picked up from the standard `HTTP_PROXY` / `HTTPS_PROXY` environment variables.

## Usage

1. Open the web UI and go to the network download page.
2. Paste a video page URL and press Enter.
3. Downloaded videos appear on the home page, where you can play, favourite, tag and edit them.
4. Download rules live in `rule.toml`; sites are matched by domain and videos are found by regex-matching the requests the page makes (m3u8 or mp4).
5. If a site fails in headless mode, disable headless in Settings and trigger playback manually through the VNC view.

The container runs Xvfb, Fluxbox, x11vnc and noVNC alongside the app. Windows-only features (Chrome profile sync) are disabled.

## Rebuild after changes

```bash
docker compose up --build -d
docker compose logs -f
```

Use responsibly and respect the terms of the sites you download from.
