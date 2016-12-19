#!/bin/bash

[[ $# < 1 ]] && {
    echo "ERROR $(date -Is) - Need more parameter. Call $0 <newFolderPath>"
    exit 1
}

basedir=$(dirname "$0")
newFolder="$1"

echo INFO $(date -Is) - rename files
"$basedir"/../PictureRenaming/renamePic2Date.sh "$newFolder"

echo INFO $(date -Is) - convert videos
"$basedir"/../VideoConvertion/convertVideos.sh "$newFolder"

echo INFO $(date -Is) - create video posters
"$basedir"/../PosterCreation/createPosters.sh "$newFolder"
