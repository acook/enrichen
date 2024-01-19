#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")/lib/modern.sh"

if ! command_exists scp; then
    die "command 'scp' required to load the install script onto the remote host"
fi

echo ${1:-WHAT}

remote_host="$1"
setup_script="newhost_setup.bash"

if [[ $remote_host == *:* ]]; then
    ssh_remote_arry=(${remote_host//:/ })
    ssh_remote_host="${ssh_remote_arry[0]}"
    ssh_remote_path="${ssh_remote_arry[1]}"

    scp_remote_host="$remote_host"
else
    ssh_remote_host="$remote_host"
    ssh_remote_path=""

    # scp will happily do nothing at all if there is no colon with no error message
    scp_remote_host="$remote_host:"
fi

run_or_die "script copy to remote host" scp $setup_script $scp_remote_host

run_or_die "script on remote host" ssh "$ssh_remote_host" "bash $ssh_remote_path/$setup_script"

