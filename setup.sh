#!/bin/bash

set -e

# Set env vars:
DOCKER_ID="dwr6"
DOCKER_IMAGE="lbg-api-app"

init() {
    echo "Clearing old builds..."
    sleep 2

    docker rm -f $(docker ps -qa) || sleep 1
    docker rmi -f $(docker images -q) || sleep 1

    echo "Docker environment cleared."
}


build_docker_containers() {
    echo "Building images..."
    sleep 1
    docker build -t $DOCKER_ID/$DOCKER_IMAGE . && echo "Image creation successful."
    docker push $DOCKER_ID/$DOCKER_IMAGE && echo "Image pushed to DockerHub."
}


modify_app() {

    echo "Modifying the app..."

    sleep 3

   export PORT=5000

    echo "Port now set to $PORT"

}


run_docker_containers() {
    echo "Spinning up containers..."
    sleep 1
    docker run -d -p 80:$PORT -e PORT=$PORT --name lbg-app $DOCKER_ID/$DOCKER_IMAGE
}

echo "Starting container build..."
sleep 1
init
build_docker_containers
modify_app
run_docker_containers
echo "Build complete."
