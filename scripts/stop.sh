#!/bin/bash
set -euo pipefail

. lib.sh
. config.sh

docker stop "${app_name}_container"
