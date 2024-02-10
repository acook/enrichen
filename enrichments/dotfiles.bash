#!/usr/bin/env bash

#enrichment-name "dotfiles"
#enrichment-deps curl unzip

run_or_die "making source dir" mkdir -v -p "$HOME/Source/Mine"
safe_cd "$HOME/Source/Mine"
run_or_die "bootstrapping userspace configuration" curl -L -O https://github.com/acook/config/archive/refs/heads/main.zip
#run_or_die "decompressing configs" unzip -o -v main.zip
ls
#safe_cd configs
#run_or_die "invoking setup" ./install.bash
#safe_cd ~
