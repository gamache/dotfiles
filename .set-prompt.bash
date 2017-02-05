#!/bin/bash

function git_branch {
  local br=`git branch --no-color 2>/dev/null | grep '^\*' | sed 's/^\* //'`
  if [ "$br" ]; then
    echo "$br "
  else
    echo
  fi
}

function git_ref {
  local ref=`git log --pretty=format:'%h' -n 1 2>/dev/null`
  if [ "$ref" ]; then
    echo "$ref "
  else
    echo
  fi
}

function ruby_version {
  if [ -f Gemfile ]; then
    ruby -v | awk '{ print $1 " " $2 " " }'
  else
    echo
  fi
}

function node_version {
  if [ -f package.json ]; then
    echo node `node -v` ''
  else
    echo
  fi
}

function elixir_version {
  if [ -f mix.exs ]; then
    echo `elixir --version | grep 'Elixir ' | sed 's/Elixir/elixir/'` ''
  else
    echo
  fi
}

function set_prompt {
  local        BLUE="\[\033[0;34m\]"
  local  LIGHT_BLUE="\[\033[1;34m\]"
  local         RED="\[\033[0;31m\]"
  local   LIGHT_RED="\[\033[1;31m\]"
  local       GREEN="\[\033[0;32m\]"
  local LIGHT_GREEN="\[\033[1;32m\]"
  local       WHITE="\[\033[1;37m\]"
  local  LIGHT_GRAY="\[\033[0;37m\]"
  local       RESET="\[\033[0;0m\]"

  PS1="\n\u@\h:$LIGHT_RED\w$RESET $LIGHT_BLUE\$(git_branch)\$(git_ref)$LIGHT_GREEN\$(ruby_version)\$(node_version)\$(elixir_version)$RESET\n\$ "
  PS2='> '
  PS4='+ '
}

set_prompt

