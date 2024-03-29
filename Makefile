Version := $(shell git describe --tags --dirty)
# Version := "dev"
GitCommit := $(shell git rev-parse HEAD)
LDFLAGS := "-s -w -X main.Version=$(Version) -X main.GitCommit=$(GitCommit)"

.PHONY: all
all: gofmt dist

# .PHONY: test
# test: 
# 	go test -v ./...

.PHONY: gofmt
gofmt: 
	@test -z $(shell gofmt -l ./ | tee /dev/stderr) || (echo "[WARN] Fix formatting issues with 'make fmt'" && exit 1)

.PHONY: dist
dist:
	mkdir -p bin/
	CGO_ENABLED=0 GOOS=linux go build -mod=vendor -ldflags $(LDFLAGS)  -o bin/release-it-amd64
	CGO_ENABLED=0 GOOS=darwin go build -mod=vendor -ldflags $(LDFLAGS)  -o bin/release-it-darwin
	GOARM=7 GOARCH=arm CGO_ENABLED=0 GOOS=linux go build -mod=vendor -ldflags $(LDFLAGS)  -o bin/release-it-arm
	GOARCH=arm64 CGO_ENABLED=0 GOOS=linux go build -mod=vendor -ldflags $(LDFLAGS)  -o bin/release-it-arm64
	GOOS=windows CGO_ENABLED=0 go build -mod=vendor -ldflags $(LDFLAGS)  -o bin/release-it.exe
