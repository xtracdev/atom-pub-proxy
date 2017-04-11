FROM nginx:1.11.8

#COPY apt.conf /etc/apt/apt.conf

RUN apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y \
    netcat \
    curl \
    && rm -rf /var/lib/apt/lists/*

COPY wait_for_feed_server.sh /opt/
COPY rp.conf /etc/nginx/nginx.conf

HEALTHCHECK CMD curl --noproxy localhost --fail http://localhost:5000/ping || exit 1

ENTRYPOINT ["/opt/wait_for_feed_server.sh","atomfeedpub","8000"]
