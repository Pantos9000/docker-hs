#!/bin/bash
set -euo pipefail

. lib.sh
. config.sh

# run installed app
docker_x_run "$app_name" ./run_app.sh
