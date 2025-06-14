# wg-over-tun2socks

So let's say you want to connect via Wireguard to a server, but you want this server to actually tunnel all traffic via VLESS or any other Xray-compatible protocol.

I wanted it too and spend some time figuring out how.

## Instructions

### Prerequisites 
1) You need to have a server A with docker installed.
2) You need to have a server B with running xray instance. I recommend [Marzban](https://github.com/Gozargah/Marzban).

### Setup

1) In `config.json` use the outbound corresponding to your server config (for xray reality it's public key, xray server address, sni, UUID, flow. Everything you may see in the connection string.)
2) in `docker-compose.yml` populate env variables with your Wireguard address (server A's public IP) and your VLESS IP-address (server B's public IP)
3) you can also use other env variables, everything that's compatible with [wg-easy](https://github.com/wg-easy/wg-easy/)

> [!NOTE] 
> Everything is configured in the way that your default interface is assumed as `eth0`. If it's not then change the source code of `start.sh` by replacing `eth0` with your interface. You can see your interfaces by calling `ip a`. Find there the inteface that actually serves internet connection, usually it has your NAT IP address and the gateway IP.


### Run

Execute `docker-compose up -d`.
If everything is correct you should be able to use wg-easy frontend and every connection will be run via VLESS tunnel.

