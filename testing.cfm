<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>testing</title>
<!-- Bootstrap -->
<link href="css/bootstrap-4.4.1.css" rel="stylesheet">
</head>
<body>

<cfif isDefined("form.testingTitle") and form.testingTitle NEQ "">
  <cfset fileName = createUUID()>
  <cftry>
    <cfquery datasource="gallery">
          INSERT INTO TESTING (title) values ('#form.testingTitle#');
    </cfquery>
   
    <cflocation url="#cgi.script_name#?success=y" addtoken="no">
    <cfcatch type="all">
      <cflocation url="#cgi.script_name#?success=n" addtoken="no">
    </cfcatch>
  </cftry>
</cfif>
      
<cfif isDefined("url.success") and url.success EQ "y">
  <div style="background-color:green;padding:10px;border-radius:5px;">
    <p style="color:white;">Good Job! You did it!</p>
  </div>
  <cfelseif isDefined("url.success") and url.success EQ "n">
  <div style="background-color:red;padding:10px;border-radius:5px;">
    <p style="color:white;">Bad Job! You didn't do it!</p>
  </div>
  <cfelse>
</cfif>

<!---The Post method passes data to a specified ColdFusion page (testing.cfm) that interprets the variables being sent and returns data.--->
<form action="testing.cfm" method="post">
  <h1>This is a Form.</h1>
  <label for="testingTitle">Put title here.</label>
  <div class="form-group">
    <input type="text" class="form-control" placeholder="Title" name = "testingTitle" required>
  </div>
    <div class="form-group">
    <input type="text" class="form-control" placeholder="Title" name = "dog" required>
  </div>
  <button type="submit" class="btn btn-danger" name="upload">ADD TITLE</button>
</form>

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) --> 
<script src="js/jquery-3.4.1.min.js"></script> 

<!-- Include all compiled plugins (below), or include individual files as needed --> 
<script src="js/popper.min.js"></script> 
<script src="js/bootstrap-4.4.1.js"></script>
</body>
</html>