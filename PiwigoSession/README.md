# piwigo-scripts PiwigoSession
Unix command line scripts for piwigo session.

pwg.session.login.sh <piwigoBaseUrl> <username> <password> <sessionCookiePath>
Logs in the user username/password to piwigo with URL piwigoBaseUrl and saves the sessionCookie to the sessionCookiePath.

pwg.session.logout.sh <piwigoBaseUrl> <sessionCookiePath>
Logs out a user from piwigo with URL piwigoBaseUrl identified by the sessionCookie in the sessionCookiePath.
