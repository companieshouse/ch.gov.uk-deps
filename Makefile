LOCAL           ?= ./local

SMARTPAN_URL    ?= http://darkpan.ch.gov.uk:7050

GETPAN_CPUS     ?= -cpus 1 # Setting to null enables getpan to use all cores
GETPAN_LOGLEVEL ?= INFO
GETPAN_CACHEDIR ?= ./.gopancache
GETPAN_ARGS     ?= $(GETPAN_CPUS) -cachedir=$(GETPAN_CACHEDIR) -smart $(SMARTPAN_URL) -loglevel=$(GETPAN_LOGLEVEL) -nodepdump -nocpan -nobackpan -metacpan

.PHONY: all
all: getpan

.PHONY: getpan
getpan:
	getpan $(GETPAN_ARGS)

.PHONY: clean
clean:
	rm -rf $(LOCAL)
	rm -rf $(GETPAN_CACHEDIR)

.PHONY: package
package:
ifndef version
	$(error No version given. Aborting)
endif
	$(eval tmpdir:=$(shell mktemp -d build-XXXXXXXXXX))
	cp $(LOCAL) $(tmpdir)
	cd $(tmpdir); zip -r ../$(artifact_name)-$(version).zip *
	rm -rf $(tmpdir)

