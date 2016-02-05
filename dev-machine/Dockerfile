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
        apt-transport-https \
        build-essential \
        curl \
        unzip \
        vim-gnome && \
    apt-get upgrade -y


###############################################################################
#
# Docker
#
# docker (latest in apt) + docker-compose 1.5.2
#
###############################################################################


RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 \
        --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
    echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" >> \
        /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get install -y docker-engine
RUN curl -L https://github.com/docker/compose/releases/download/1.6.0/docker-compose-`uname -s`-`uname -m` > \
    /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose


###############################################################################
#
# K8s (Kubernetes)
#
# kubectl 1.1.4
#
###############################################################################


WORKDIR /tmp
RUN curl -O https://storage.googleapis.com/kubernetes-release/release/v1.1.4/bin/linux/amd64/kubectl && \
    chmod +x kubectl &&\
    mv kubectl /usr/local/bin/kubectl


###############################################################################
#
# HELM (latest)
#
###############################################################################


RUN curl -s https://get.helm.sh | bash && \
    mv helm /usr/local/bin/helm


################################################################################
#
# Terraform (0.6.8)
#
###############################################################################


WORKDIR /tmp
RUN curl -O https://releases.hashicorp.com/terraform/0.6.8/terraform_0.6.8_linux_amd64.zip && \
    unzip terraform_0.6.8_linux_amd64.zip && \
    rm terraform_0.6.8_linux_amd64.zip && \
    mv terraform* /usr/local/bin/.


###############################################################################
#
# VIM
#
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


WORKDIR /home/core

