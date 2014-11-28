default: test-racket build

output-dirs:
	mkdir -p build/bin

build: output-dirs
	raco exe -o build/bin/marco cmd/marco.rkt

test: test-racket

test-racket:
	raco test test

clean:
	rm -rf build
	find . | grep compiled | xargs rm -rf

.PHONY: build test test-racket clean output-dirs
