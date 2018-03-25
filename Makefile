# $Tau: puppet/Makefile $

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

ORG = tauproject
PACKAGE = puppet
RELEASE = shimmer
DOCKERIMAGENAME = $(ORG)/$(PACKAGE)
DOCKERRUNFLAGS = -i -t -e TERM='$(TERM)'

DOCKER = docker

all: container

container:
	$(DOCKER) build -t $(DOCKERIMAGENAME):$(RELEASE) .
	$(DOCKER) tag $(DOCKERIMAGENAME):$(RELEASE) $(DOCKERIMAGENAME):latest

clean:

check: container
	$(DOCKER) run $(DOCKERRUNFLAGS) $(DOCKERIMAGENAME) puppet apply /etc/puppet/manifests/site.pp

diagnose: container
	$(DOCKER) run $(DOCKERRUNFLAGS) $(DOCKERIMAGENAME) sh -c "puppet apply --verbose /etc/puppet/manifests/site.pp ; bash"

shell: container
	$(DOCKER) run $(DOCKERRUNFLAGS) $(DOCKERIMAGENAME)
