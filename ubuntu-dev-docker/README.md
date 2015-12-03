## Ubuntu Dev Docker

A container to be able to develop with vim, and do some makes with containers, inside coreOS.

Yes. I am all hyped with containers. Or am I?

...

Have you tried to work with containers, heavy repos and sh*t having a _sad_ 4 Mbps connection? I do! Welcome to SCL!

### Usage

	docker run -ti --rm -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):/root/dev hermanjunge/ubuntu-dev-docker bash

Will give you your dev env with coreOS' docker socket.
