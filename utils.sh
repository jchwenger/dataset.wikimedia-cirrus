#!/bin/bash
# utils
#------

echo_sep() {
  echo "-------------------------------------------------"
}

get_length() {
  local l=$(expr length "$*")
  echo $l
}

underline() {
  local i=0
  local s=""
  while [ $i -lt $1 ]
  do
    s="${s}-"
    i=$(($i+1))
  done
  echo $s
}

echo_underlined() {
  local msg=$1
  echo $1
  underline $(get_length $msg)
}
