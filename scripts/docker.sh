### Setup overview ###
# Docker info.
docker --version

### Building images ###
# Build the image.
docker build -t container-demo -f Dockerfile .

# Show the list of images.
docker image ls

# Run the container.
docker run --publish 8080:8080 container-demo

# Hit the default endpoint.
curl http://localhost:8080/api/

### Interacting with the registry ###
# Set the registry address.
REGISTRY=""
# Tag the image with metadata for the registry.
docker tag container-demo $REGISTRY/samples/container-demo
# Push image to the registry.
docker push $REGISTRY/samples/container-demo

# Remove local created images.
docker image remove container-demo
docker image remove $REGISTRY/samples/container-demo --force

# Pull image from the registry.
docker pull $REGISTRY/samples/container-demo

# Run the container.
docker run --publish 8080:8080 $REGISTRY/samples/container-demo

# Hit the default endpoint.
curl http://localhost:8080/api/

### Cleaning up ###
docker container prune -f
docker image prune -f
docker buildx prune -f