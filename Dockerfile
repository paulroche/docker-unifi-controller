# build docker image to run the unifi controller
#
# the unifi contoller is used to admin ubunquty wifi access points
#
FROM ubuntu
ENV DEBIAN_FRONTEND noninteractive

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
			  openjdk-8-jre-headless

RUN mkdir -p /var/log/supervisor /usr/lib/unifi/data && \
    touch /usr/lib/unifi/data/.unifidatadir

ADD http://dl.ubnt.com/unifi/5.0.7/unifi_sysvinit_all.deb /var/cache/apt/archives/unifi_sysvinit_all.deb
RUN dpkg -i /var/cache/apt/archives/unifi_sysvinit_all.deb; apt-get install -f -q -y && rm -f /var/cache/apt/archives/unifi_sysvinit_all.deb

WORKDIR /usr/lib/unifi
CMD ["java", "-Xmx256M", "-jar", "/usr/lib/unifi/lib/ace.jar", "start"]
