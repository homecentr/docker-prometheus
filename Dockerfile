FROM prom/prometheus:v2.24.1 as prom

FROM homecentr/base:2.4.3-alpine

ENV PROMETHEUS_ARGS="--web.console.libraries=/usr/share/prometheus/console_libraries --web.console.templates=/usr/share/prometheus/consoles"

LABEL maintainer="Lukas Holota <me@lholota.com>"
LABEL org.homecentr.dependency-version=v2.9.2

RUN apk add --no-cache \
    curl=7.69.1-r0

# Copy Prometheus binaries and default configuration
COPY --from=prom /bin/prometheus /bin/prometheus
COPY --from=prom /prometheus /prometheus
COPY --from=prom /etc/prometheus /etc/prometheus

# Copy S6 overlay configuration
COPY ./fs/ /

HEALTHCHECK --interval=20s --timeout=5s --start-period=5s --retries=3 CMD curl --fail http://127.0.0.1:9090/status || exit 1

WORKDIR /prometheus

EXPOSE 9090

VOLUME /config
VOLUME /prometheus

ENTRYPOINT [ "/init" ]