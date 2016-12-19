#!/bin/bash

[[ $# < 1 ]] && {
    echo "ERROR $(date -Is) - Need more parameter. Call $0 <changedFolderPath>"
    exit 1
}

basedir=$(dirname "$0")
changedFolder=$1

echo INFO $(date -Is) - rename files
"$basedir"/../PictureRenaming/renamePic2Date.sh "$changedFolder"

echo INFO $(date -Is) - convert videos
"$basedir"/../VideoConvertion/convertVideos.sh "$changedFolder"

echo INFO $(date -Is) - create video posters
"$basedir"/../PosterCreation/createPosters.sh "$changedFolder"
