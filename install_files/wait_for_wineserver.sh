#!/bin/bash
set -euo pipefail

sleep 10
tail --pid="$(pgrep wineserver | head -n 1)" -f /dev/null
