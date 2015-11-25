## Go development environment

### Motivation

Containerize the tools I need to develop in `golang`, including `vim` and BDD support.

### Image

In my public docker repository

    hermanjunge/go-dev-env

### Image contains

* `godep`
* `goimports`
* A fix to that `locale` problem that plagues me now and then.
* My `vimfiles`, with some configs and `vim-go` and the symlink to `vimrc`.
* `ginkgo` and `gomega`. BDD libraries that I enjoy using.

### Wait, I don't want to use your image `hermanjunge`

Fine, take the `Dockerfile` and build the image yourself

    docker build -t not-hermanjunge/go .

### Use

Say you have the package `happy_donald_duck/awesome`, which is represented in `golang` lingo as `github.com/happy_donald_duck/awesome`.

Step into the directory you downloaded it and enter

    docker \
        run \
        -ti \
        --rm \
        -v $(pwd):/go/src/github.com/happy_donald_duck/awesome \
        -w /go/src/github.com/happy_donald_duck/awesome \
        hermanjunge/go-dev-env \
        bash

And you are set.

### Wishlist

* I haven't figured out how to fix the "vim clipboard in docker container" problem. You can't paste code you found in your browser running in the host to `vim` running in the container.

