#!/bin/bash
# get all links for wiki cirrus dumps for a language
# -----------------------------------------

source utils.sh

if [ $# -lt 1 ]; then
  echo ""
  echo "please specify a language:"
  echo "./get-links.sh <lang>"
  echo "(then use ./download.sh <file>)"
  exit 1
fi

LANG=$1

BASE="https://dumps.wikimedia.org/other/cirrussearch/current/"
LINKS_FILE="$LANG".cirrus-links.txt

echo "downloading all links for '$LANG' dumps available on:"
echo "$BASE"
echo "into $LINKS_FILE:"

# xargs with printf: https://unix.stackexchange.com/a/365403
grep_search="$LANG"wik.*?content.*?gz
curl -s $BASE  \
  | grep -Po "$grep_search" \
  | sort -r \
  | uniq \
  | xargs -I '{}' echo "$BASE"'{}' \
  > $LINKS_FILE

cat $LINKS_FILE
echo_sep

