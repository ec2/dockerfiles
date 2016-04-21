FROM ubuntu
MAINTAINER Herman Junge "chpdg42@gmail.com"

###############################################################################
#
# APT packages
#
# apt-transport-https enables to add the docker repository below
# build-essential to run makefiles (and maybe compile something)
# locales is to fix the infamous ubuntu locale problem
# vim-gnome contains support for python, which is not enabled by default
#
###############################################################################

RUN apt-get update && \
    apt-get install -y \
        curl \
        git \
        make \
        vim-gnome && \
    apt-get upgrade -y

###############################################################################
#
# Docker
#
# docker 1.10.3
#
###############################################################################

RUN curl -o /usr/bin/docker https://get.docker.com/builds/Linux/x86_64/docker-1.10.3 && \
    chmod +x /usr/bin/docker

###############################################################################
#
# K8s (Kubernetes)
#
# kubectl 1.2.2
#
###############################################################################

RUN curl -o /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v1.2.2/bin/linux/amd64/kubectl && \
    chmod +x /usr/bin/kubectl

###############################################################################
#
# gofmt + goimports (golang 1.6)
# Please note that I'm not installing go, but tools to help editing go files.
#
###############################################################################

WORKDIR /tmp
RUN curl -O https://storage.googleapis.com/golang/go1.6.linux-amd64.tar.gz && \
    tar -xvf go1.6.linux-amd64.tar.gz && \
    GOROOT=/tmp/go GOPATH=/tmp/gopath /tmp/go/bin/go get golang.org/x/tools/cmd/goimports && \
    mv /tmp/go/bin/gofmt /usr/local/bin/gofmt && \
    mv /tmp/gopath/bin/goimports /usr/local/bin/goimports && \
    rm -rf /tmp/*

###############################################################################
#
# VIM
# A fork from scrooloose + vim-go + some configs
#
###############################################################################

WORKDIR /root/.vim
RUN git clone https://github.com/hermanjunge/vimfiles.git /root/.vim && \
    git submodule init && \
    git submodule update && \
    ln -s /root/.vim/vimrc .vimrc

###############################################################################
#
# Bash Stuff
# .bashrc
#  git-completion
#
###############################################################################

ADD bashrc /root/.bashrc
RUN curl \
    https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash \
    -o \
    /root/.git-completion.bash

###############################################################################
#
# We are set
#
###############################################################################

WORKDIR /home/core
