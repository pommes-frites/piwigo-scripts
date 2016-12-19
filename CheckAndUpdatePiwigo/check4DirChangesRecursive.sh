#!/bin/bash

[[ $# < 2 ]] && {
    echo "ERROR $(date -Is) - Need more parameter. Call $0 <listDirRoot> <checkDirRoot> [ <newFolderCommand> [ <changedFilesCommand> [ <changedSubFoldersCommand> [ <notPath> ]]]]"
    exit 1
}

basedir=$(dirname "$0")
listDirRoot="$1"
checkDirRoot="$2"
newFolderCommand="$3"
changedFilesCommand="$4"
changedSubfoldersCommand="$5"
notPath="$6"

[[ -f "$basedir"/.dirChanged ]] && rm "$basedir"/.dirChanged
find "$checkDirRoot" -type d -not -path "$notPath" -exec bash "$basedir"/check4DirChanges.sh "$listDirRoot" "$checkDirRoot" "{}" "$newFolderCommand" "$changedFilesCommand" "$changedSubfoldersCommand" \;
