LOCAL           ?= ./local

SMARTPAN_URL    ?= http://darkpan.ch.gov.uk:7050

GETPAN_CPUS     ?= -cpus 1 # Setting to null enables getpan to use all cores
GETPAN_LOGLEVEL ?= INFO
GETPAN_CACHEDIR ?= ./.gopancache
GETPAN_ARGS     ?= $(GETPAN_CPUS) -cachedir=$(GETPAN_CACHEDIR) -smart $(SMARTPAN_URL) -loglevel=$(GETPAN_LOGLEVEL) -nodepdump -nocpan -nobackpan -metacpan

all: getpan

getpan:
	getpan $(GETPAN_ARGS)

clean:
	rm -rf $(LOCAL)
	rm -rf $(GETPAN_CACHEDIR)

.PHONY: all getpan clean
