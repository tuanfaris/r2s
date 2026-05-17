#!/bin/sh
set -e
IB_URL='https://downloads.immortalwrt.org/releases/25.12.0-rc2/targets/rockchip/armv8/immortalwrt-imagebuilder-25.12.0-rc2-rockchip-armv8.Linux-x86_64.tar.zst'
wget -O imagebuilder.tar.zst "$IB_URL"
tar --use-compress-program=unzstd -xf imagebuilder.tar.zst
rm -rf imagebuilder
mv immortalwrt-imagebuilder-25.12.0-rc2-rockchip-armv8.Linux-x86_64 imagebuilder
cp -a files imagebuilder/files
cd imagebuilder
make image PROFILE="friendlyarm_nanopi-r2s" PACKAGES="$(cat ../configs/packages.txt)" FILES="files" DISABLED_SERVICES="" V=s
