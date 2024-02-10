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
    ssh_remote_path="${ssh_remote_arry[1]}"

    scp_remote_host="$remote_host"
else
    ssh_remote_host="$remote_host"
    ssh_remote_path=""

    # scp will happily do nothing at all if there is no colon with no error message
    scp_remote_host="$remote_host:"
fi

run_or_die "script copy to remote host" txcp "$ssh_remote_host" "$enrichments_dir/$setup_script" "$ssh_remote_path/$setup_script"

run_or_die "script on remote host" ssh "$ssh_remote_host" "bash $ssh_remote_path/$setup_script"

# usage: sshpipe_new <host>
# example: my_pipe="$(sshpipe_new my_host | tail -n 1)"
# create a named pipe to send bash commands to remote host
sshpipe_new() { # manage multiple file descriptors
  local fd
  local fdr
  local remote
  local in
  local out
  local pid
  fd=13
  fdr=14
  remote="$1"
  in="$remote.$fd.in"
  out="$remote.$fd.out"
  pid="$remote.$fd.pid"

  mkfifo "$in" "$out"
  ssh -tt "$remote" < "$in" > "$out" &
  echo "$!" > "$pid"
  eval "exec $fd>$in"
  eval "exec $fdr<$out"
  echo "$remote.$fd"
}

# usage: sshpipe_close <host>
# example: sshpipe_close my_host
# close a preexisting sshpipe
sshpipe_close() {
  local fd
  local fdr
  local remote
  local in
  local out
  local pid
  fd=13
  fdr=14
  remote="$1"
  in="$remote.$fd.in"
  out="$remote.$fd.out"
  pid="$remote.$fd.pid"

  eval "exec $fd>&-"
  eval "exec $fdr>&-"
  kill "$(< "$pid")"
  echo "$pid"
  rm -v "$in" "$out" "$pid"
}

# usage: sshpipe_tx <host> [content]
# example: sshpipe_tx my_host hostname
sshpipe_tx() { # TODO: make it read from stdin
  local fd
  fd=13

  echo "$@" >&"$fd"
}

# usage: sshpipe_rx <host>
# example: sshpipe_rx my_host | grep ' line ' | tee errors.txt
sshpipe_rx() {
  local fd
  local fdr
  local remote
  local out
  fd=13
  fdr=14
  remote="$1"
  out="$remote.$fd.out"

  EXITSTATUS=0
  while read -r -t 0.1 -u "$fdr" LINE; do
    echo "$LINE"
  done
}

#run_or_die "loading enrichments on remote host" txcp "$ssh_remote_host" "$enrichments_dir/$enrichments" "$ssh_remote_path/$setup_script"

say "streaming commands to remote host"

#cat "$MODERN_SCRIPT_FULLPATH" "$enrichments_dir/$enrichments" | ssh "$ssh_remote_host" "bash -s"

mkdir -v -p "$MODERN_MAIN_DIR/../tmp"
safe_cd "$MODERN_MAIN_DIR/../tmp"

sshpipe_new "$ssh_remote_host"

cat "$MODERN_MAIN_DIR/../lib/remote_prompt.bash" "$MODERN_SCRIPT_FULLPATH" "$enrichments_dir/$enrichments" >&13
sshpipe_rx "$ssh_remote_host"
sleep 5

echo '> test.bash < /dev/stdin' >&13
echo 'echo -e "\e[31mITS ALIVE\e[0m"' >&13
echo -e '\004' >&13
echo 'bash test.bash' >&13

sshpipe_rx "$ssh_remote_host"
sshpipe_close "$ssh_remote_host"
