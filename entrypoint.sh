#!/bin/bash

ss-server -s :: -s 0.0.0.0 -p 8338 -k "${SS_PASSWORD}" -m ${SS_METHOD} -u &

./kcp_server \
  -l ":41111" \
  -t "127.0.0.1:8338" \
  --key "$KCPTUN_PASSWORD" \
  --mtu $KCPTUN_MTU \
  --sndwnd $KCPTUN_SNDWND \
  --rcvwnd $KCPTUN_RCVWND \
  --mode $KCPTUN_MODE \
  --crypt $KCPTUN_CRYPT \
  --datashard $KCPTUN_DATASHARD \
  --parityshard $KCPTUN_PARITYSHARD
