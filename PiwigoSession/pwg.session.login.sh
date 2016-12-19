#!/bin/bash

[[ $# < 4 ]] && {
    echo "ERROR $(date -Is) - Need more parameter. Call $0 <piwigoBaseUrl> <username> <password> <sessionCookiePath>"
    exit 1
}

basedir=$(dirname "$0")
baseUrl=$1
username=$2
password=$3
sessionCookiePath="$4"

wget --keep-session-cookies \
 --save-cookies "$sessionCookiePath" \
 --delete-after \
 --no-verbose \
 --post-data="method=pwg.session.login&username=$username&password=$password" \
 "$baseUrl/ws.php?format=json"
 