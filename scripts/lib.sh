#!/bin/bash
set -euo pipefail

function docker_x_run {
    local image_name
    image_name="$1"
    local cmd
    cmd="$2"
    local container_name
    container_name="${image_name}_container"

    if [ "$(docker ps -qf name=^$container_name\$)" ]; then
        echo "container '$container_name' is already running!"
        exit 1
    fi

    # grant temporary access to X server
    trap "xhost -local:" EXIT
    xhost +local:

    if [ "$(sudo docker ps -aqf name=^$container_name\$)" ]; then
        echo "container '$container_name' already exists, starting..."
        docker start -ai "$container_name"
    else
        docker run -it \
            --name "$container_name" \
            -e DISPLAY="$DISPLAY" \
            -v /tmp/.X11-unix:/tmp/.X11-unix \
            -v /etc/localtime:/etc/localtime:ro \
            --device /dev/dri \
            --device /dev/snd \
            "$image_name" "$cmd"
    fi
}

function docker_run {
    local image_name
    image_name="$1"
    local cmd
    cmd="$2"
    local container_name
    container_name="${image_name}_container"

    if [ "$(docker ps -qf name=^$container_name\$)" ]; then
        echo "container '$container_name' is already running!"
        exit 1
    elif [ "$(docker ps -aqf name=^$container_name\$)" ]; then
        echo "container '$container_name' already exists!"
        exit 1
    fi

    docker run -i \
        --name "$container_name" \
        -v /etc/localtime:/etc/localtime:ro \
        "$image_name" "$cmd"
}

function save_and_delete_container {
    local image_name
    image_name=$1
    local container_name
    container_name="${image_name}_container"

    if [ "$(docker ps -qf name=^$container_name\$)" ]; then
        echo "container '$container_name' is already running!"
        exit 1
    elif [ ! "$(docker ps -aqf name=^$container_name\$)" ]; then
        echo "container '$container_name' does not exist!"
        exit 1
    fi

    docker commit "$container_name" "$image_name"
    docker rm "$container_name"
}
