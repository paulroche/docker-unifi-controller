FROM ubuntu:xenial

ENV DEBIAN_FRONTEND noninteractive
ENV BASEDIR=/usr/lib/unifi \
  DATADIR=/var/lib/unifi \
  RUNDIR=/var/run/unifi \
  LOGDIR=/var/log/unifi \
  JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 \
  JVM_MAX_HEAP_SIZE=1024M \
  JVM_INIT_HEAP_SIZE=

# add unifi and mongo repo
COPY ./100-ubnt.list /etc/apt/sources.list.d/100-ubnt.list

# add ubiquity + 10gen(mongo) repo + key
# update then install
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv C0A52C50 && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10 && \
    apt-get update -q -y && \
    apt-get install -q -y binutils \
			  jsvc \
			  mongodb-server \
			  openjdk-8-jre-headless \
                          wget

RUN mkdir -p /usr/lib/unifi/data && \
    touch /usr/lib/unifi/data/.unifidatadir

COPY docker-entrypoint.sh /

CMD ["/docker-entrypoint.sh"]
