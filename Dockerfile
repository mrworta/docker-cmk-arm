FROM centos:latest
MAINTAINER "MrWorta <mrworta@gmail.com>"
EXPOSE 5000 6557

RUN yum install -y epel-release;
RUN yum install -y https://mathias-kettner.de/support/1.2.8p24/check-mk-raw-1.2.8p24-el7-47.x86_64.rpm;
RUN yum install -y which;
RUN yum install -y openssh-clients; yum update -y; yum clean all -q -y

RUN site='luna001_aws'; \
    omd create $site --no-init -u1000 -g1000; \
        omd config $site set APACHE_TCP_ADDR 0.0.0.0; \
        omd config $site set DEFAULT_GUI check_mk; \
        omd config $site set TMPFS off; \
        omd config $site set LIVESTATUS_TCP on; \
        omd config $site set LIVESTATUS_TCP_PORT 6557;

ENTRYPOINT omd update home; omd start; /bin/sh
