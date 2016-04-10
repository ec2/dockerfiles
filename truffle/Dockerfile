FROM node:5.10.1-slim

MAINTAINER Herman Junge "chpdg42@gmail.com"

################################################################################
#
# So. This is what is going on:
#
# * We are using a slim version of the node.js docker image.
# * git is needed during the process of installing truffle.
# * After truffle is installed, we get rid of a number of directories.
# * And we remove git and the programs we installed as its dependencies.
# * The result? Just one moderate layer over node slim.
#
################################################################################

RUN apt-get update -y && apt-get install -y git \
    && npm install -g truffle@1.0.0 \
    && rm -rf /tmp/* /root/.npm/* /var/lib/apt/lists/* \
    && apt-get purge -y --auto-remove git
