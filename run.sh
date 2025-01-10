#!/bin/bash

docker run \
 --detach \
 --restart=unless-stopped \
 --privileged \
 --name fr24feed \
 -p 8080:8080 \
 -p 8754:8754 \
 -p 30001:30001 \
 -p 30002:30002 \
 -p 30003:30003 \
 -p 30334:30334 \
 -v ${PWD}/config/fr24feed.ini:/etc/fr24feed.ini \
fr24feed:test
