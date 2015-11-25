# Version: 1.0.0
FROM golang:1.5
MAINTAINER Herman Junge "chpdg42@gmail.com"


###############################################################################
#
# APT packages
#
# locales is to fix the infamous ubuntu locale problem
# vim-gnome contains support for python, which is not enabled by default
#
###############################################################################


RUN apt-get update && \
    apt-get install -y \
        locales \
        vim-gnome


################################################################################
#
# Setup locales
#
# Ubuntu infamous problem
#
###############################################################################


RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen en_US.utf8 && \
    /usr/sbin/update-locale LANG=en_US.UTF-8


##############################################################################
#
# Golang packages
#
# godep, goimports
# BDD testing libraries
#
###############################################################################


RUN go get github.com/tools/godep && \
    go get golang.org/x/tools/cmd/goimports && \
    go get github.com/onsi/ginkgo/ginkgo && \
    go get github.com/onsi/gomega


###############################################################################
#
# Set environment variables
#
###############################################################################


ENV GO15VENDOREXPERIMENT 1


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
# We are set
#
###############################################################################


WORKDIR /go/src


