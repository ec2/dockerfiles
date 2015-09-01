This document / tutorial gives you insight on setting up an ELK
(ElasticSearcg, Logstash & KIbana) System.

# Ubuntu

Build an [Ubuntu 14.10 machine](http://www.ubuntu.com/download/alternative-downloads).

## Brand new

Add to `/etc/environment`

    LC_ALL=en_US.UTF-8
    LANG=en_US.UTF-8

Restart bash...

Then

    sudo locale-gen "en_US.UTF-8"
    sudo dpkg-reconfigure locales
    sudo apt-get update -y
    sudo apt-get upgrade -y

So you avoid all those nasty `locale` errors.

## Install Docker

    curl -sSL https://get.docker.com/ | sh

Then

    docker version

should output

    Client:
     Version:      1.8.1
     API version:  1.20
     Go version:   go1.4.2
     Git commit:   d12ea79
     Built:        Thu Aug 13 02:35:49 UTC 2015
     OS/Arch:      linux/amd64

    Server:
     Version:      1.8.1
     API version:  1.20
     Go version:   go1.4.2
     Git commit:   d12ea79
     Built:        Thu Aug 13 02:35:49 UTC 2015
     OS/Arch:      linux/amd64

## Install Docker compose

    curl -L https://github.com/docker/compose/releases/download/1.4.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose

Then

    docker-compose -v

should output

    docker-compose version: 1.4.0

## Get this repository's subfolder

Hey, I'm assuming you haven't done that yet...

We are using the technique of the _sparse checkout_. Learn it by reading [here](http://git-scm.com/docs/git-read-tree) (Section Sparse Checkout) and [here](http://stackoverflow.com/a/13738951).

    git init
    git remote add -f origin https://github.com/hermanjunge/dockerfiles.git
    git config core.sparseCheckout true
    echo "elk" >> .git/info/sparse-checkout
    git pull origin master

Finally, we step on the directory

    cd elk

## Generate your own SSL cert

*IMPORTANT:* Do this in the event you need certificates. For example you are using lumberjack type logs.

    vim /etc/ssl/openssl.cnf

Find the `[ v3_ca ]` section in the file, and add this line under it
(substituting in the Logstash Server's private IP address):

    subjectAltName = IP: <your_machine_ip>

*NOTE:* Don't do it in production. (We all know you won't, pero... nunca
falta el _personaje_).

Now generate the SSL certificate and private key

    sudo openssl req -config /etc/ssl/openssl.cnf -x509 -days 3650 -batch -nodes -newkey rsa:2048 -keyout ./tls/private/logstash-forwarder.key -out ./tls/certs/logstash-forwarder.crt

Feeling lazy? Here's a script that does the very thing the command above does

    ./gen_crt_key.sh

*NOTE:* Even as these files are `testing purposes only`... Don't share them, don't etc.

## Create the ELK container

Build the docker image. (Replace `shalldoek` for your username, or whatever)

    docker build -t shalldoek/elk .

Go for a cup of [matcha](https://en.wikipedia.org/wiki/Matcha).

## Start the ELK Container

This image is based on [the one from spujadas](http://spujadas.github.io/elk-docker/), the main difference is, we left some _logstash_ configuration files in the directory `filter`, so we can modify them and mount them on runtime. That way, we can test different configurations without the need to build the image again. Also, the executable was moved into the path `bin/entrypoint.sh`.

OK. To start our container, we will use Docker compose

    docker-compose up

## Checking the Applications

### Logstash

Make sure that your input file is like

    input {
      syslog {
        port => 5000
      }
    }

Just do a `telnet`

    [ hermanjunge: tmp ]$ telnet elk 5000
    Trying X.Y.Z.78...
    Connected to elk.
    Escape character is '^]'.
    TEST
    ^]
    telnet> quit
    Connection closed.

Which takes us to...

### ElasticSearch

The check of elasticSearch is straightforward.

    [ hermanjunge: tmp ]$ curl http://shalldoek:9200/_search?pretty
    {
      "took" : 5,
      "timed_out" : false,
      "_shards" : {
        "total" : 5,
        "successful" : 5,
        "failed" : 0
      },
      "hits" : {
        "total" : 1,
        "max_score" : 1.0,
        "hits" : [ {
          "_index" : "logstash-2015.09.01",
          "_type" : "logs",
          "_id" : "AU-J0UBSUj4ijiA8phiF",
          "_score" : 1.0,
          "_source":{"message":"TEST\r\n","@version":"1","@timestamp":"2015-09-01T16:50:36.237Z","host":"200.54.242.52","tags":["_grokparsefailure_sysloginput"],"priority":0,"severity":0,"facility":0,"facility_label":"kernel","severity_label":"Emergency"}
        } ]
      }
    }

### Kibana

Finally, we open up our browser and point to the elk IP and port 5601. The configuration of Kibana is outside the scope of this tutorial.

# Developer Client Side

Pretty simple if you are using syslog: Just add the following lines to your each `docker-compose` container you want to monitorize.

    log_driver: syslog
    log_opt:
        syslog-address: "tcp://X.Y.Z.8:5000"
        syslog-tag: "my_container"


References
==========

-   [Sebastian Pujadas Tutorial](http://spujadas.github.io/elk-docker/)
-   [Digital Ocean
    Tutorial](https://www.digitalocean.com/community/tutorials/how-to-install-elasticsearch-logstash-and-kibana-4-on-ubuntu-14-04)
-   [Rob Layton
    Tutorial](http://www.roblayton.com/2015/03/docker-setup-for-elasticsearch-logstash.html)
