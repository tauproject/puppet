# $Tau: puppet/Dockerfile $

## ------------------------------------------------------------------------- ##
##                          T A U    P R O J E C T                           ##
## ------------------------------------------------------------------------- ##
##                                                                           ##
## This file forms part of the Tau Project and is subject to copyright.      ##
##                                                                           ##
## For full licensing terms, including conditions for redistribution, please ##
## consult the README document accompanying the source distribution:         ##
##                                                                           ##
##   <https://github.com/tauproject/puppet>                                  ##
##                                                                           ##
## ------------------------------------------------------------------------- ##

FROM debian:stretch

ENV container docker
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive
RUN echo 'APT::Install-Recommends "0"; \n\
APT::Get::Assume-Yes "true"; \n\
APT::Get::force-yes "true"; \n\
APT::Install-Suggests "0";' > /etc/apt/apt.conf.d/01buildconfig

RUN apt-get update -qq && \
	apt-get -qq -y install mingetty puppet lsb-base lsb-release gpg \
			apt-transport-https

RUN apt-get install procps

RUN cd /tmp && \
	apt-get install -qq -y initscripts sysv-rc && \
	apt-get download sysvinit-core && \
	dpkg --unpack sysvinit-core*.deb && \
	rm /var/lib/dpkg/info/sysvinit-core.postinst && \
	dpkg --configure sysvinit-core && \
	rm sysvinit-core*.deb

VOLUME /var/lib/docker

RUN update-rc.d mountkernfs.sh disable && \
	update-rc.d mountall.sh disable && \
	update-rc.d mountall-bootclean.sh disable && \
	update-rc.d mountdevsubfs.sh disable && \
	update-rc.d checkfs.sh disable && \
	update-rc.d checkroot.sh disable && \
	update-rc.d checkroot-bootclean.sh disable && \
	update-rc.d hostname.sh disable && \
	update-rc.d hwclock.sh disable && \
	update-rc.d bootlogs disable && \
	update-rc.d mountnfs-bootclean.sh disable && \
	update-rc.d bootmisc.sh disable

COPY docker/rcS /etc/default/rcS
COPY docker/inittab /etc/inittab
COPY docker/startup /sbin/container-startup
COPY docker/ready /sbin/container-ready
RUN chmod 755 /sbin/container-startup /sbin/container-ready

COPY modules /usr/share/puppet/modules
COPY manifests /etc/puppet/manifests
COPY data /etc/puppet/data
COPY docker/hiera.yaml /etc/puppet/hiera.yaml
WORKDIR /root
CMD /bin/bash

ENTRYPOINT [ "/sbin/container-startup" ]
