# 
FROM debian:stretch
MAINTAINER "MrWorta <mrworta@gmail.com>"
EXPOSE 5000 6557

RUN apt update; apt install -y gcc make curl aptitude libxml-sax-expat-incremental-perl libfile-remove-perl libmodule-scandeps-perl g++;
# Optimize: cmk configure uses aptitude; maybe trick with alias?

RUN cd /tmp; curl https://mathias-kettner.de/support/1.4.0p12/check-mk-raw-1.4.0p12.cre.tar.gz > /tmp/work.tar.gz; tar -xzf work.tar.gz;
WORKDIR /tmp/check-mk-raw-1.4.0p12.cre
RUN ./configure
RUN sed -i 's/alarm(60)/alarm(600)/g' ./t/lib/lib/perl5/BuildHelper.pm ./packages/perl-modules/lib/BuildHelper.pm
RUN sed -i 's/alarm(120)/alarm(1200)/g' ./t/lib/lib/perl5/BuildHelper.pm ./packages/perl-modules/lib/BuildHelper.pm
RUN sed -i 's/navicli//g' ./Makefile 
RUN sed -i 's/snap7//g' ./Makefile
RUN sed -i 's/nrpe//g' ./Makefile
RUN make EDITION=cre || true

#RUN site='luna001_aws'; \
#    omd create $site --no-init -u1000 -g1000; \
#        omd config $site set APACHE_TCP_ADDR 0.0.0.0; \
#        omd config $site set DEFAULT_GUI check_mk; \
#        omd config $site set TMPFS off; \
#        omd config $site set LIVESTATUS_TCP on; \
#        omd config $site set LIVESTATUS_TCP_PORT 6557;

#ENTRYPOINT omd update home; omd start; /bin/sh
#ENTRYPOINT /bin/cat
