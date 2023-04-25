
<cfif isDefined("form.username") and form.username NEQ "">
<cfldap action="QUERY"
   name="qLocateUser"
   server="cougar.lps.net"
   start="ou=Staff,ou=LPSUsers,dc=lps,dc=net"
   filter="(&(objectclass=user)(samaccountname=#form.userName#))"
   maxrows="1"
   attributes="samaccountname, givenname, sn"
   timeout="5"
   username="#form.userName#@lps.net"
   password="#form.userPass#">
<cfdump var="#qLocateUser#">
</cfif>
<form action="ad-test.cfm" method="post">
	<input type="text" name="username" id="username" placeholder="username"><br/>
	<input type="password" name="userpass" id="userpass" placeholder="password"><br/>
	<input type="submit" name="submit" id="submit">
</form>