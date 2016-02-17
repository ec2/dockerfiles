## Ubuntu Dev Docker

Development container to be used in the cloud.

### Motivations

#### Good network speed inside the cloud

#### A cleaner approach to dev machines

#### Cheaper laptop

### Example Usage

```
docker run -ti --rm \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v $(pwd):/home/core \
	--net=host \
	hermanjunge/dev-machine bash
```

