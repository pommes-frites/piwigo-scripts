# piwigo-scripts PosterCreation
Unix command line scripts for piwigo video poster creation.

<pre>createPoster.sh &lt;filePath> [overwrite]</pre>
Creates a poster for the video in *filePath*. It overwrites an existing poster,
if overwrite is given as second argument. This script requires ffmpeg.

<pre>createPosters.sh &lt;path></pre>
Creates posters for all MP4 files in *path* (non recursive) by using 
createPoster.sh.
