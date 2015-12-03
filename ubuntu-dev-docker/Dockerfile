FROM ubuntu:14.04
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
        apt-transport-https \
        build-essential \
        curl \
        locales \
        vim-gnome


################################################################################
#
# Setup locales
#
# Ubuntu infamous problem, at least a recurrent one in SCL (Hablas español?)
#
###############################################################################


RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen en_US.utf8 && \
    /usr/sbin/update-locale LANG=en_US.UTF-8


###############################################################################
#
# Docker
#
# docker + docker-compose
#
###############################################################################


RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 \
        --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
    echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" >> \
        /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get install -y docker-engine
RUN curl -L https://github.com/docker/compose/releases/download/1.5.1/docker-compose-`uname -s`-`uname -m` > \
    /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose


###############################################################################
#
# K8s (Kubernetes)
#
# kubectl 1.12
#
###############################################################################


WORKDIR /tmp
RUN curl -O https://storage.googleapis.com/kubernetes-release/release/v1.1.2/bin/linux/amd64/kubectl && \
    chmod +x kubectl &&\
    mv kubectl /usr/local/bin/kubectl


###############################################################################
#
# VIM
#
# A fork from scrooloose + vim-go + some configs
#
###############################################################################


RUN git clone https://github.com/hermanjunge/vimfiles.git /root/.vim
WORKDIR /root/.vim
RUN git submodule init && \
    git submodule update && \
    ln -s /root/.vim/vimrc .vimrc


###############################################################################
#
# Bash
#
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


WORKDIR /root


