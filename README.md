# Proxy Notes - Nginx and Docker

## Context

The es atom publisher serves up an atom feed of event store events. The
event store feeds are immutable as the represent an ordered set of 
events, each of which are immutable. All feeds except the recent
feed are immutable, and the retrieval of a feed or event has
cache headers that are immutable as well. Therefore the use of 
a caching proxy in front of the feed will allow the access of 
feeds to be scaled up.

## Docker

The easiest way to run nginx as a proxy is in a docker container,
and the easiest way to run the proxy and es-atom-pub is via 
docker-compose.

## Health check inspection

To trouble shoot the container health check, use docker inspect, e.g.

<pre>
docker inspect --format "{{json .State.Health }}" container-name
</pre>