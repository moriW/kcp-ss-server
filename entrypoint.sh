#!/bin/bash

ss-server -s :: -s 0.0.0.0 -p 8338 -k "${SS_PASSWORD}" -m ${SS_METHOD} -u &

./kcp_server \
	-l ":41111" \
	-t "127.0.0.1:8338" \
	--crypt none \
	--mode fast3 \
	--ds 10 \
	--ps 3 \
	--mtu 1350
	# --rcvwnd 512 \
	# --sndwnd 128 \

# FROM https://github.com/xtaci/kcptun
