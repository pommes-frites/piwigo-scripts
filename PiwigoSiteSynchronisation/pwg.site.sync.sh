#!/bin/bash

[[ $# < 3 ]] && {
    echo "ERROR $(date -Is) - Need more parameter. Call $0 <piwigoBaseUrl> <sessionCookiePath> <piwigoSiteId>"
    exit 1
}

basedir=$(dirname "$0")
baseUrl=$1
sessionCookiePath="$2"
siteId=$3

wget --load-cookies "$sessionCookiePath" \
 --no-verbose \
 --output-document=/dev/null \
 --post-data="sync=files&display_info=1&add_to_caddie=1&privacy_level=0&sync_meta=1&simulate=0&subcats-included=1&submit=1" \
 "$baseUrl/admin.php?page=site_update&site=$siteId"
