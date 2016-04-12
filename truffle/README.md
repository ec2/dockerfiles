# Truffle

A development framework for ethereum

## Motivation

* Just download one thing: This image; And run it with docker whenever needed.
* Out of the box, ready to use. Do not worry about _node js_ version and _npm_.

## Requirements

* Docker `1.10+`. Haven't tried in an older version. Please report.

## Quick Start

* Set an alias for your command `truffle`.

```
alias truffle="docker run \
-ti \
--rm \
-e USER_ID=`id -u` \
-e GROUP_ID=`id -g` \
-v $(pwd):/workspace \
hermanjunge/truffle \
truffle"
```

* Run your command (ex: `init`)

```
truffle init
```
And that's all! Read below to learn more about this image.

## Basic Usage

### Get the image

    docker pull hermanjunge/truffle

Will get you the latest one. Now, for a specific version of truffle, say `1.0.0`, do

    docker pull hermanjunge/truffle:1.0.0

### Setting an alias

This is a dirty trick, so we can ignore the long and ugly one-liner needed

Step in the directory we are going to use to develop our contract, and execute

```
alias truffle="docker run \
-ti \
--rm \
-e USER_ID=`id -u` \
-e GROUP_ID=`id -g` \
-v $(pwd):/workspace \
hermanjunge/truffle \
truffle"
```

### Invoke truffle

Now we can invoke truffle, as we were using the real thing

    truffle init

Getting you the same results as having the program installed in your machine (and _node_, and _npm_, etc...)

### Explanation

* `docker run -ti --rm` will make an interactive (i.e. with console) container which will delete itself on exit.
* ``-e USER_ID=`id -u`` will set up as an env variable your user id. So we can `chown` the files on `truffle init`.
* ``-e GROUP_ID=`id -g``` same as above, but with group id.
* `-v $(pwd):/workspace` will mount your contract directory into the container. `/workspace` is the directory inside.

## I want to build my own truffle image

### From the current npm package

Sure. Just stand in this very directory and execute

    docker build -t <your-username>/truffle .

Where `<your-username>/truffle` is the name you are giving to your image.

### Known caveat

Tried to execute `npm install` in a cheap droplet of 512 MB RAM. Didn't work,
killing the process randomly. The solution was using a machine with 2048 MB RAM.
