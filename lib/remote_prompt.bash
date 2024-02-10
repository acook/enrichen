#!/usr/bin/env bash

_REMOTE_PROMPT_() {
  EXITSTATUS="$?"
  if [ "$EXITSTATUS" == "0" ]; then
    color=35
  else
    color=31
  fi
  PS0="\e[0G\e[0;35m$(printf '━%.0s' $(seq 1 $COLUMNS))\e[0m\e[1B\e[0G"
  PS1="\[\e[0;$color;1;7m\]\A➤\u@\H︙\[\e[0m\]"
  PS2="\[\e[0;35;1;7m\]︙\[\e[0m\]"
  export PS0
  export PS1
  export PS2
}

PROMPT_COMMAND="_REMOTE_PROMPT_"
