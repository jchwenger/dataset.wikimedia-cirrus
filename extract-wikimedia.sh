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

echo ""
echo_underlined "extracting:"

for NAME in ${NAMES[@]}
do
  echo "$NAME"

  python wikiextractor/wikiextractor.py $NAME \
    --templates .templates-cache \
    --processes $(nproc) \
    --bytes "100M" \
    --quiet \
    --output $DUMP

  NEW_NAME="${DUMP}/$(basename ${NAME%-pages-articles-multistream.xml.bz2})"

  find "${NEW_NAME}"/*/* -exec \
    sed -i \
      -e 's/(\s*dernière mise à jour\s*)//g' \
      -e '/^ dernière mise à jour : $/d' \
      -e 's/​\+//g' \
      -e 's/[ \t]/ /g' \
      -e '/\S/,/^\s*$/!d' {} + # merge blank lines: https://stackoverflow.com/a/24374131

done

echo_sep
