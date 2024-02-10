#!/usr/bin/env bash

#enrichment-name "my_scripts"
#enrichment-deps curl

run_or_die "making source dir" mkdir -v -p "$HOME/Source"
safe_cd "$HOME/Source"
run_or_die "bootstrapping utility scripts" curl -L -O https://github.com/acook/my-scripts/archive/refs/heads/main.zip
run_or_die "decompressing utility scripts" unzip -o -v main.zip
ls
safe_cd my-scripts
run_or_die "invoking setup" ./install
safe_cd ..
