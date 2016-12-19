#!/bin/bash

[[ $# < 1 ]] && {
    echo "ERROR $(date -Is) - Need more parameter. Call $0 <filePath> [ overwrite ]"
    exit 1
}

filePath="$1"
mode=$2
filePathBaseName="${filePath%.*}"
outFilePath="$filePathBaseName.mp4"

[[ -f "$outFilePath" && mode != "overwrite" ]] && {
	echo INFO $(date -Is) - video "$outFilePath" already exists
} || {
	ffmpeg -n -i "$filePath" -map_metadata 0:g -c:v libx264 -pix_fmt yuv420p "$outFilePath"
}
