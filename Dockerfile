# Base image to use, this must be set as the first line
FROM shadowsocks/shadowsocks-libev:edge

ARG TARGETOS
ARG TARGETARCH
# ARG TARGETPLATFORM

WORKDIR /etc/app

COPY . .

ENV SS_METHOD=aes-256-gcm \
  SS_PASSWORD=ss-password \
  KCP_CRYPT=none \
  KCP_MODE=fast3 \
  KCP_DS=10 \
  KCP_PS=3 \
  KCP_RCVWND=512 \
  KCP_SNDWND=128 \
  KCP_MTU=1350 \
  OS=${TARGETOS} \
  ARCH=${TARGETARCH}


USER root

# sys env
RUN sysctl -p sysctl.conf && ulimit -n 65535

# install ss
# RUN apk --no-cache https://dl-cdn.alpinelinux.org/alpine/latest-stable/ add shadowsocks-libev jq
RUN apk update && apk add jq

RUN apk --no-cache add net-tools bash

#install kcp 
RUN sh install_kcp.sh

EXPOSE 41111/udp 8338

CMD ["sh", "entrypoint.sh"]

