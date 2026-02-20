FROM debian:trixie-slim

ENV FLIGHTRADAR_VERSION=1.0.54-0

ARG TARGETPLATFORM

RUN apt-get update && apt-get -y upgrade && \
    apt-get -y install wget ca-certificates && \
    case ${TARGETPLATFORM} in \
      linux/amd64) \
        wget -O - https://repo-feed.flightradar24.com/linux_binaries/fr24feed_${FLIGHTRADAR_VERSION}_amd64.tgz|tar -xzvf - -C /bin --strip 1 \
        ;; \
      linux/arm64|linux/arm/v7) \
        wget -O - https://repo-feed.flightradar24.com/rpi_binaries/fr24feed_${FLIGHTRADAR_VERSION}_arm64.tgz|tar -xzvf - -C /bin --strip 1 \
        ;; \
      *) \
        echo "Unknown platform ${TARGETPLATFORM}" && \
        return 1; \
        ;; \
    esac

RUN apt-get -y purge wget && \
    apt-get --purge -y autoremove && \
    apt-get clean && \
    rm -r /var/lib/apt/lists/*

ADD ./config/fr24feed.ini /etc/fr24feed.ini

EXPOSE 8754

ENTRYPOINT ["fr24feed"]
