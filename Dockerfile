FROM nginx:1.11.8

#COPY apt.conf /etc/apt/apt.conf

RUN apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y \
    netcat \
    && rm -rf /var/lib/apt/lists/*

COPY wait_for_feed_server.sh /opt/
COPY getclient /opt/

HEALTHCHECK CMD /opt/getclient /tmp/certs/replicator.key /tmp/certs/replicator.crt /tmp/certs/ca.crt https://nginxproxy:5000/notifications/recent || exit 1

ENTRYPOINT ["/opt/wait_for_feed_server.sh","atomfeedpub","8000"]