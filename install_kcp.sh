#!/bin/bash

echo $OS
echo $ARCH
platform="$OS-$ARCH"
echo $platform

echo $TARGETPLATFORM

echo '----------------------------'

cmd="wget -q -O - https://api.github.com/repos/xtaci/kcptun/releases/latest | jq -r '.assets[].browser_download_url | select(contains(\"$platform\"))'"
echo $cmd
url=$(eval $cmd)
echo "--------------- find satify kcp ---------------"
echo "$url"

echo "--------------- downloading --------------- "
wget -O kcptun-linux.tar.gz $url

echo "--------------- installing --------------- "
tar -xzvf kcptun-linux.tar.gz
rm kcptun-linux.tar.gz
rm client*
mv server* kcp_server

echo '----------------------------'

# url=`wget -q -O - https://api.github.com/repos/xtaci/kcptun/releases/latest | jq -r '.assets[].browser_download_url | select(contains("$OS-$ARCH"))'`
# echo $url
# url=$(wget -q -O - https://api.github.com/repos/xtaci/kcptun/releases/latest | jq -r '.assets[].browser_download_url | select(contains("$OS-$ARCH"))')
# echo $url
# wget -O $url
# tar -xzvf kcptun-linux.tar.gz
# rm kcptun-linux.tar.gz
# rm client* && mv server_$OS_$ARCH kcp_server
