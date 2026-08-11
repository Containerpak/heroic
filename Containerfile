FROM ubuntu:26.04 AS source

ADD --checksum=sha256:2f3bdb663b48144b7804c30724765dc4bdc76357b7cd5f35a5dadf3030f6a948 \
    https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher/releases/download/v2.22.1/Heroic-2.22.1-linux-amd64.deb \
    /tmp/heroic.deb

FROM ghcr.io/containerpak/wine:main

COPY --from=source /tmp/heroic.deb /tmp/heroic.deb

RUN apt update && \
    apt install -y --no-install-recommends /tmp/heroic.deb pciutils xz-utils && \
    rm /tmp/heroic.deb && \
    cpak-clean-junk
