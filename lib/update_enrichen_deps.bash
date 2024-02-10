#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")/modern.sh"

safe_cd "$MODERN_SCRIPT_DIR"
run "downloading latest modern.sh" curl -O -L https://raw.githubusercontent.com/acook/modern.sh/main/modern.sh

