#!/bin/bash
set -euo pipefail

. lib.sh
. config.sh

docker_run "$app_name" "apt-get update && apt-get -y upgrade"
save_and_delete_container "$app_name"
