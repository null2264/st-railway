#!/bin/sh

if [ ! -e "persist/config/config.yaml" ]; then
    echo "Resource not found, copying from defaults: config.yaml"
    cp -r "default/config.yaml" "persist/config/config.yaml"
fi

# Start the server
exec node server.js --listen
