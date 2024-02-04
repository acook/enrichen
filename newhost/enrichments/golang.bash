#!/usr/bin/env bash

#enrichment-name "go"
#enrichment-deps inin

run_or_die "install golang" inin in golang
run_or_die "install golang tool updater" go install github.com/Gelio/go-global-update@latest
