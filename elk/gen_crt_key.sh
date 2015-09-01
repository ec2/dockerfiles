#! /bin/bash

sudo openssl req -config /etc/ssl/openssl.cnf -x509 -days 3650 -batch -nodes -newkey rsa:2048 -keyout ./tls/private/logstash-forwarder.key -out ./tls/certs/logstash-forwarder.crt
