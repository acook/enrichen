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

say "streaming commands to remote host"

mkdir -v -p "$MODERN_MAIN_DIR/../tmp"
safe_cd "$MODERN_MAIN_DIR/../tmp"

sshpipe_new "$ssh_remote_host"

cat "$MODERN_MAIN_DIR/../lib/remote_prompt.bash" "$MODERN_SCRIPT_FULLPATH" "$enrichments_dir/$enrichments" "$enrichments_dir/$setup_script" >&13
sshpipe_rx "$ssh_remote_host"
sleep 5

echo '> test.bash < /dev/stdin' >&13
echo 'echo -e "\e[31mITS ALIVE\e[0m"' >&13
echo -e '\004' >&13
echo 'bash test.bash' >&13

sshpipe_rx "$ssh_remote_host"
sshpipe_close "$ssh_remote_host"
