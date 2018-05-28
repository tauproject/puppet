# @(#) $Tau: puppet/docker/puppet-selftest/Makefile.am $

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

EXTRA_DIST = hiera.yaml selftest.yaml inittab rcS

IMAGE = puppet-selftest
IMAGENAME = $(ORG)/$(PACKAGE)
DOCKERRUNFLAGS = -i -t -e TERM='$(TERM)'

if WITH_DOCKER

all-local: container

container:
	$(DOCKER) build -t $(IMAGENAME) -f Dockerfile $(top_srcdir)
	$(DOCKER) tag $(IMAGENAME) $(IMAGENAME):$(RELEASE)

check: container
	$(DOCKER) run $(DOCKERRUNFLAGS) $(IMAGENAME) puppet apply /etc/puppet/manifests/site.pp

diagnose: container
	$(DOCKER) run $(DOCKERRUNFLAGS) $(IMAGENAME) sh -c "puppet apply --verbose /etc/puppet/manifests/site.pp ; bash"

shell: container
	$(DOCKER) run $(DOCKERRUNFLAGS) $(IMAGENAME)

else

container run shell:
	@printf "Warning: Docker is not available for this build; skipping\n" >&2

endif
