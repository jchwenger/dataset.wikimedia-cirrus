#!/bin/bash
# extracting wikimedia dumps using wikimedia extractor
# -----------------------------------------

source utils.sh

echo ""
echo "extracting cirrus dumps"

DUMP=cirrus
declare -a NAMES=$(ls -Sr $DUMP/*.gz) # starting from smallest

echo ""
echo_underlined "dumps:"
echo $NAMES | sed 's/ /\n/g'
echo ""

echo_underlined "extracting:"

for NAME in ${NAMES[@]}
do
  echo "$NAME"

  python wikiextractor/cirrusextractor.py -c $NAME

done

