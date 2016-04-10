# Truffle

A development framework for ethereum

## Motivation

* Just download one thing: This image; And run it with docker whenever needed.
* Out of the box, ready to use. Do not worry about _node js_ version and _npm_.

## How does it work

(TODO)
(basic command)
(the working directory)
(using an alias?)

## Advanced usage

(TODO)
(mount your copy of truffle)
(use it with the container of testrpc)

## I want to build my own truffle image

### From the current npm package

Sure. You just need to have the `Dockerfile` in the directory you are and

    docker build -t <your-username>/truffle .

Where `<your-username>/truffle` is the name you are giving to your image.

### Known caveat

Tried to execute `npm install` in a cheap droplet of 512MB RAM. Didn't work,
killing the process randomly. The solution was using a machine with 2048MB RAM.
