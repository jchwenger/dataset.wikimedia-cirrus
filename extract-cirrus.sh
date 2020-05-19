#!/bin/bash
# extracting wikimedia dumps using wikimedia extractor
# -----------------------------------------

source utils.sh

echo ""
echo "extracting cirrus dumps"

DUMP=cirrus
declare -a NAMES=$(ls $DUMP/*.gz)

echo ""
echo_underlined "dumps:"
echo $NAMES | sed 's/ /\n/g'

echo_underlined "extracting:"

for NAME in ${NAMES[@]}
do
  echo_underlined "$NAME"
  echo_sep

  python wikiextractor/cirrusextractor.py $NAME

done

