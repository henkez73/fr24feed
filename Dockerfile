FROM debian:bullseye-slim

ENV FLIGHTRADAR_VERSION=1.0.48-0

RUN apt-get update && apt-get -y upgrade && \
    apt-get -y install procps wget ca-certificates && \
    wget -O - https://repo-feed.flightradar24.com/linux_binaries/fr24feed_${FLIGHTRADAR_VERSION}_amd64.tgz|tar -xzvf - -C /bin --strip 1 && \
    apt-get -y purge wget && \
    apt-get --purge -y autoremove && \
    apt-get clean && \
    rm -r /var/lib/apt/lists/*

ADD ./config/fr24feed.ini /etc/fr24feed.ini

EXPOSE 8754

ENTRYPOINT ["fr24feed"]