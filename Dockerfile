FROM alpine:latest

ENV FLIGHTRADAR_VERSION=1.0.48-0

RUN apk update && apk upgrade && apk add --no-cache wget ca-certificates && \
    wget -O - https://repo-feed.flightradar24.com/linux_binaries/fr24feed_${FLIGHTRADAR_VERSION}_amd64.tgz|tar -xzvf - -C /bin --strip 1 && \
    apk del wget

    ADD fr24feed.ini /etc/fr24feed.ini

EXPOSE 8754

ENTRYPOINT ["fr24feed"]