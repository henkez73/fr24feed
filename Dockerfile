FROM alpine:latest

RUN apk update && apk upgrade && apk add wget librtlsdr dump1090

ENV FLIGHTRADAR_VERSION=1.0.48-0

RUN \
 wget https://repo-feed.flightradar24.com/linux_binaries/fr24feed_${FLIGHTRADAR_VERSION}_amd64.tgz &&\
 tar zxf fr24feed_${FLIGHTRADAR_VERSION}_amd64.tgz 

COPY ./fr24feed.ini /etc/fr24feed.ini

WORKDIR /fr24feed_amd64

EXPOSE 8080 8754 30001 30002 30003 30334

ENTRYPOINT ["./fr24feed"]