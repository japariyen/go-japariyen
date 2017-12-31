# This Makefile is meant to be used by people that do not usually work
# with Go source code. If you know what GOPATH is then you probably
# don't need to bother with make.

.PHONY: gjpy android ios gjpy-cross swarm evm all test clean
.PHONY: gjpy-linux gjpy-linux-386 gjpy-linux-amd64 gjpy-linux-mips64 gjpy-linux-mips64le
.PHONY: gjpy-linux-arm gjpy-linux-arm-5 gjpy-linux-arm-6 gjpy-linux-arm-7 gjpy-linux-arm64
.PHONY: gjpy-darwin gjpy-darwin-386 gjpy-darwin-amd64
.PHONY: gjpy-windows gjpy-windows-386 gjpy-windows-amd64

GOBIN = $(shell pwd)/build/bin
GO ?= latest

gjpy:
	build/env.sh go run build/ci.go install ./cmd/gjpy
	@echo "Done building."
	@echo "Run \"$(GOBIN)/gjpy\" to launch gjpy."

swarm:
	build/env.sh go run build/ci.go install ./cmd/swarm
	@echo "Done building."
	@echo "Run \"$(GOBIN)/swarm\" to launch swarm."

all:
	build/env.sh go run build/ci.go install

android:
	build/env.sh go run build/ci.go aar --local
	@echo "Done building."
	@echo "Import \"$(GOBIN)/gjpy.aar\" to use the library."

ios:
	build/env.sh go run build/ci.go xcode --local
	@echo "Done building."
	@echo "Import \"$(GOBIN)/Gjpy.framework\" to use the library."

test: all
	build/env.sh go run build/ci.go test

clean:
	rm -fr build/_workspace/pkg/ $(GOBIN)/*

# The devtools target installs tools required for 'go generate'.
# You need to put $GOBIN (or $GOPATH/bin) in your PATH to use 'go generate'.

devtools:
	env GOBIN= go get -u golang.org/x/tools/cmd/stringer
	env GOBIN= go get -u github.com/jteeuwen/go-bindata/go-bindata
	env GOBIN= go get -u github.com/fjl/gencodec
	env GOBIN= go install ./cmd/abigen

# Cross Compilation Targets (xgo)

gjpy-cross: gjpy-linux gjpy-darwin gjpy-windows gjpy-android gjpy-ios
	@echo "Full cross compilation done:"
	@ls -ld $(GOBIN)/gjpy-*

gjpy-linux: gjpy-linux-386 gjpy-linux-amd64 gjpy-linux-arm gjpy-linux-mips64 gjpy-linux-mips64le
	@echo "Linux cross compilation done:"
	@ls -ld $(GOBIN)/gjpy-linux-*

gjpy-linux-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/386 -v ./cmd/gjpy
	@echo "Linux 386 cross compilation done:"
	@ls -ld $(GOBIN)/gjpy-linux-* | grep 386

gjpy-linux-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/amd64 -v ./cmd/gjpy
	@echo "Linux amd64 cross compilation done:"
	@ls -ld $(GOBIN)/gjpy-linux-* | grep amd64

gjpy-linux-arm: gjpy-linux-arm-5 gjpy-linux-arm-6 gjpy-linux-arm-7 gjpy-linux-arm64
	@echo "Linux ARM cross compilation done:"
	@ls -ld $(GOBIN)/gjpy-linux-* | grep arm

gjpy-linux-arm-5:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-5 -v ./cmd/gjpy
	@echo "Linux ARMv5 cross compilation done:"
	@ls -ld $(GOBIN)/gjpy-linux-* | grep arm-5

gjpy-linux-arm-6:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-6 -v ./cmd/gjpy
	@echo "Linux ARMv6 cross compilation done:"
	@ls -ld $(GOBIN)/gjpy-linux-* | grep arm-6

gjpy-linux-arm-7:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-7 -v ./cmd/gjpy
	@echo "Linux ARMv7 cross compilation done:"
	@ls -ld $(GOBIN)/gjpy-linux-* | grep arm-7

gjpy-linux-arm64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm64 -v ./cmd/gjpy
	@echo "Linux ARM64 cross compilation done:"
	@ls -ld $(GOBIN)/gjpy-linux-* | grep arm64

gjpy-linux-mips:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips --ldflags '-extldflags "-static"' -v ./cmd/gjpy
	@echo "Linux MIPS cross compilation done:"
	@ls -ld $(GOBIN)/gjpy-linux-* | grep mips

gjpy-linux-mipsle:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mipsle --ldflags '-extldflags "-static"' -v ./cmd/gjpy
	@echo "Linux MIPSle cross compilation done:"
	@ls -ld $(GOBIN)/gjpy-linux-* | grep mipsle

gjpy-linux-mips64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips64 --ldflags '-extldflags "-static"' -v ./cmd/gjpy
	@echo "Linux MIPS64 cross compilation done:"
	@ls -ld $(GOBIN)/gjpy-linux-* | grep mips64

gjpy-linux-mips64le:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips64le --ldflags '-extldflags "-static"' -v ./cmd/gjpy
	@echo "Linux MIPS64le cross compilation done:"
	@ls -ld $(GOBIN)/gjpy-linux-* | grep mips64le

gjpy-darwin: gjpy-darwin-386 gjpy-darwin-amd64
	@echo "Darwin cross compilation done:"
	@ls -ld $(GOBIN)/gjpy-darwin-*

gjpy-darwin-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=darwin/386 -v ./cmd/gjpy
	@echo "Darwin 386 cross compilation done:"
	@ls -ld $(GOBIN)/gjpy-darwin-* | grep 386

gjpy-darwin-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=darwin/amd64 -v ./cmd/gjpy
	@echo "Darwin amd64 cross compilation done:"
	@ls -ld $(GOBIN)/gjpy-darwin-* | grep amd64

gjpy-windows: gjpy-windows-386 gjpy-windows-amd64
	@echo "Windows cross compilation done:"
	@ls -ld $(GOBIN)/gjpy-windows-*

gjpy-windows-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=windows/386 -v ./cmd/gjpy
	@echo "Windows 386 cross compilation done:"
	@ls -ld $(GOBIN)/gjpy-windows-* | grep 386

gjpy-windows-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=windows/amd64 -v ./cmd/gjpy
	@echo "Windows amd64 cross compilation done:"
	@ls -ld $(GOBIN)/gjpy-windows-* | grep amd64
