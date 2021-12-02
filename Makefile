PKG := github.com/kernelai/version
BUILD_BIN_PATH := $(shell pwd)/bin

BUILD_FLAGS ?=
BUILD_CGO_ENABLED := 0
# BUILD_TAGS ?:


LDFLAGS += -X "$(PKG)/versioninfo.ReleaseVersion=$(shell git describe --tags --dirty --always)"
LDFLAGS += -X "$(PKG)/versioninfo.BuildTS=$(shell date -u '+%Y-%m-%d %I:%M:%S')"
LDFLAGS += -X "$(PKG)/versioninfo.GitHash=$(shell git rev-parse HEAD)"
LDFLAGS += -X "$(PKG)/versioninfo.GitBranch=$(shell git rev-parse --abbrev-ref HEAD)"

GOVER_MAJOR := $(shell go version | sed -E -e "s/.*go([0-9]+)[.]([0-9]+).*/\1/")
GOVER_MINOR := $(shell go version | sed -E -e "s/.*go([0-9]+)[.]([0-9]+).*/\2/")
GO111 := $(shell [ $(GOVER_MAJOR) -gt 1 ] || [ $(GOVER_MAJOR) -eq 1 ] && [ $(GOVER_MINOR) -ge 11 ]; echo $$?)
ifeq ($(GO111), 1)
  $(error "go below 1.11 does not support modules")
endif

build: export GO111MODULE=on
build: 
	CGO_ENABLED=$(BUILD_CGO_ENABLED) go build $(BUILD_FLAGS) -gcflags '$(GCFLAGS)' -ldflags '$(LDFLAGS)' -o $(BUILD_BIN_PATH)/version main.go