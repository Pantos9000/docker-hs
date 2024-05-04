#!/bin/bash
set -euo pipefail

. lib.sh
. config.sh

docker build --tag="$app_name" ..
docker_x_run "$app_name" ./setup_app.sh
save_and_delete_container "$app_name"
