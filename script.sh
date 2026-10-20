
#!/bin/bash
set -euo pipefail

cd /root/ansible

# Convert Jenkins job name to lowercase
IMAGE_NAME=$(echo "$JOB_NAME" | tr '[:upper:]' '[:lower:]')
IMAGE_TAG="$BUILD_ID"
DOCKER_IMAGE="manandock/$IMAGE_NAME"

# Login using Jenkins credentials
echo "$DOCKERHUB_TOKEN" | docker login \
  --username "$DOCKERHUB_USER" \
  --password-stdin

# Build image
docker build -t "$IMAGE_NAME:$IMAGE_TAG" .

# Tag image for Docker Hub
docker tag "$IMAGE_NAME:$IMAGE_TAG" "$DOCKER_IMAGE:$IMAGE_TAG"
docker tag "$IMAGE_NAME:$IMAGE_TAG" "$DOCKER_IMAGE:latest"

# Push images
docker push "$DOCKER_IMAGE:$IMAGE_TAG"
docker push "$DOCKER_IMAGE:latest"

# Clean up local images
docker logout
docker rmi -f \
  "$IMAGE_NAME:$IMAGE_TAG" \
  "$DOCKER_IMAGE:$IMAGE_TAG" \
  "$DOCKER_IMAGE:latest"
