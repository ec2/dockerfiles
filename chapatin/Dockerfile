# Version: 1.0.0
FROM golang:1.5
MAINTAINER Herman Junge "hermanalonsojunge@gmail.com"

# Add Firefox repository
RUN echo deb http://packages.linuxmint.com debian import >> /etc/apt/sources.list
RUN gpg --keyserver pgp.mit.edu --recv-keys 3EE67F3D0FF405B2
RUN gpg --export 3EE67F3D0FF405B2 > 3EE67F3D0FF405B2.gpg
RUN apt-key add ./3EE67F3D0FF405B2.gpg
RUN rm ./3EE67F3D0FF405B2.gpg

# Install Java headless, firefox and deps
RUN  apt-get update -y &&\
	 apt-get install x11vnc xvfb libgtk2.0-0 libasound2 libdbus-glib-1-2 \
			firefox openjdk-7-jre-headless -y &&\
	apt-get clean &&\
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install selenium
RUN mkdir /selenium &&\
	wget http://selenium-release.storage.googleapis.com/2.47/selenium-server-standalone-2.47.1.jar -O /selenium/selenium-server-standalone.jar
COPY selenium-server /selenium/selenium-server
ENV PATH "/selenium:$PATH"

# Golang testing libraries
RUN go get github.com/sclevine/agouti &&\
    go get github.com/onsi/ginkgo/ginkgo &&\
    go get github.com/onsi/gomega

WORKDIR /testapp
ENTRYPOINT ["/testapp/entrypoint.sh"]
