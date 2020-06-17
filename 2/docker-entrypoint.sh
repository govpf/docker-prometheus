#!/bin/sh

TEMPLATE_FILE="${TEMPLATE_FILE:-/etc/prometheus/prometheus.orig.yml}"
CONFIGURATION_FILE="${CONFIGURATION_FILE:-/etc/prometheus/prometheus.yml}"

if [ -f "$TEMPLATE_FILE" ]
then
    echo "Template file found ($TEMPLATE_FILE). Generating prometheus configuration ($CONFIGURATION_FILE)!!!"
    envsubst < "$TEMPLATE_FILE" > "$CONFIGURATION_FILE"
fi

exec /bin/prometheus "$@"
