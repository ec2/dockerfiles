# Truffle

A development framework for ethereum

## Motivation

* Just download one thing: This image; And run it with docker whenever needed.
* Out of the box, ready to use. Do not worry about _node js_ version and _npm_.

## How does it work

### Install docker

Duh...

### Get the image

    docker pull hermanjunge/truffle

Will get you the latest one. Now, for a specific version of truffle, say `1.0.1`, do

    docker pull hermanjunge/truffle:1.0.1

### Basic operations

OK. you have your directory where you are going to build your contract. We will call it
your `working directory` from now on. Let's run the following to init it

    docker run -ti --rm -v $(pwd):/root/my-contract -w /root/my-contract hermanjunge/truffle truffle init

#### Whoa whoa whoa! What is this long line??!!

Yes. I'm aware of that. We are doing several things:

* Running a container based on the image `hermanjunge/truffle`.
* Mounting my contract directory inside this container.
* Setting the mounted directory as the working directory in the container.
* And, running truffle, with the followed by `init`.

As every command follows the same pattern, we will just setup an alias!

### Setting an alias

    alias truffle="docker run -ti --rm -v $PATH_TO_MY_CONTRACT_DIR:/root/my-contract -w /root/my-contract hermanjunge/truffle truffle"

What problem? No problem! From now on you just do

   truffle init

Getting you the same results as having the program installed in your machine (and _node_, and _npm_, etc...)

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
