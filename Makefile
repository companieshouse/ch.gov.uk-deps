artifact_name   := ch.gov.uk-deps

local           := ./local

smartpan_url    := https://smartpan.ci.platform.aws.chdev.org

getpan_cpus     := 1
getpan_loglevel := INFO
getpan_cachedir := ./.gopancache
getpan_args     := -cpus $(getpan_cpus) -cachedir=$(getpan_cachedir) -smart $(smartpan_url) -loglevel=$(getpan_loglevel) -nodepdump -nocpan -nobackpan -metacpan

.PHONY: all
all: getpan package

.PHONY: getpan
getpan:
	getpan $(getpan_args)

.PHONY: clean
clean:
	rm -rf build-*
	rm -rf $(local)
	rm -rf $(getpan_cachedir)

.PHONY: package
package:
ifndef version
	$(error No version given. Aborting)
endif
	$(eval tmpdir:=$(shell mktemp -d build-XXXXXXXXXX))
	cp -r $(local)/* $(tmpdir)
	cd $(tmpdir); zip -r ../$(artifact_name)-$(version).zip *
	rm -rf $(tmpdir)

.PHONY: package-ecs
package-ecs:
ifndef version
	$(error No version given. Aborting)
endif
	$(eval tmpdir:=$(shell mktemp -d build-XXXXXXXXXX))
	cp -r $(local)/* $(tmpdir)
	cd $(tmpdir); zip -r ../$(artifact_name)-ecs-$(version).zip *
	rm -rf $(tmpdir)
