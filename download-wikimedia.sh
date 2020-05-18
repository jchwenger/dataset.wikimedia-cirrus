#!/bin/bash
# download all wiki dumps for a language
# -----------------------------------------

source utils.sh

if [ $# -lt 1 ]; then
  echo ""
  echo "please specify a language:"
  echo "./download.sh <lang>"
  exit 1
fi

echo ""
echo_underlined "downloading wikimedia dumps"

LANG=$1
DUMPS="wikimedia"

if [ ! -d $DUMPS ]; then
  echo "creating dir '$DUMPS'"
  mkdir $DUMPS
  echo ""
fi

BASE="https://dumps.wikimedia.org"

# latest date
# LATEST=$(
#   curl -s https://dumps.wikimedia.org/${LANG}wiki/ \
#     | grep -Po "\d{4,}" \
#     | uniq \
#     | sort \
#     | tail -1
# )
LATEST="latest"

echo "downloading into '$DUMPS' all '$LANG' dumps from:"
echo "$BASE"
echo_sep

# collect all the wiki names
declare -a NAMES=$(
  curl -s "https://dumps.wikimedia.org/backup-index.html" \
    | grep -oP "frwik\w+" \
    | uniq \
    | sort -r
)

echo_underlined "all the dumps"
echo $NAMES | sed 's/ /\n/g'
echo_sep

for NAME in ${NAMES[@]}
do
  echo ""
  echo_underlined "downloading '$NAME'"

  # xargs with printf: https://unix.stackexchange.com/a/365403
  DUMP_NAME=${NAME}-$LATEST-pages-articles-multistream.xml.bz2
  DUMP_URL=$BASE/${NAME}/$LATEST/$DUMP_NAME
  wget -c $DUMP_URL -P $DUMPS
  echo_sep

done
