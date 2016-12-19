#!/bin/bash

[[ $# < 2 ]] && {
    echo "ERROR $(date -Is) - Need more parameter. Call $0 <piwigoBaseUrl> <sessionCookiePath>"
    exit 1
}

basedir=$(dirname "$0")
baseUrl=$1
sessionCookiePath="$2"

#wsMethod="pwg.getMissingDerivatives"
wsMethod="custom_missing_derivatives.getMissingDerivativesCustom&customTypes[]=260x180_1_260x180&customTypes[]=520x360_1_520x360"

wget --load-cookies "$sessionCookiePath" \
 --no-verbose \
 --output-document="$basedir/missing.json" \
 "$baseUrl/ws.php?format=json&method=$wsMethod"
 
while [ `wc -c "$basedir/missing.json" | cut -f 1 -d ' '` -gt 50 ]
do
  sed -e 's/[\\\"]//g' \
  -e 's/{stat:ok,result:{next_page:[0-9]*,urls:\[//' \
  -e 's/{stat:ok,result:{urls:\[//' \
  -e 's/\]}}/\n/' \
  -e 's/,/\n/g' \
  -e 's/\&b=[0-9]*//g' "$basedir/missing.json" | \
  while read line ; do
    wget --no-verbose \
	 --output-document=/dev/null \
	 $line
  done
  wget --load-cookies "$sessionCookiePath" \
   --no-verbose \
   --output-document="$basedir/missing.json" \
   "$baseUrl/ws.php?format=json&method=$wsMethod"
done

