# piwigo-scripts PictureRenaming
Unix command line script for automatic file renaming.

<pre>renamePic2Date.sh &lt;path></pre>
Renames all files in the given path (non recursive) in *yyyyMMdd_hhmmss*. The
script works as followed.

- Checks if *path* contains file named .ignoreFilenames. If not, the script 
proceed for each *file* in *path*.
- Checks if *file* matches the pattern [0-9]{8}_[0-9]{6}. If not, the script
proceed for *file*.
- Checks if *file* contains the pattern [0-9]{8}_[0-9]{6}. If so, *file* is
renamed to this part. If not, the script proceed for *file*.
- Uses DateTimeOriginal, CreationDate, CreateDate, CreateDate or ModifyDate
from Exif meta data to rename *file*.

For the last step [exiftool](http://www.sno.phy.queensu.ca/~phil/exiftool/) is required.
