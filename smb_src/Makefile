# simple makefile wrapper to run waf
# -Wpoison-system-directories
PYTHON?=python
WAF_BINARY=$(PYTHON) ./buildtools/bin/waf
WAF=WAF_MAKE=1 $(WAF_BINARY)

#cross-compiler prefix, like arm-none-linux-gnueabi-
CROSS_COMPILE=

#path to cross ld,qemu search path is QEMU_PATH_ENV/lib/ld*.so
QEMU_PATH_ENV=

CROSS_EXECUTE=qemu-arm-static -L $(QEMU_PATH_ENV)

#embedded python root dir
python_ROOT_DIR_EMB=

#configure options for all builds
CONF_OPTIONS_COMMON=--prefix=/mnt/sda1/smb4 --without-ldap --without-ad-dc --without-ads --without-acl --disable-cups --without-gettext --without-winbind --disable-iprint --without-pam --without-pam_smbpass --without-quotas --without-utmp --disable-avahi --without-iconv --without-dnsupdate --without-syslog --with-aio-support --nopyc --nopyo

all:
	$(WAF) build

build:
	$(WAF) build
	
build_embedded:
	QEMU_PATH=$(QEMU_PATH_ENV)  $(WAF) build
	
install:
	$(WAF) install
	
install_embedded:
	QEMU_PATH=$(QEMU_PATH_ENV)  $(WAF) install
	
uninstall:
	$(WAF) uninstall

test:
	$(WAF) test $(TEST_OPTIONS)

help:
	@echo NOTE: to run extended waf options use $(WAF_BINARY) or modify your PATH
	$(WAF) --help

subunit-test:
	$(WAF) test --filtered-subunit $(TEST_OPTIONS)

testenv:
	$(WAF) test --testenv $(TEST_OPTIONS)

gdbtestenv:
	$(WAF) test --testenv --gdbtest $(TEST_OPTIONS)

quicktest:
	$(WAF) test --quick $(TEST_OPTIONS)

dist:
	touch .tmplock
	WAFLOCK=.tmplock $(WAF) dist

distcheck:
	touch .tmplock
	WAFLOCK=.tmplock $(WAF) distcheck

clean:
	$(WAF) clean

distclean:
	$(WAF) distclean

show_waf_options:
	$(WAF) --help

configure_help:
	$(WAF) configure --help
	
configure_local:
	$(WAF) configure  $(CONF_OPTIONS_COMMON)
	
configure_embedded:
	LDFLAGS=-I$(python_ROOT_DIR_EMB)include/python2.7 python_INCLUDEPY=$(python_ROOT_DIR_EMB)include/python2.7 python_LIBDIR=$(python_ROOT_DIR_EMB)lib CC=$(CROSS_COMPILE)gcc CPP=$(CROSS_COMPILE)cpp AR=$(CROSS_COMPILE)ar RANLIB=$(CROSS_COMPILE)ranlib $(WAF) configure  --cross-compile --cross-execute='$(CROSS_EXECUTE)' $(CONF_OPTIONS_COMMON)

#cross-answers example, using instead qemu cross-execute
#configure_with_cross_answers:
#	LDFLAGS=-I$(python_ROOT_DIR_EMB)include/python2.7 python_INCLUDEPY=$(python_ROOT_DIR_EMB)include/python2.7 python_LIBDIR=$(python_ROOT_DIR_EMB)lib CC=$(CROSS_COMPILE)gcc CPP=$(CROSS_COMPILE)cpp AR=$(CROSS_COMPILE)ar RANLIB=$(CROSS_COMPILE)ranlib $(WAF) configure --cross-compile --cross-answers=ntgr7500.txt $(CONF_OPTIONS_COMMON)

# some compatibility make targets
everything: all

testsuite: all

check: test

torture: all

# this should do an install as well, once install is finished
installcheck: test

etags:
	$(WAF) etags

ctags:
	$(WAF) ctags

pydoctor:
	$(WAF) pydoctor

pep8:
	$(WAF) pep8

# Adding force on the depencies will force the target to be always rebuild form the Make
# point of view forcing make to invoke waf

bin/smbd: FORCE
	$(WAF) --targets=smbd/smbd

bin/winbindd: FORCE
	$(WAF) --targets=winbindd/winbindd

bin/nmbd: FORCE
	$(WAF) --targets=nmbd/nmbd

bin/smbclient: FORCE
	$(WAF) --targets=client/smbclient

# this allows for things like "make bin/smbtorture"
# mainly for the binary that don't have a broken mode like smbd that must
# be build with smbd/smbd
bin/%: FORCE
	$(WAF) --targets=$(subst bin/,,$@)

# Catch all rule to be able to call make service_repl in order to find the name
# of the submodule you want to build, look at the wscript
%:
	$(WAF) --targets=$@

# This rule has to be the last one
FORCE:
# Having .NOTPARALLEL will force make to do target once at a time but still -j
# will be present in the MAKEFLAGS that are in turn interpreted by WAF
# so only 1 waf at a time will be called but it will still be able to do parralel builds if
# instructed to do so
.NOTPARALLEL: %
.PHONY: FORCE everything testsuite check torture
