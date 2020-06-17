FROM prom/prometheus:v2.17.1

FROM alpine:3.11.5

RUN apk add gettext

RUN DIRS="/prometheus /etc/prometheus" && \
    mkdir -p $DIRS && \
    chown -R nobody:nogroup $DIRS

USER nobody

# Forced to specify chown otherwise the owner in swarm is root
COPY --from=0 --chown=nobody:nogroup /bin/prometheus /bin/prometheus
COPY --from=0 --chown=nobody:nogroup /etc/prometheus/prometheus.yml /etc/prometheus/prometheus.yml

VOLUME [ "/prometheus" ]
WORKDIR /prometheus

EXPOSE 9090

COPY ./docker-entrypoint.sh /bin/docker-entrypoint.sh
ENTRYPOINT ["/bin/docker-entrypoint.sh"]
CMD [ "--config.file=/etc/prometheus/prometheus.yml", \
      "--storage.tsdb.path=/prometheus" ]
