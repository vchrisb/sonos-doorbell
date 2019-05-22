#!/usr/bin/env bash

# Login into docker
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

architectures="arm arm64 amd64"
images=""
platforms=""

for arch in $architectures
do
# Build for all architectures and push manifest
  platforms="linux/$arch,$platforms"
done

platforms=${platforms::-1}


# Push multi-arch image
buildctl build --frontend dockerfile.v0 \
      --local dockerfile=. \
      --local context=. \
      --output type=image,name=docker.io/$DOCKER_USER/sonos-doorbell:test-build,push=true \
      --opt platform=$platforms \
      --opt filename=./Dockerfile.cross

# Push image for every arch with arch prefix in tag
for arch in $architectures
do
# Build for all architectures and push manifest
  buildctl build --frontend dockerfile.v0 \
      --local dockerfile=. \
      --local context=. \
      --exporter image \
      --exporter-opt name=docker.io/$DOCKER_USER/sonos-doorbell:test-build-$arch \
      --exporter-opt push=true \
      --frontend-opt platform=linux/$arch \
      --frontend-opt filename=./Dockerfile.cross &
done
