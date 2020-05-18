#!/bin/bash
# extracting wikimedia dumps using wikimedia extractor
# -----------------------------------------

source utils.sh

echo ""
echo "extracting wikimedia dumps"

DUMP=wikimedia
declare -a NAMES=$(ls $DUMP/*.bz2)

echo ""
echo_underlined "dumps:"
echo $NAMES | sed 's/ /\n/g'

for NAME in ${NAMES[@]}
do
  echo ""
  echo_underlined "extracting: $NAME"
  echo ""

  NEW_NAME=$DUMP/$(basename ${NAME%.bz2}.txt)
  python wikiextractor/WikiExtractor.py $NAME --templates .templates-cache \
    --processes 8 -q -o - \
    | grep -v "^<doc id=" \
    | grep -v "</doc>\$" \
    > $NEW_NAME

  echo_sep
done
