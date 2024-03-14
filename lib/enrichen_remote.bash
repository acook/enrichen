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

if INFO="$(sshpipe_status "$ssh_remote_host" -p)"; then
  echo -e "\e[31m"
  echo -n "SHELL: "
  echo "$INFO" | cut -s -d '|' -f 1
  echo -n "USER:  "
  echo "$INFO" | cut -s -d '|' -f 2
  echo -n "PWD:   "
  echo "$INFO" | cut -s -d '|' -f 3
  echo -e "\e[0m"
fi

say "loading remote prompt onto remote"
stripscript >&13 < "$MODERN_MAIN_DIR/../lib/remote_prompt.bash"
sshpipe_rx "$ssh_remote_host"
say "loading modern.sh onto remote"
stripscript >&13 < "$MODERN_SCRIPT_FULLPATH"
sshpipe_rx "$ssh_remote_host"
say "loading basic remote setup script onto remote"
stripscript >&13 < "$enrichments_dir/$setup_script"
sshpipe_rx "$ssh_remote_host"
say "applying enrichments to remote"
stripscript >&13 < "$enrichments_dir/$enrichments"
sshpipe_rx "$ssh_remote_host"

sleep 1

say "testing remote file creation"
#echo '> test.bash < /dev/stdin' >&13
echo 'cat /dev/stdin > test.bash' >&13
echo 'echo -e "\e[31mITS ALIVE\e[0m"' >&13
echo -e '\004' >&13
echo 'bash test.bash' >&13
sshpipe_tx kigal cat test.bash

say "getting latest output"
# wait to ensure all commands are complete before moving on
sleep 1
sshpipe_rx "$ssh_remote_host"

if INFO="$(sshpipe_status "$ssh_remote_host" -p)"; then
  echo -e "\e[31m"
  echo -n "SHELL: "
  echo "$INFO" | cut -s -d '|' -f 1
  echo -n "USER:  "
  echo "$INFO" | cut -s -d '|' -f 2
  echo -n "PWD:   "
  echo "$INFO" | cut -s -d '|' -f 3
  echo -e "\e[0m"
fi

sshpipe_close "$ssh_remote_host"
