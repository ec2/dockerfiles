FROM ubuntu
MAINTAINER Herman Junge "chpdg42@gmail.com"

###############################################################################
#
# APT packages
#
# vim-gnome contains support for python, which is not enabled by default
#
###############################################################################

RUN apt-get update && \
    apt-get install -y \
        curl \
        git \
        make \
	gcc \
        vim-gnome \
	locales && \
    locale-gen en_US.UTF-8 && \
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
# go + gofmt + goimports (golang 1.7.4)
# Please note that I'm not installing go, but tools to help editing go files.
#
###############################################################################

WORKDIR /tmp
RUN curl -O https://storage.googleapis.com/golang/go1.9.linux-amd64.tar.gz && \
    tar -xvf go1.9.linux-amd64.tar.gz && \
    GOROOT=/tmp/go GOPATH=/tmp/gopath /tmp/go/bin/go get golang.org/x/tools/cmd/goimports && \
    mv /tmp/go /usr/local && \
    mv /tmp/gopath/bin/goimports /usr/local/bin/goimports

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
# "That" problem
#
###############################################################################

RUN locale-gen en_US.UTF-8

###############################################################################
#
# We are set
#
###############################################################################

WORKDIR /home/core
