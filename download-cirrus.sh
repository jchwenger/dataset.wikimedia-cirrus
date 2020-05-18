#!/bin/bash
# download all wiki cirrus dumps for a language
# -----------------------------------------

source utils.sh

if [ $# -lt 1 ]; then
  echo ""
  echo "please specify a language:"
  echo "./download.sh <lang>"
  exit 1
fi

echo ""
echo_underlined "downloading cirrus dumps..."
echo "(with templates replacement already done)"

LANG=$1
DUMPS="cirrus"

if [ ! -d $DUMPS ]; then
  echo "creating dir '$DUMPS'"
  mkdir $DUMPS
fi

BASE="https://dumps.wikimedia.org/other/cirrussearch/current/"

echo "downloading into '$DUMPS' all '$LANG' dumps from:"
echo "$BASE"
echo_sep
echo ""

# xargs with printf: https://unix.stackexchange.com/a/365403
curl -s $BASE  \
  | grep -Po "frwik.*?content.*?gz" \
  | uniq \
  | sort -r \
  | xargs printf -- "$BASE%s\n" \
  | xargs wget -c -P $DUMPS

gunzip -k $DUMPS/*
