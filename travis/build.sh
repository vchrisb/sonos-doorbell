#!/usr/bin/env bash

# Login into docker
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

architectures="arm/v7 arm64/v8 amd64"
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
      --output type=image,name=docker.io/$DOCKER_USERNAME/sonos-doorbell:test-build,push=true \
      --opt platform=$platforms \
      --opt filename=./Dockerfile.cross

# Push image for every arch with arch prefix in tag
for arch in $architectures
do
# Build for all architectures and push manifest
  buildctl build --frontend dockerfile.v0 \
      --local dockerfile=. \
      --local context=. \
      --output type=image,name=docker.io/$DOCKER_USERNAME/sonos-doorbell:test-build-$arch,push=true \
      --opt platform=linux/$arch \
      --opt filename=./Dockerfile.cross
done
