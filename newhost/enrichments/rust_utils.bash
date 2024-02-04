#!/usr/bin/env bash

#enrichment-name "rust_utils"
#enrichment-deps rust

# would be part of the base rust enrichment, except that it has a huge dependency list
run_or_die "install cargo information provider" cargo install cargo-info

# essentials
run_or_die "install text search"          cargo install ripgrep
run_or_die "install pager/highlighter"    cargo install bat
run_or_die "install rust repl"            cargo install irust cargo-show-asm cargo expand

# extras
run_or_die "install code counter"         cargo install tokei
run_or_die "install process lister"       cargo install procs
run_or_die "install TUI system dashboard" cargo install bottom
run_or_die "install Wikipedia TUI"        cargo install wiki-tui


# exa, mprocs, bacon, ncspot, porsmo, speedtest-rs
