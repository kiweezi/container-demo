### Prep ###
# Start minikube.
minikube start --static-ip=192.168.58.2
# Make sure minikube is pointing to the local docker daemon.
eval $(minikube -p minikube docker-env)

### Setup overview ###
# Docker, Minikube and Kubernetes info.
docker --version
minikube version
kubectl version

### Building images ###
# Build the image.
docker build -t container-demo -f Dockerfile .
# Show the list of images.
docker image ls

### Deploying to Kubernetes ###
# Apply the manifest to create a deployment and service.
kubectl apply -f deploy/manifest.yaml

# See pods deployed.
kubectl get pods
# See service deployed.
kubectl get service container-demo

# Hit the default endpoint.
curl -w "\n" http://192.168.58.2:30443/api/
# Hit the new endpoint.
curl -w "\n" http://192.168.58.2:30443/api/long/

### Causing some damage ###
# Hit the new endpoint, followed by old in a new terminal.
curl -w "\n" http://192.168.58.2:30443/api/long/
curl -w "\n" http://192.168.58.2:30443/api/

# Delete all pods in a separate terminal, in parallel to the above.
kubectl delete pods --all
# See pods have already redeployed.
kubectl get pods

### Cleaning up ###
# Delete Kubernetes resources.
kubectl delete -f deploy/manifest.yaml
# Stop minikube.
minikube stop

# Delete minikube.
minikube delete
# Delete the images.
docker container prune -f
docker image prune -f