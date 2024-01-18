#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")/lib/modern.sh"

if ! command_exists scp; then
    die "command 'scp' required to load the install script onto the remote host"
fi

echo ${1:-WHAT}

remote_host="$1"
setup_script="newhost_setup.bash"

if ! [[ $remote_host == *:* ]]; then
    scp_remote_host="$remote_host:"
fi

run_or_die "script copy to remote host" scp $setup_script $scp_remote_host

run_or_die "script on remote host" ssh $remote_host "bash $setup_script"
