# piwigo-scripts VideoConvertion
Unix command line scripts for video convertion.

<pre>convertVideo.sh &lt;filePath> [overwrite]</pre>
Converts the video in *filePath* in a MP4 video file with the same name. 
It overwrites an existing video, if overwrite is given as second argument. 
This script requires ffmpeg.

<pre>convertVideo.sh &lt;path></pre>
Converts videos for any AVI, MOV, WMV or 3GP in *path* (non recursive) to a 
MP4 video file by using convertVideo.sh.
