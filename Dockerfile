FROM python:3.11-slim-bookworm

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    DISPLAY=:0 \
    QT_QUICK_BACKEND=software \
    QT_QPA_PLATFORM=xcb \
    QTWEBENGINE_DISABLE_SANDBOX=1 \
    HBOX_DATA_DIR=/data/datadir

RUN apt-get update && apt-get install -y --no-install-recommends \
        xvfb x11vnc novnc websockify fluxbox xdotool \
        chromium chromium-driver ffmpeg \
        libegl1 libgl1 libglib2.0-0 libdbus-1-3 libfontconfig1 libxkbcommon-x11-0 \
        libxcb-cursor0 libxcb-icccm4 libxcb-image0 libxcb-keysyms1 libxcb-randr0 \
        libxcb-render-util0 libxcb-shape0 libxcb-xinerama0 libxcb-xkb1 libnss3 \
        libpulse0 fonts-noto-core fonts-noto-cjk \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .
RUN chmod +x docker/entrypoint.sh && rm -f chromedriver.exe ffmpeg.exe

EXPOSE 6080
VOLUME ["/data"]
ENTRYPOINT ["/app/docker/entrypoint.sh"]
