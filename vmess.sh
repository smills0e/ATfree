#!/bin/bash

rm -f web config.json
wget -N https://raw.githubusercontent.com/Misaka-blog/AX/main/web
chmod +x ./web

if [[ -z $id ]]; then
    id="b3c38e92-2445-4542-93e6-1fe2dd6089c4"
fi

cat <<EOF > ~/config.json
{
    "log": {
        "loglevel": "warning"
    },
    "inbounds": [
        {
            "port": $PORT,
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "$id"
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
