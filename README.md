# piwigo-scripts
Unix command line scripts for [piwigo](http://piwigo.org/). The scripts were 
developed to be able to automatically add new categories to piwigo, but some 
scripts can be used standalone as well. Please see README.md file in 
corresponding script folder for details.

Tests were run against piwigo 2.8. In piwigo only physical categories exists
in a own piwigo site. The scripts were developed to automatically add new
categories to piwigo.

The main script folder is CheckAndUpdatePiwigo. To use this script, the 
configuration file CheckAndUpdatePiwigo/conf/piwigo.conf needs to be created
(sample file is available). After that, the script can be started with 
CheckAndUpdatePiwigo/start.sh. It checks recursively for new folders and
for changed file or subfolder list in a folder in *piwigoDir*. For any new folder, it calls 
*newFolderCommand*. By default it is onNewFolder.sh 
which renames all files with PictureRenaming/renamePic2Date.sh, converts 
all videos with VideoConvertion/convertVideos.sh and creates posters for 
all video files with PosterCreation/createPosters.sh in the folder. For any 
folder with changed file list, it calls *changedFilesCommand*. By default it 
is onChangedFiles.sh, which does the same as onNewFolder.sh. After *piwigoDir*
scan finished, piwigo will be updated if anything changed in 
*piwigoDir* as followd.

1. Log in to piwigo with PiwigoSession/pwg.session.login.sh.
2. Synchronize piwigo site with PiwigoSiteSynchronisation/pwg.site.sync.sh.
3. Generate missing derivatives with PiwigoGenerateDerivatives/pwg.generateAllMissingDerivatives.sh.
4. Update category permissions with PiwigoPermission/pwg.permission.set_and_inherit.sh.
5. Log out from piwigo with PiwigoSession/pwg.session.logout.sh.
