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
  echo "$NAME"

  NEW_NAME=$DUMP/$(basename ${NAME%.json.gz}.txt)
  python2 wikiextractor/cirrus-extract.py $NAME \
      -o - \
    | grep -v "^<doc id=" \
    | grep -v "</doc>\$" \
    > $NEW_NAME

done

