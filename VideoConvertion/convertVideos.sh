#!/bin/bash

[[ $# < 1 ]] && {
    echo "ERROR $(date -Is) - Need more parameter. Call $0 <path>"
    exit 1
}

basedir=$(dirname "$0")
path="$1"

find "$path" -maxdepth 1 \( -iname *.avi -o -iname *.mov -o -iname *.wmv -o -iname *.3gp \) -exec bash "$basedir"/convertVideo.sh "{}" \;