#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")/modern.sh"

remote_host="$1"
shift
enrichments="$@"
enrichments_dir="$MODERN_MAIN_DIR/../enrichments"
setup_script="newhost_setup.bash"

say "detected current directory as: '$(thisdir)'"
say "detected enrichment directory as: '$enrichments_dir'"

if [[ $remote_host == *:* ]]; then
  ssh_remote_arry=(${remote_host//:/ })
  ssh_remote_host="${ssh_remote_arry[0]}"
else
  ssh_remote_host="$remote_host"
fi

say "streaming commands to remote host..."

sshpipe_new "$ssh_remote_host"

# the sshpipe currently has no way to report that it is ready
# so we can wait to ensure the connection is complete
# otherwise the output of commands will be broken for some reason
sleep 2

stripscript >&13 < "$MODERN_MAIN_DIR/../lib/remote_prompt.bash"
sshpipe_rx "$ssh_remote_host"
stripscript >&13 < "$MODERN_SCRIPT_FULLPATH"
sshpipe_rx "$ssh_remote_host"
stripscript >&13 < "$enrichments_dir/$setup_script"
sshpipe_rx "$ssh_remote_host"
stripscript >&13 < "$enrichments_dir/$enrichments"
sshpipe_rx "$ssh_remote_host"

echo '> test.bash < /dev/stdin' >&13
echo 'echo -e "\e[31mITS ALIVE\e[0m"' >&13
echo -e '\004' >&13
echo 'bash test.bash' >&13

# wait to ensure all commands are complete before moving on
sleep 1
sshpipe_rx "$ssh_remote_host"
sshpipe_close "$ssh_remote_host"
