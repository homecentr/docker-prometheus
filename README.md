[![Project status](https://badgen.net/badge/project%20status/stable%20%26%20actively%20maintaned?color=green)](https://github.com/homecentr/docker-prometheus/graphs/commit-activity) [![](https://badgen.net/github/label-issues/homecentr/docker-prometheus/bug?label=open%20bugs&color=green)](https://github.com/homecentr/docker-prometheus/labels/bug) [![](https://badgen.net/github/release/homecentr/docker-prometheus)](https://hub.docker.com/repository/docker/homecentr/prometheus)
[![](https://badgen.net/docker/pulls/homecentr/prometheus)](https://hub.docker.com/repository/docker/homecentr/prometheus) 
[![](https://badgen.net/docker/size/homecentr/prometheus)](https://hub.docker.com/repository/docker/homecentr/prometheus)

![CI/CD on master](https://github.com/homecentr/docker-prometheus/workflows/CI/CD%20on%20master/badge.svg)

# HomeCentr - prometheus

Repack of [prometheus](https://prometheus.io/) with the usual Homecentr bells and whistles.

## Usage

```yml
version: "3.7"
services:
  prometheus:
    image: homecentr/prometheus
    ports:
      - 9090:9090
    volumes:
      - ./example:/prometheus
```

## Environment variables

| Name | Default value | Description |
|------|---------------|-------------|
| PUID | 7077 | UID of the user prometheus should be running as. |
| PGID | 7077 | GID of the user prometheus should be running as. |
| PROMETHEUS_ARGS | See the Dockerfile | Additional command line arguments passed to the Prometheus executable. |

## Exposed ports

| Port | Protocol | Description |
|------|----------|-------------|
| 9090 | TCP | Web UI and API. |

## Volumes

| Container path | Description |
|------------|---------------|
| /config | Prometheus configuration. This should container the `prometheus.yml` configuration file. |
| /prometheus | Prometheus state. Make sure the volume is writable for PUID/PGID. |

## Security
The container is regularly scanned for vulnerabilities and updated. Further info can be found in the [Security tab](https://github.com/homecentr/docker-prometheus/security).

### Container user
The container supports privilege drop. Even though the container starts as root, it will use the permissions only to perform the initial set up. The prometheus process runs as UID/GID provided in the PUID and PGID environment variables.

:warning: Do not change the container user directly using the `user` Docker compose property or using the `--user` argument. This would break the privilege drop logic.