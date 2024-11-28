### Setup overview ###
# Start minikube.
minikube start --static-ip=192.168.58.2

# Docker, Minikube and Kubernetes info.
docker --version
minikube version
kubectl version

### Building images ###
# Make sure minikube is pointing to the local docker daemon.
eval $(minikube -p minikube docker-env)
# Build the image.
docker build -t container-demo -f Dockerfile .
# Show the list of images.
docker image ls
# Tag the image with useful metadata.
docker tag container-demo latest

### Deploying to Kubernetes ###
# Open a tunnel to make networking easier.
minikube tunnel
# Apply the manifest to create a deployment and service.
kubectl apply -f deploy/manifest.yaml

# See pods deployed.
kubectl get pods
# See service deployed.
kubectl get service container-demo

# Hit the default endpoint.
curl -w "\n" http://192.168.58.2:30443/api/

### Cleaning up ###
# Delete Kubernetes resources.
kubectl delete -f deploy/manifest.yaml
# Stop minikube.
minikube stop
# Delete the images.
docker container prune -f
docker image prune -f
docker buildx prune -f