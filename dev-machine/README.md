## Herman's Dev Machine

Development container to be used in the cloud.

### Motivations

* I need to have a quick-to-get dev machine in the cloud.
* If you create a coreOS machine, you already have docker.
* So, you just setup a coreOS machine in the cloud, and run this image.
* That's all, now you can develop with a cheap laptop on a ~shi..~ speed-challenging internet.

### What is in this image?

* Docker 1.10.3 (Just the client, didn't bother to setup the server)
* Kubernetes Client (`kubectl`) 1.2.2.
* Terraform 0.6.14
* Golang 1.6 tools: gofmt and goimports
* VIM, my flavour, which was shameless copied from scrooloose's setup.
* VIM go, so I can do golang format magic.
* A bash file, contains git completition script, some git configs and lang envs.

This machine is thought to run over a coreOS machine, so it does two tricks:

* Using `/home/core` mounted and as work directory. So you can store stuff.
* Mounting the docker socket of the host.

### Example Usage

```
docker run -ti --rm \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v $(pwd):/home/core \
	--net=host \
	hermanjunge/dev-machine bash
```

