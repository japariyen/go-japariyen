.PHONY: build cluster test

default: build

build:
	go build -o bin/swarm    github.com/japariyen/go-japariyen/cmd/swarm
	go build -o bin/gjpy     github.com/japariyen/go-japariyen/cmd/gjpy
	go build -o bin/bootnode github.com/japariyen/go-japariyen/cmd/bootnode

cluster: build
	scripts/boot-cluster.sh

test:
	go test -v github.com/japariyen/go-japariyen/swarm/...
