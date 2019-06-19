artifact_name   := payments.web.ch.gov.uk

version         := unversioned

local           := ./local

smartpan_url    := http://darkpan.ch.gov.uk:7050

getpan_cpus     := 1
getpan_loglevel := INFO
getpan_cachedir := ./.gopancache
getpan_args     := -cpus $(getpan_cpus) -cachedir=$(getpan_cachedir) -smart $(smartpan_url) -loglevel=$(getpan_loglevel) -nodepdump -nocpan -nobackpan -metacpan

.PHONY: all
all: getpan

.PHONY: getpan
getpan:
	getpan $(getpan_args)

.PHONY: clean
clean:
	rm -rf $(local)
	rm -rf $(getpan_cachedir)

.PHONY: package
package:
ifndef version
	$(error No version given. Aborting)
endif
	$(eval tmpdir:=$(shell mktemp -d build-XXXXXXXXXX))
	cp -r $(local) $(tmpdir)
	cd $(tmpdir); zip -r ../$(artifact_name)-$(version).zip *
	rm -rf $(tmpdir)

