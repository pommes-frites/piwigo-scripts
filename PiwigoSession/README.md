# piwigo-scripts PiwigoSession
Unix command line scripts for piwigo session.

<pre>pwg.session.login.sh <piwigoBaseUrl> <username> <password> <sessionCookiePath></pre>
Logs in the user *username*/*password* to piwigo with URL *piwigoBaseUrl* and saves the session cookie to the *sessionCookiePath*.

<pre>pwg.session.logout.sh <piwigoBaseUrl> <sessionCookiePath></pre>
Logs out a user from piwigo with URL *piwigoBaseUrl* identified by the session cookie in the *sessionCookiePath*.
