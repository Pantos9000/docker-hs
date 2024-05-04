#!/bin/bash
set -euo pipefail

. lib.sh
. config.sh

docker_x_run "$app_name" "/bin/bash"
