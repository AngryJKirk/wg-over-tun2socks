FROM ghcr.io/wg-easy/wg-easy:latest

RUN apk update && apk add --no-cache \
    iproute2 \
    iputils \
    curl \
    ca-certificates \
    bash \
    wget \
    unzip \
    iptables
RUN wget https://github.com/xjasonlyu/tun2socks/releases/download/v2.5.2/tun2socks-linux-amd64.zip
RUN unzip tun2socks-linux-amd64.zip
RUN mv tun2socks-linux-amd64 /usr/local/bin/tun2socks
RUN mkdir -p /etc/iproute2 && echo "20 lip" >> /etc/iproute2/rt_tables
WORKDIR /app
COPY . .
RUN chmod +x /app/start.sh

CMD ["/bin/bash", "/app/start.sh"]
