# @(#) $Tau: puppet/docker/puppet-selftest/Dockerfile $

## ------------------------------------------------------------------------- ##
##                          T A U    P R O J E C T                           ##
## ------------------------------------------------------------------------- ##
##                                                                           ##
##  Licensed under the Apache License, Version 2.0 (the "License");          ##
##  you may not use this file except in compliance with the License.         ##
##                                                                           ##
##  You may obtain a copy of the License at:                                 ##
##                                                                           ##
##      http://www.apache.org/licenses/LICENSE-2.0                           ##
##                                                                           ##
##  Unless required by applicable law or agreed to in writing, software      ##
##  distributed under the License is distributed on an "AS-IS" BASIS,        ##
##  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. ##
##  See the License for the specific language governing permissions and      ##
##  limitations under the License.                                           ##
##                                                                           ##
## ------------------------------------------------------------------------- ##

FROM tauproject/core:shimmer

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

RUN mkdir /app
COPY docker/puppet-selftest/rcS /etc/default/rcS
COPY docker/puppet-selftest/inittab /etc/inittab
COPY scripts/docker/entrypoint /app/entrypoint
COPY scripts/docker/ready /app/ready
RUN chmod 755 /app/entrypoint /app/ready

COPY modules /usr/share/puppet/modules
COPY manifests /etc/puppet/manifests
COPY data /etc/puppet/data
COPY docker/puppet-selftest/selftest.yaml /etc/puppet/data/nodes/selftest.yaml
COPY docker/puppet-selftest/hiera.yaml /etc/puppet/hiera.yaml
CMD /bin/bash

ENTRYPOINT [ "/app/entrypoint" ]
