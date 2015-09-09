# Godep

A golang:1.5 container with godep

## Motivation

I like to have my programs elsewhere the route given by go (i.e. `$GOPATH/src/`). So I configure a `Makefile` to do the steps to get my dependencies and put them in the vendor directory.

## Example of use

In a `Makefile`

````bash
TEST_CONTAINER := gopherscl_gorrion_testing
PACKAGE_PATH := /go/src/bitbucket.org/tidchile/gorrion

godep:
	@docker version >/dev/null || { echo >&2 "Docker is needed. Aborting."; exit 1; }

	@docker stop ${TEST_CONTAINER} 2>/dev/null || true
	@docker rm ${TEST_CONTAINER} 2>/dev/null || true

	@docker run -ti \
		--name ${TEST_CONTAINER} \
		-e GO15VENDOREXPERIMENT=1 \
		-v $(shell pwd):${PACKAGE_PATH} hermanjunge/godep \
		/bin/bash -c "cd ${PACKAGE_PATH} && \
						godep get && \
						godep save"

	@docker stop ${TEST_CONTAINER} >/dev/null || true
	@docker rm ${TEST_CONTAINER} >/dev/null || true
````
