#!/bin/sh

# Because railway's volume is a bitch, it completely wiped ./persist after you attach a volume to it
[ ! -d "./persist/config" ] && mv ./_config ./persist/config
[ ! -d "./persist/data" ] && mv ./_data ./persist/data
[ ! -d "./persist/plugins" ] && mv ./_plugins ./persist/plugins

if [ ! -e "./persist/config/config.yaml" ]; then
    echo "Resource not found, copying from defaults: config.yaml"
    cp -r "./default/config.yaml" "./persist/config/config.yaml"
fi

# Start the server
exec node server.js --listen
