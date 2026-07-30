FROM prom/prometheus:v3.6.0

FROM alpine:3.22

RUN apk add --no-cache gettext

RUN mkdir -p /prometheus /etc/prometheus \
    && chown -R nobody:nogroup /prometheus /etc/prometheus

USER nobody

COPY --from=0 --chown=nobody:nogroup /bin/prometheus /bin/prometheus
COPY --from=0 --chown=nobody:nogroup /etc/prometheus/prometheus.yml /etc/prometheus/prometheus.yml

VOLUME ["/prometheus"]
WORKDIR /prometheus

EXPOSE 9090

COPY --chown=nobody:nogroup 2/docker-entrypoint.sh /bin/docker-entrypoint.sh

ENTRYPOINT ["/bin/docker-entrypoint.sh"]

CMD [
  "--config.file=/etc/prometheus/prometheus.yml",
  "--storage.tsdb.path=/prometheus"
]