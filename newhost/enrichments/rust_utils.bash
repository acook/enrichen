#!/usr/bin/env bash

#enrichment-name "rust_utils"
#enrichment-deps rust

run_or_die "installing pager/highlighter" cargo install bat
run_or_die "installing code counter" cargo install tokei
run_or_die "installing TUI system dashboard" cargo install bottom

