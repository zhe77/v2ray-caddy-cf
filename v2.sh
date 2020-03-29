#!/bin/bash

apt-get install curl git -y
git clone https://github.com/phlinhng/docker-caddy-v2ray-cf.git
curl -sSL https://get.docker.com/ | sh
curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

cd docker-caddy-v2ray-cf

read -p "解析到本VPS的域名: " domain
read -p "v2Ray ws路径: " path
read -p "Cloudflare Email: " cfemail
read -p "Cloudflare API KEY: " cfapikey

uuid=$(uuidgen)
sed -i "" "s/FAKEUUID/$uuid/g" ./src/v2ray/config.json
sed -i "" "s/FAKEDOMAIN/$domain/g" ./src/caddy/Caddyfile
sed -i "" "s/FAKEPATH/$path/g" ./src/caddy/Caddyfile
sed -i "" "s/FAKEEMAIL/$cfemail/g" docker-compose.yml
sed -i "" "s/FAKEKEY/$cfapikey/g" docker-compose.yml

docker-compose up --build -d

echo ""
echo "Address: $domain"
echo "Port: 443"
echo "UUID: $uuid"
echo "Alter ID: 36"
echo "Type: websocket"
echo "Hostname: $domain"
echo "Path: /$path"

exit 0