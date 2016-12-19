#!/bin/bash

[[ $# < 3 ]] && {
    echo "ERROR $(date -Is) - Need more parameter. Call $0 <listDirRoot> <checkDirRoot> <checkDir> [ <newFolderCommand> [ <changedFilesCommand> [ <changedSubFoldersCommand> ]]]"
    exit 1
}

basedir=$(dirname "$0")
listDirRoot="$1"
checkDirRoot="$2"
checkDir="$3"
newFolderCommand="$4"
changedFilesCommand="$5"
changedSubfoldersCommand="$6"

listDir=${checkDir/$checkDirRoot/$listDirRoot}
fileList="$listDir/.files"
folderList="$listDir/.folders"

[[ -d "$listDirRoot" ]] || mkdir "$listDirRoot"
[[ -d "$listDir" ]] || mkdir "$listDir"

currentFileList=$(ls -al "${checkDir}" | grep '^-')
currentFolderList=$(ls -dw 1 "$checkDir"/*/ 2>/dev/null)
[[ -f "$fileList" && -f "$folderList" ]] && {
  diff -q <(cat "${fileList}") <(echo $currentFileList) >/dev/null || {
    echo INFO $(date -Is) - changed files $checkDir
	touch "$basedir"/.dirChanged
	${changedFilesCommand/<folder>/$checkDir}
    # Overwrite file list with the new one.
    echo $currentFileList > "${fileList}"
  }
  diff -q <(cat "${folderList}") <(echo $currentFolderList) >/dev/null || {
    echo INFO $(date -Is) - changed subfolders $checkDir
	touch "$basedir"/.dirChanged
	${changedSubfoldersCommand/<folder>/$checkDir}
	
	# update list folders 
	for listSubFolder in "$listDir"/*/; do 
		[[ "$currentFolderList" =~ "${listSubFolder:${#listDirRoot}}" ]] || rm -R "$listSubFolder" 2>/dev/null
	done
	
    # Overwrite folder list with the new one.
    echo $currentFolderList > "${folderList}"
  }

} || {
  echo INFO $(date -Is) - new folder $checkDir
  touch "$basedir"/.dirChanged
  ${newFolderCommand/<folder>/$checkDir}
  # Overwrite file list with the new one.
  echo $currentFileList > "${fileList}"
  echo $currentFolderList > "${folderList}"
}

