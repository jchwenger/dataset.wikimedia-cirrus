#!/bin/bash
# download all wiki cirrus dumps for a language
# -----------------------------------------

source utils.sh

if [ $# -lt 1 ]; then
  echo ""
  echo "please specify a source file with link (line separated):"
  echo "use ./get-links.sh to fetch the links"
  echo "./download.sh <file>"
  exit 1
fi

echo ""
echo_underlined "downloading cirrus dumps..."
echo "(with templates replacement already done)"

source_file=$1
DUMPS="cirrus"

if [ ! -d $DUMPS ]; then
  echo "creating dir '$DUMPS'"
  mkdir $DUMPS
fi

BASE="https://dumps.wikimedia.org/other/cirrussearch/current/"
LINKS_FILE="cirrus-links.txt"

echo "downloading into '$DUMPS' for all links from '$source_file':"
cat "$source_file"
echo_sep
echo ""

cat $LINKS_FILE \
  | xargs wget -c -P $DUMPS

