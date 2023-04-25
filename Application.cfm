<cfset request.dsn = "gallery">
<cfset request.rootURL = "http://lucee.lps.net:8888">
<cfset request.rootPath = "/opt/lucee/tomcat/webapps/ROOT">
<CFAPPLICATION name="gallery" sessionmanagement="yes" sessiontimeout="#CreateTimeSpan(0,4,0,0)#">