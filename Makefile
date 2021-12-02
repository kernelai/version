BUILD_BIN_PATH := $(shell pwd)/bin

build: 
	go build -o $(BUILD_BIN_PATH)/version main.go