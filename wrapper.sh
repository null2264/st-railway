#!/bin/sh

[ ! -d "./persist/config" ] && mkdir ./persist/config
[ ! -d "./persist/data" ] && mkdir ./persist/data
[ ! -d "./persist/plugins" ] && mkdir ./persist/plugins

export SILLYTAVERN_DISCREET_LOGIN=${SILLYTAVERN_DISCREET_LOGIN:-false}

envsubst < ./config.template.yaml > ./persist/config/config.yaml
# if [ ! -e "./persist/config/config.yaml" ]; then
#     echo "Config not found, copying from template"
#     envsubst < ./config.template.yaml > ./persist/config/config.yaml
# fi

tini -- ./docker-entrypoint.sh
