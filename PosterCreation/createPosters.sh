#!/bin/bash

[[ $# < 1 ]] && {
    echo "ERROR $(date -Is) - Need more parameter. Call $0 <path>"
    exit 1
}

basedir=$(dirname "$0")
path="$1"

find "$path" -maxdepth 1 -iname *.mp4 -exec bash "$basedir"/createPoster.sh "{}" \;
