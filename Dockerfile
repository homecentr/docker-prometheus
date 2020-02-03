ARG PROMETHEUS_VERSION=v2.9.2

FROM homecentr/base:1.0.0 as base
FROM prom/prometheus:$PROMETHEUS_VERSION as prom

FROM alpine:3.11.3

ARG PROMETHEUS_VERSION
ENV PROMETHEUS_ARGS="--config.file=/etc/prometheus/prometheus.yml --storage.tsdb.path=/prometheus --web.console.libraries=/usr/share/prometheus/console_libraries --web.console.templates=/usr/share/prometheus/consoles"

LABEL maintainer="Lukas Holota <me@lholota.com>"
LABEL org.homecentr.dependency-version=$PROMETHEUS_VERSION

RUN apk add --no-cache \
    shadow=4.7-r1 \
    curl=7.67.0-r0

# Copy S6 overlay
COPY --from=base / /

# Copy Prometheus binaries and default configuration
COPY --from=prom /bin/prometheus /bin/prometheus
COPY --from=prom /prometheus /prometheus
COPY --from=prom /etc/prometheus /etc/prometheus

# Copy S6 overlay configuration
COPY ./fs/ /

HEALTHCHECK --interval=20s --timeout=5s --start-period=5s --retries=3 CMD curl --fail http://127.0.0.1:9090/status || exit 1

WORKDIR /prometheus

EXPOSE 9090

VOLUME /prometheus

ENTRYPOINT [ "/init" ]