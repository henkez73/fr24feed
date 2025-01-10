FROM debian:bookworm-slim

RUN apt update && \
    apt install -y \
      #libbladerf2 \
      #libhackrf0 \
      #liblimesuite22.09-1 \
      #libncurses6 \
      wget \
      librtlsdr0 &&\
      #libsoapysdr0.8 && \
    rm -rf /var/lib/apt/lists/*

#RUN \
# apt-get install -y \
#  wget \
#  build-essential &&\
# rm -rf /var/lib/apt/lists/*

ENV FLIGHTRADAR_VERSION=1.0.48-0

RUN \
 wget https://repo-feed.flightradar24.com/linux_binaries/fr24feed_${FLIGHTRADAR_VERSION}_amd64.tgz &&\
 tar zxf fr24feed_${FLIGHTRADAR_VERSION}_amd64.tgz &&\
 export LD_LIBRARY_PATH=/usr/local/lib64/:$LD_LIBRARY_PATH

COPY ./config/fr24feed.ini /etc/fr24feed.ini

COPY ./bin/dump1090 /usr/local/bin/

WORKDIR fr24feed_amd64

EXPOSE 8080 8754 30001 30002 30003 30334

ENTRYPOINT ["./fr24feed"]