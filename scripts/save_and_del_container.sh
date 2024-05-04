#!/bin/bash
set -euo pipefail

. lib.sh
. config.sh

save_and_delete_container "$app_name"
