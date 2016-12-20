# piwigo-scripts PiwigoPermission
Unix command line script for piwigo permissions.

<pre>pwg.permission.set_and_inherit.sh &lt;piwigoBaseUrl> &lt;sessionCookiePath></pre>
Resets and inherit the permissions of main categories in the piwigo with URL *piwigoBaseUrl*. 
For that, it uses the session cookie in *sessionCookiePath* (use 
PiwigoSession/pwg.session.login.sh to create a session cookie file).

For piwigo communication, wget is required.
