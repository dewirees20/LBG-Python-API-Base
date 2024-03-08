#!/bin/bash

set -e

# Set env vars:
DOCKER_ID="dwr6"
DOCKER_IMAGE="lbg-api-app"

init() {
    echo "Clearing old builds..."

    docker rm -f $(docker ps -qa) || sleep 1
    docker rmi -f $(docker images -q) || sleep 1

    echo "Docker environment cleared."
}


build_docker_containers() {
    echo "Building images..."
    sleep 1
    docker build -t $DOCKER_ID/$DOCKER_IMAGE . && echo "$DOCKER_ID/$DOCKER_IMAGE creation successful."
    docker push $DOCKER_ID/$DOCKER_IMAGE && echo "$DOCKER_ID/$DOCKER_IMAGE pushed to DockerHub."
}


modify_app() {

    echo "Modifying the app..."

    export PORT=5001

    echo "Port now set to $PORT"

}


run_docker_containers() {
    echo "Spinning up containers..."
    docker run -d -p 80:$PORT -e PORT=$PORT --name lbg-app $DOCKER_ID/$DOCKER_IMAGE && echo "$DOCKER_ID/$DOCKER_IMAGE is running"
}



echo "Starting container build..."
sleep 1
init
build_docker_containers
modify_app
run_docker_containers
echo "Build complete."
