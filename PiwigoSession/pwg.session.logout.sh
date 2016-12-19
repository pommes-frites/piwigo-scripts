#!/bin/bash

[[ $# < 2 ]] && {
    echo "ERROR $(date -Is) - Need more parameter. Call $0 <piwigoBaseUrl> <sessionCookiePath>"
    exit 1
}

basedir=$(dirname "$0")
url=$1
sessionCookiePath="$2"

wget --load-cookies "$sessionCookiePath" \
 --no-verbose \
 --output-document=/dev/null \
 "$url/ws.php?format=json&method=pwg.session.logout"

rm "$sessionCookiePath"
