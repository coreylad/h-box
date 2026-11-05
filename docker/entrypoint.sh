#!/bin/bash
set -e
cd /app

# Persistent state lives in /data (mounted volume)
mkdir -p /data/datadir /data/userdir /data/img
[ -f /data/db.sqlite3 ] || cp /app/db.sqlite3 /data/db.sqlite3
ln -sfn /data/db.sqlite3 /app/db.sqlite3
rm -rf /app/userdir && ln -sfn /data/userdir /app/userdir
# the app stores tag/preview images in ./img
cp -rn /app/img/. /data/img/ 2>/dev/null || true
rm -rf /app/img && ln -sfn /data/img /app/img

Xvfb :0 -screen 0 1400x900x24 -ac &
for i in $(seq 1 50); do [ -e /tmp/.X11-unix/X0 ] && break; sleep 0.2; done
fluxbox >/dev/null 2>&1 &
x11vnc -display :0 -forever -shared -nopw -quiet -rfbport 5900 >/dev/null 2>&1 &
websockify --web /usr/share/novnc 6080 localhost:5900 >/dev/null 2>&1 &

echo "H-BOX is running: open http://localhost:6080/vnc.html?autoconnect=1&resize=scale"
exec python main.py
