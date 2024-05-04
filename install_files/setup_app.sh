#!/bin/bash
set -euo pipefail

bnet_url="https://www.battle.net/download/getInstallerForGame?os=win&locale=enGB&version=LIVE&gameProgram=BATTLENET_APP"
bnet_installer="Battle.net-Setup.exe"
bnet_conf_path="/root/.wine/drive_c/users/root/Application Data/Battle.net"

# set wine to 32 bit
export WINEARCH=win32

# download bnet app
curl -J -L "$bnet_url" > $bnet_installer

# disable automated creation of shortcuts
regedit reg/disable-winemenubuilder.reg

# disable libs that cause problems
regedit reg/disable-locationapi.reg

# enable csmt, vaapi
regedit reg/enable-vaapi.reg
winetricks csmt=on

# install needed libraries
winetricks -q corefonts vcrun2015

# set windows version to win7
winetricks --optout win7

# set d3d9 for hearthstone
mkdir -p "$bnet_conf_path"
echo "{ \"Client\": { \"HardwareAcceleration\": \"false\" }, \"Games\": { \"hs_beta\": { \"AdditionalLaunchArguments\": \"-force-d3d9\" } } }" > "$bnet_conf_path/Battle.net.config"

# run setup
wine "$bnet_installer"

# wait to finish before closing container
./wait_for_wineserver.sh
