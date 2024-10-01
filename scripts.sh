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
# Push image to the registry.
docker push mytmptst.azurecr.io/samples/container-demo

# Remove image.
docker image remove container-demo

# Pull image from the registry.
docker pull mytmptst.azurecr.io/samples/container-demo

# Run the container.
docker run --publish 8080:8080 container-demo

# Hit the default endpoint.
curl http://localhost:8080/api/

# Remove image.
docker image remove container-demo