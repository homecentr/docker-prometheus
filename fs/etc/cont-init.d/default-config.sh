#!/usr/bin/with-contenv ash

if [ ! -f "/config/prometheus.yml" ]; then
    echo "Using default configuration."
    cp /etc/prometheus/prometheus.yml /config/prometheus.yml
fi