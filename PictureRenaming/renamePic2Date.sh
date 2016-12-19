#!/bin/bash

[[ $# < 1 ]] && {
    echo "ERROR $(date -Is) - Need more parameter. Call $0 <path>"
    exit 1
}

path="$1"

[[ -f "$path"/.ignoreFilenames ]] && {
	echo ignore filenames
	exit 0
}

exiftoolFileArrays=()
for filepath in "$path"/*.* ; do
    filedir=$(dirname "$filepath")
    filename=$(basename "$filepath")
    basefilename="${filename%.*}"
    extension=${filename##*.}

    containsRegex="[0-9]{8}_[0-9]{6}"
    equalsRegex="^[0-9]{8}_[0-9]{6}$"

    if [[ "$basefilename" =~ $equalsRegex ]]; then
		echo "INFO $(date -Is) - $filename already correct"
	else
		if [[ "$basefilename" =~ $containsRegex ]]; then
			echo "INFO $(date -Is) - $filename contains date. Try to rename"
			match=${BASH_REMATCH[0]}
			target="$filedir/$match.${extension,,}"
			mv -n "$filepath" "$target"
		else
			echo "INFO $(date -Is) - $filename exiftool will be used to name file by its DateTimeOriginal, CreateDate or ModifyDate"
			exiftoolFileArrays+=("$filepath")
		fi
    fi
done

[[ ${#exiftoolFileArrays[@]} > 0 ]] && {
    echo "INFO $(date -Is) - exiftool -m -d %Y%m%d_%H%M%S%%-c.%%le \"-filename<ModifyDate\" \"-filename<CreateDate\" \"-filename<CreationDate\" \"-filename<DateTimeOriginal\" \"\${exiftoolFileArrays[@]}\""
    exiftool -m -d %Y%m%d_%H%M%S%%-c.%%le "-filename<ModifyDate" "-filename<CreateDate" "-filename<CreationDate" "-filename<DateTimeOriginal" "${exiftoolFileArrays[@]}"
}
