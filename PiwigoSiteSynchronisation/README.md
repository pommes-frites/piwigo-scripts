# piwigo-scripts PiwigoSiteSynchronisation
Unix command line script for piwigo site synchronisation.

<pre>pwg.site.sync.sh &lt;piwigoBaseUrl> &lt;sessionCookiePath> &lt;piwigoSiteId></pre>
Synchronise the site with ID *piwigoSiteId* in the piwigo with URL *piwigoBaseUrl*. 
For that, it uses the session cookie in *sessionCookiePath* (use 
PiwigoSession/pwg.session.login.sh to create a session cookie file).

For piwigo communication, wget is required.
