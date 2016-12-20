#!/bin/bash

[[ $# < 1 ]] && {
    echo "ERROR $(date -Is) - Need more parameter. Call $0 <filePath> [overwrite]"
    exit 1
}

filePath="$1"
mode=$2
fileDir=$(dirname "$filePath")
fileName=$(basename "$filePath")
fileBaseName="${fileName%.*}"
outFilePath="$fileDir/pwg_representative/$fileBaseName.jpg"

[[ -d "$fileDir"/pwg_representative ]] || mkdir "$fileDir"/pwg_representative

[[ -f "$outFilePath" && mode != "overwrite" ]] && {
	echo INFO $(date -Is) - poster "$outFilePath" already exists
} || {
	ffmpeg -itsoffset -4 -i "$filePath" -vcodec mjpeg -vframes 1 -an -f rawvideo -n "$outFilePath"
}
