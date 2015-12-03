## Ubuntu Dev Docker

A container to be able to develop with vim, and do some makes with containers, inside coreOS.

### Motivation

Yes. I am all hyped with containers. Or am I?

...

Have you tried to work with containers, heavy repos and sh*t having a _sad_ 4 Mbps connection? I do! Welcome to SCL!

### Example Usage

```
docker run -ti --rm \
	-e DEV_ENV_HOST_DIR=/home/core/dev/router \
	-e DEIS_REGISTRY=0.0.0.0:5000/ \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v $(pwd):/root/dev \
	--net=host \
	hermanjunge/ubuntu-dev-docker bash
```

Will give you a dev environment with

* Environment variables set
* The docker socket, so we use the host's docker daemon
* Mount the current folder into the container
* Some people hate the `--net=host`, some people not...
