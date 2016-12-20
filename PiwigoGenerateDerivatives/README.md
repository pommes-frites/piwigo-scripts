# piwigo-scripts PiwigoGenerateDerivatives
Unix command line script for missing derivatives (image size) generation in piwigo.

<pre>pwg.generateAllMissingDerivatives.sh &lt;piwigoBaseUrl> &lt;sessionCookiePath></pre>
Generates all missing derivatives in the piwigo with URL *piwigoBaseUrl*. For that, it
uses the session cookie in *sessionCookiePath* (use PiwigoSession/pwg.session.login.sh to
create a session cookie file).

The script uses [custom_missing_derivatives](http://piwigo.org/ext/extension_view.php?eid=846) 
plugin to generate additional custom derivatives. Change the value of script variable 
<code>wsMethod</code> to set custom derivatives or to use the piwigo built-in 
webservice method pwg.getMissingDerivatives.

For piwigo communication, wget is required.
