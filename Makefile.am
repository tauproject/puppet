# @(#) $Tau: puppet/Makefile.am $

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

ACLOCAL_AMFLAGS = -I m4

SUBDIRS = scripts docker tools

EXTRA_DIST = README.md LICENSE-2.0 hiera.yaml.in
EXTRA_DIST_SUBDIRS = data manifests modules

PUPPETCONF = hiera.yaml

install-data-hook:
	@$(mkinstalldirs) $(DESTDIR)$(puppetdir)
	@for file in $(PUPPETCONF) ; do \
		if test -e $(DESTDIR)$(puppetdir)/$$file ; then \
			printf "Warning: Refusing to overwrite existing %s\n" "$(DESTDIR)$(puppetdir)/$$file" >&2 ; \
		else \
			printf "Installing %s\n" "$(DESTDIR)$(puppetdir)/$$file" >&2 ; \
			$(INSTALL) $(srcdir)/$$file $(DESTDIR)$(puppetdir)/$$file || exit ; \
		fi ; \
	done
	@if test -e $(DESTDIR)$(modulesdir) ; then \
		printf "Warning: Refusing to overwrite existing modules at %s\n" "$(DESTDIR)$(modulesdir)" >&2 ; \
	else \
		printf "Installing modules to %s\n" '$(DESTDIR)$(modulesdir)' >&2 ; \
		$(mkinstalldirs) $(DESTDIR)$(modulesdir) || exit ; \
		tar cf - $(srcdir)/modules | ( cd $(DESTDIR)$(modulesdir)/.. && tar xf - ) || exit ; \
	fi
	@if test -e $(DESTDIR)$(manifestsdir) ; then \
		printf "Warning: Refusing to overwrite existing manifests at %s\n" "$(DESTDIR)$(manifestsdir)" >&2 ; \
	else \
		printf "Installing manifests to %s\n" '$(DESTDIR)$(manifestsdir)' >&2 ; \
		$(mkinstalldirs) $(DESTDIR)$(manifestsdir) || exit ; \
		tar cf - $(srcdir)/manifests | ( cd $(DESTDIR)$(manifestsdir)/.. && tar xf - ) || exit ; \
	fi
	@if test -e $(DESTDIR)$(hieradir) ; then \
		printf "Warning: Refusing to overwrite existing Hiera data at %s\n" "$(DESTDIR)$(hieradir)" >&2 ; \
	else \
		printf "Installing Hiera data to %s\n" '$(DESTDIR)$(hieradir)' >&2 ; \
		$(mkinstalldirs) $(DESTDIR)$(hieradir) || exit ; \
		tar cf - $(srcdir)/data | ( cd $(DESTDIR)$(hieradir)/.. && tar xf - ) || exit ; \
	fi

dist-hook:
	@for dir in $(EXTRA_DIST_SUBDIRS) ; do \
		tar cf - $(srcdir)/$$dir | ( cd $(top_distdir) && tar xf - ) ; \
	done
