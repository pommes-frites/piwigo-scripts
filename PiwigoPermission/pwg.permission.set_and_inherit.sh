#!/bin/bash

[[ $# < 2 ]] && {
    echo "ERROR $(date -Is) - Need more parameter. Call $0 <piwigoBaseUrl> <sessionCookiePath>"
    exit 1
}

basedir=$(dirname "$0")
baseUrl=$1
sessionCookiePath="$2"

read_dom () {
    local IFS=\>
    read -d \< ENTITY CONTENT
    local ret=$?
    TAG_NAME=${ENTITY%% *}
    ATTRIBUTES=${ENTITY#* }
    return $ret
}

# get piwigo token
restSessionStatus=$(wget --load-cookies "$sessionCookiePath" \
 --output-document=- \
 --no-verbose \
 --post-data="method=pwg.session.getStatus" \
 "$baseUrl/ws.php?format=rest")
token=""
while read_dom; do
    [[ "$TAG_NAME" = "pwg_token" ]] && {
		token="$CONTENT"
		break
	}
done <<< "$restSessionStatus"

# get piwigo main categories
restCategoryList=$(wget --load-cookies "$sessionCookiePath" \
 --output-document=- \
 --no-verbose \
 --post-data="method=pwg.categories.getList" \
 "$baseUrl/ws.php?format=rest")
categoryIds=()
while read_dom; do
    [[ "$TAG_NAME" = "category" ]] && {
		eval $ATTRIBUTES
		categoryIds+=("$id")
	}
done <<< "$restCategoryList"

for categoryId in ${categoryIds[*]}
do
	# get permission for category
	restCategoryPermission=$(wget --load-cookies "$sessionCookiePath" \
	 --output-document=- \
	 --no-verbose \
	 --post-data="method=pwg.permissions.getList&cat_id=$categoryId" \
	 "$baseUrl/ws.php?format=rest")
	userIds=()
	groupIds=()
	isUser=false
	isGroup=false
	while read_dom; do
		[[ "$TAG_NAME" = "users" ]] && isUser=true
		[[ "$TAG_NAME" = "/users" ]] && isUser=false
		[[ "$TAG_NAME" = "groups" ]] && isGroup=true
		[[ "$TAG_NAME" = "/groups" ]] && isGroup=false
		
		[[ "$TAG_NAME" = "item" ]] && {
			[[ $isUser = true ]] && userIds+=("$CONTENT")
			[[ $isGroup = true ]] && groupIds+=("$CONTENT")
		}
	done <<< "$restCategoryPermission"
	
	# build permission string
	permissionParameterString=""
	for groupId in ${groupIds[*]}
	do
		permissionParameterString+="&groups%5B%5D=$groupId"
	done
	for userId in ${userIds[*]}
	do
		permissionParameterString+="&users%5B%5D=$userId"
	done

	echo "INFO $(date -Is) - Set and inherit permissions for category $categoryId"
	wget --load-cookies "$sessionCookiePath" \
	 --no-verbose \
	 --output-document=/dev/null \
	 --post-data="status=private$permissionParameterString&apply_on_sub=1&pwg_token=$token&submit=1" \
	 "$baseUrl/admin.php?page=album-$categoryId-permissions"
done
