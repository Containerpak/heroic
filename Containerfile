FROM ubuntu:26.04 AS source

ADD --checksum=sha256:7524871e7ec3466085e75594d0ecc901b21fb8193434e58fd2fc6ae44732043a \
    https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher/releases/download/v2.22.2/Heroic-2.22.2-linux-amd64.deb \
    /tmp/heroic.deb

FROM ghcr.io/containerpak/wine:main

RUN --mount=type=bind,from=source,source=/tmp/heroic.deb,target=/run/heroic.deb \
    apt update && \
    apt install -y --no-install-recommends /run/heroic.deb pciutils xz-utils && \
    cpak-clean-junk
