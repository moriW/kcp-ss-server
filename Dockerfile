# Base image to use, this must be set as the first line
FROM --platform=${TARGETPLATFORM} alpine
ARG KCP_TAG="20230214"
ARG TARGETOS
ARG TARGETARCH

WORKDIR /etc/app

COPY . .

USER root

# sys env
RUN sysctl -p sysctl.conf && ulimit -n 65535

# install ss
RUN apk --no-cache add --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing shadowsocks-libev

# install kcp
# https://github.com/xtaci/kcptun/releases/download/v20230214/kcptun-linux-amd64-20230214.tar.gz
RUN wget -O kcptun-linux.tar.gz https://github.com/xtaci/kcptun/releases/download/v${KCP_TAG}/kcptun-${TARGETOS}-${TARGETARCH}-${KCP_TAG}.tar.gz \
    && tar -xzvf kcptun-linux.tar.gz && rm kcptun-linux.tar.gz && rm client* && mv server_${TARGETOS}_${TARGETARCH} kcp_server


ENV SS_METHOD=aes-256-gcm \
    KCPTUN_CRYPT=aes KCPTUN_MTU=1350 KCPTUN_MODE=normal \
    KCPTUN_SNDWND=4096 KCPTUN_CLIENT_SNDWND=1024 KCPTUN_RCVWND=8192 \
    KCPTUN_DATASHARD=35 KCPTUN_PARITYSHARD=15

EXPOSE 41111/udp 8338

CMD ["sh", "entrypoint.sh"]

