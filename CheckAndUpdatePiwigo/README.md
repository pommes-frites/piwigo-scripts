# piwigo-scripts CheckAndUpdatePiwigo
Unix command line scripts that analyzes a specified path. For changed 
files or folders it calls the corresponding script file.

Create the file conf/piwigo.conf. A sample file is available. 

<pre>start.sh</pre>
Calls checkAndUpdatePiwigo.sh and redirects stdout and stderr to 
log/*yyyyMMdd_hhmmss*.log.

<pre>checkAndUpdatePiwigo.sh [test]</pre>
Calls check4DirChangesRecursive.sh with parameters defined in conf/piwigo.conf.
If changes were detected and test is not the first argument, it updates piwigo 
in the following order.

1. Log in to piwigo with ../PiwigoSession/pwg.session.login.sh.
2. Synchronize piwigo site with ../PiwigoSiteSynchronisation/pwg.site.sync.sh.
3. Generate missing derivatives with ../PiwigoGenerateDerivatives/pwg.generateAllMissingDerivatives.sh.
4. Update category permissions with ../PiwigoPermission/pwg.permission.set_and_inherit.sh.
5. Log out from piwigo with ../PiwigoSession/pwg.session.logout.sh.

As indicated with by the relative script paths, these script folders needs to be
on the same level as this script folder.

<pre>check4DirChangesRecursive.sh &lt;listDirRoot> &lt;checkDirRoot> [ newFolderCommand [ changedFilesCommand [ changedSubFoldersCommand [ notPath ] ] ] ]</pre>
Checks recursively if any file or subfolder in path *checkDirRoot* were changed. The 
path *listDirRoot* will be used to save the current state of the structure.
For any new folder, *newFolderCommand* will be called. For any file list change
in a folder, *changedFilesCommand* will be called. For any subfolder list change
in a folder, *changedSubFoldersCommand* will be called. With *notPath* it is
possible to exclude specified folders. See <code>find -not -path</code> for details.
