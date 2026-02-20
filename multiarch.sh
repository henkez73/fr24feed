#!/bin/bash

#docker buildx create \
#  --name container \
#  --driver=docker-container


docker buildx build \
  --builder container \
  --push \
  --platform linux/amd64,linux/arm/v7,linux/arm64/v8 \
  --tag henkez/fr24feed:1.0.54-0 .
