#!/bin/sh

# Move default directories to persist dir
[ ! -d "./persist/config" ] && mv ./_config ./persist/config
[ ! -d "./persist/data" ] && mv ./_data ./persist/data
[ ! -d "./persist/plugins" ] && mv ./_plugins ./persist/plugins

export PORT=${PORT:-8080}
export SILLYTAVERN_DISCREET_LOGIN=${SILLYTAVERN_DISCREET_LOGIN:-false}

envsubst < ./config.template.yaml > ./persist/config/config.yaml
# if [ ! -e "./persist/config/config.yaml" ]; then
#     echo "Config not found, copying from template"
#     envsubst < ./config.template.yaml > ./persist/config/config.yaml
# fi

tini -- ./docker-entrypoint.sh
