export SHELL=/bin/bash
export TAG?=$(shell git log -1 --format=%H)

bench: *.go go.* cmd/bench/*.go
	GOOS=linux GOARCH=amd64 go build -o bench cmd/bench/main.go

.PHONY: clean
clean:
	rm -f bench benchmarker*.json ../initial_data.tar.gz

../initial_data.tar.gz:
	gh release list --repo isucon/isucon12-qualify | awk '/Latest/{print $$3}' | xargs gh release download --repo isucon/isucon12-qualify --dir ..

benchmarker.json: ../initial_data.tar.gz
	tar xzf ../initial_data.tar.gz -C ..

benchmarker_tenant.json: benchmarker.json
