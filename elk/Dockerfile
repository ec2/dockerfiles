# Dockerfile for ELK stack
# Elasticsearch 1.7.1, Logstash 1.5.4, Kibana 4.1.1

# Based on the elk-docker image by Sebastien Pujadas http://pujadas.net
# Apache 2 License

FROM phusion/baseimage
MAINTAINER Herman Junge <hermanalonsojunge@gmail.com>
ENV REFRESHED_AT 2015-09-01

###############################################################################
#                                INSTALLATION
###############################################################################

### install Elasticsearch

RUN apt-get update -qq \
 && apt-get install -qqy curl

RUN curl http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -
RUN echo deb http://packages.elasticsearch.org/elasticsearch/1.7/debian stable main > /etc/apt/sources.list.d/elasticsearch.list

RUN apt-get update -qq \
 && apt-get install -qqy \
		elasticsearch \
		openjdk-7-jdk \
 && apt-get clean


### install Logstash

ENV LOGSTASH_HOME /opt/logstash
ENV LOGSTASH_PACKAGE logstash-1.5.4.tar.gz

RUN mkdir ${LOGSTASH_HOME} \
 && curl -O https://download.elasticsearch.org/logstash/logstash/${LOGSTASH_PACKAGE} \
 && tar xzf ${LOGSTASH_PACKAGE} -C ${LOGSTASH_HOME} --strip-components=1 \
 && rm -f ${LOGSTASH_PACKAGE} \
 && groupadd -r logstash \
 && useradd -r -s /usr/sbin/nologin -d ${LOGSTASH_HOME} -c "Logstash service user" -g logstash logstash \
 && chown -R logstash:logstash ${LOGSTASH_HOME} \
 && mkdir -p /var/log/logstash /etc/logstash/conf.d

ADD ./init/logstash-init /etc/init.d/logstash
RUN sed -i -e 's#^LS_HOME=$#LS_HOME='$LOGSTASH_HOME'#' /etc/init.d/logstash \
 && chmod +x /etc/init.d/logstash


### install Kibana

ENV KIBANA_HOME /opt/kibana
ENV KIBANA_PACKAGE kibana-4.1.1-linux-x64.tar.gz

RUN mkdir ${KIBANA_HOME} \
 && curl -O https://download.elasticsearch.org/kibana/kibana/${KIBANA_PACKAGE} \
 && tar xzf ${KIBANA_PACKAGE} -C ${KIBANA_HOME} --strip-components=1 \
 && rm -f ${KIBANA_PACKAGE} \
 && groupadd -r kibana \
 && useradd -r -s /usr/sbin/nologin -d ${KIBANA_HOME} -c "Kibana service user" -g kibana kibana \
 && chown -R kibana:kibana ${KIBANA_HOME}

ADD ./init/kibana-init /etc/init.d/kibana
RUN sed -i -e 's#^KIBANA_HOME=$#KIBANA_HOME='$KIBANA_HOME'#' /etc/init.d/kibana \
 && chmod +x /etc/init.d/kibana


###############################################################################
#                               CONFIGURATION
###############################################################################

### configure Elasticsearch

ADD ./init/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml


### configure Logstash

# cert/key -> Will be mounted at runtime
RUN mkdir -p /etc/pki/tls/certs && mkdir /etc/pki/tls/private


###############################################################################
#                                   START
###############################################################################

EXPOSE 5601 9200 9300 5000

# This one is left in order to keep log data across container restarts
VOLUME /var/lib/elasticsearch
CMD ["/usr/local/bin/entrypoint.sh"]
