#!/usr/bin/env bash

#enrichment-name "rust"
#enrichment-deps curl

rust_temp_dir=$(mktemp -d "$O.XXXXXXXX")

say "using temp folder '$rust_temp_dir'"
safe_cd "$rust_temp_dir"

# install rust
run_or_die "download rustup" curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o rustup.sh
run_or_die "rustup" sh rustup.sh

# for updating all apps installed via cargo at once
run_or_die "cargo updater install" cargo install cargo-update

run "removing temp dir" rm -r -v "$rust_temp_dir"