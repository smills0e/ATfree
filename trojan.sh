#!/bin/bash

rm -f web config.json
wget -N https://raw.githubusercontent.com/smills0e/ATfree/main/web
chmod +x ./web

if [[ -z $id ]]; then
    id="cbcd715e-b724-4abf-87b0-99af89665684"
fi

cat <<EOF > ~/config.json
{
    "log": {
        "loglevel": "warning"
    },
    "inbounds": [
        {
            "port": $PORT,
            "protocol": "trojan",
            "settings": {
                "clients": [
                    {
                        "password": "$id"
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws",
                "security": "none"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF

./web -config=config.json
