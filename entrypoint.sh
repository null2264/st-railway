#!/bin/sh

# Because railway's volume is a bitch, it completely wiped ./persist after you attach a volume to it
[ ! -d "./persist/config" ] && mv ./_config ./persist/config
[ ! -d "./persist/data" ] && mv ./_data ./persist/data
[ ! -d "./persist/plugins" ] && mv ./_plugins ./persist/plugins

if [ ! -e "./persist/config/config.yaml" ]; then
    echo "Resource not found, copying from defaults: config.yaml"
    cat ./default/config.yaml |\
        sed 's/^listen: false/listen: true/g' |\
        sed 's/^whitelistMode: true/whitelistMode: false/g' |\
        sed 's/^enableUserAccounts: false/enableUserAccounts: true/g' |\
        sed 's/^enableDiscreetLogin: false/enableDiscreetLogin: true/g' |\
        sed 's/^securityOverride: false/securityOverride: true/g' \
            > ./persist/config/config.yaml
fi

# >> migrations
mv ./persist/config/config.yaml ./persist/config/_config.yaml
cat ./persist/config/_config.yaml | sed 's/^basicAuthMode: true/basicAuthMode: false/g' > ./persist/config/config.yaml
rm ./persist/config/_config.yaml
# << migrations

# Start the server
exec node server.js --listen
