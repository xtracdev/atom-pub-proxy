# Proxy Notes - Nginx and Docker

## Context

The es atom publisher serves up an atom feed of event store events. The
event store feeds are immutable as they represent an ordered set of 
events, each of which is immutable. All feeds except the recent
feed are immutable, and the retrieval of a feed or event has
cache headers that are immutable as well. Therefore the use of 
a caching proxy in front of the feed will allow the access of 
feeds to be scaled up.

## Docker

The easiest way to run nginx as a proxy is in a docker container,
and the easiest way to run the proxy and es-atom-pub is via 
docker-compose.

## Health check inspection

To troubleshoot the container health check, use docker inspect, e.g.

<pre>
docker inspect --format "{{json .State.Health }}" container-name
</pre>

For example: `docker inspect --format "{{json .State.Health }}" devcenter_nginxproxy_1`

## Constraints

The certificate naming convention baked into the Dockerfile's health
check must be observed, and aligned with the volume mounting convention in the
docker compose file. Also, use the subject alt names extension to 
associate the nginxproxy cert both with the docker-compose network
name (nginxproxy) and the endpoint clients will access it using.


## AWS ECS Support

Use the feedsvc.yaml Cloud Formation Template. Prior to its use, create
the repositories and push the images.

You can create the repos using the aws command line, e.g.

<pre>
aws ecr create-repository --repository-name xtracdev/atompub
aws ecr create-repository --repository-name xtracdev/nginxproxy
</pre>

Then tag and push - you probably need to do a login first:

<pre>
`aws ecr get-login`
docker tag xtracdev/atompub:latest xxxx.dkr.ecr.us-west-2.amazonaws.com/xtracdev/atompub:latest 
docker push xxxx.dkr.ecr.us-west-2.amazonaws.com/xtracdev/atompub:latest
</pre>


## Contributing

To contribute, you must certify you agree with the [Developer Certificate of Origin](http://developercertificate.org/)
by signing your commits via `git -s`. To create a signature, configure your user name and email address in git.
Sign with your real name, do not use pseudonyms or submit anonymous commits.


In terms of workflow:

0. For significant changes or improvement, create an issue before commencing work.
1. Fork the respository, and create a branch for your edits.
2. Add tests that cover your changes, unit tests for smaller changes, acceptance test
for more significant functionality.
3. Run gofmt on each file you change before committing your changes.
4. Run golint on each file you change before committing your changes.
5. Make sure all the tests pass before committing your changes.
6. Commit your changes and issue a pull request.

## License

(c) 2017 Fidelity Investments
Licensed under the Apache License, Version 2.0
