#!/bin/bash

ss-server -s :: -s 0.0.0.0 -p 8338 -k "${SS_PASSWORD}" -m ${SS_METHOD} -u &

./kcp_server \
	-l ":41111" \
	-t "127.0.0.1:8338" \
	--crypt ${KCP_CRYPT} \
	--mode ${KCP_MODE} \
	--ds ${KCP_DS} \
	--ps ${KCP_PS} \
	--rcvwnd ${KCP_RCVWND} \
	--sndwnd ${KCP_SNDWND} \
	--mtu ${KCP_MTU}

# FROM https://github.com/xtaci/kcptun
