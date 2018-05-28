# @(#) $Tau: puppet/configure.ac $

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

AC_INIT([puppet],[shimmer])
AS_VAR_SET([ORG],[tauproject])
AC_SUBST([ORG])
AS_VAR_SET([RELEASE],[shimmer])
AC_SUBST([RELEASE])
AC_CONFIG_AUX_DIR([scripts])
AC_CONFIG_MACRO_DIR([m4])
AM_INIT_AUTOMAKE([foreign])
AM_MAINTAINER_MODE

AC_CHECK_PROG([DOCKER],[docker],[docker])
AM_CONDITIONAL([WITH_DOCKER],[test x"$DOCKER" != x""])

AS_VAR_SET([puppetdir],['${sysconfdir}/puppet']) AC_SUBST([puppetdir])
AS_VAR_SET([modulesdir],['${puppetdir}/modules']) AC_SUBST([modulesdir])
AS_VAR_SET([manifestsdir],['${puppetdir}/manifests']) AC_SUBST([manifestsdir])
AS_VAR_SET([hieradir],['${puppetdir}/data']) AC_SUBST([hieradir])

AC_DEFUN([EXPAND],[
save_$1=${$1}
$1=$(eval echo "${$1}")
$2
$1=${save_$1}
])

EXPAND([prefix],[
	test x"$prefix" = x"NONE" && prefix=$ac_default_prefix
	EXPAND([exec_prefix],[
		EXPAND([sysconfdir],[
			EXPAND([puppetdir],[
				AS_VAR_SET([PUPPETDIR],[${puppetdir}])
				EXPAND([modulesdir],[AS_VAR_SET([MODULESDIR],[${modulesdir}])])
				EXPAND([manifestsdir],[AS_VAR_SET([MANIFESTSDIR],[${manifestsdir}])])
				EXPAND([hieradir],[AS_VAR_SET([HIERADIR],[${hieradir}])])
			])
		])
	])
])
AC_SUBST([PUPPETDIR])
AC_SUBST([MODULESDIR])
AC_SUBST([MANIFESTSDIR])
AC_SUBST([HIERADIR])

AC_CONFIG_FILES([
Makefile
docker/Makefile
docker/puppet-selftest/Makefile
scripts/Makefile
scripts/ci/Makefile
scripts/docker/Makefile
tools/Makefile
hiera.yaml
])
	
AC_OUTPUT
