#!/bin/bash

basedir=$(dirname "$0")
mode=$1

# load config file
source "$basedir/conf/piwigo.conf"

echo INFO $(date -Is) - start $0

[[ $mode == "test" ]] && {
	newFolderCommand=""
	changedFilesCommand=""
	changedSubfoldersCommand=""
	echo INFO $(date -Is) - running in testmode
} 

# check piwigo directory
echo INFO $(date -Is) - check piwigo directory 
"$basedir"/check4DirChangesRecursive.sh "$listDir" "$piwigoDir" "$newFolderCommand" "$changedFilesCommand" "$changedSubfoldersCommand" "$notPath"

# Update piwigo if necessary
[[ -f "$basedir"/.dirChanged ]] && {
	rm "$basedir"/.dirChanged
	[[ $mode == "test" ]] && exit 0
	
	echo INFO $(date -Is) - piwigo directory has changed - update piwigo
	
	echo INFO $(date -Is) - login 
	sessionCookiePath=$(realpath "$basedir"/../PiwigoSession/sessionCookie.txt)
	"$basedir"/../PiwigoSession/pwg.session.login.sh $url $username $password "$sessionCookiePath"

	echo INFO $(date -Is) - sync piwigo 
	"$basedir"/../PiwigoSiteSynchronisation/pwg.site.sync.sh $url "$sessionCookiePath" $siteToSync

	echo INFO $(date -Is) - generate all missing derivatives
	"$basedir"/../PiwigoGenerateDerivatives/pwg.generateAllMissingDerivatives.sh $url "$sessionCookiePath"

	echo INFO $(date -Is) - update album permissions 
	"$basedir"/../PiwigoPermission/pwg.permission.set_and_inherit.sh $url "$sessionCookiePath"

	echo INFO $(date -Is) - logout
	"$basedir"/../PiwigoSession/pwg.session.logout.sh $url "$sessionCookiePath"
}

echo INFO $(date -Is) - $0 finished
