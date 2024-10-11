#!/bin/bash
set -x
ip tuntap add mode tun dev tun0
ip addr add 192.168.0.33/24 dev tun0
ip link set dev tun0 up

MIP=$(ip r l | grep "default via" | cut -f3 -d" ")
LIP=$(ip a l eth0 | awk '/inet /{ print $2 }' | cut -f1 -d"/")

ip r del default dev eth0
ip r add default via "$MIP" dev eth0 metric 200
ip rule add from "$LIP" table lip
ip r add default via "$MIP" dev eth0 table lip
ip r add "$VLESS_IP"/32 via "$MIP" dev eth0
ip r add default dev tun0 metric 50
nohup tun2socks -device tun://tun0 -proxy socks5://xray:1080 &

node server.js
