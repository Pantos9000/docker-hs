#!/bin/bash
set -e

bnet_path="/root/.wine/drive_c/Program Files/Battle.net/Battle.net Launcher.exe"

wine "$bnet_path"
./wait_for_wineserver.sh
