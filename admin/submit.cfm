<!DOCTYPE html>

<html lang="en">
<!-- InstanceBegin template="/Templates/alt-single-column.dwt" codeOutsideHTMLIsLocked="false" -->
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- InstanceBeginEditable name="doctitle" -->
<title>upload</title>
<!-- InstanceEndEditable -->
<!-- Bootstrap -->
<link href="../css/bootstrap-4.4.1.css" rel="stylesheet">
<link href="../basic.css" rel="stylesheet" type="text/css">
<link href="../back-end.css" rel="stylesheet" type="text/css">
<!-- InstanceBeginEditable name="head" -->
<!-- InstanceEndEditable -->
</head>
<body id = "alt-body">
<!-- InstanceBeginEditable name="page-content" --> 
<!---DEFINED SECTION--->

<cfif (isDefined("form.artworkTitle") AND form.artworkTitle NEQ "") AND (isDefined("form.staffID") AND form.staffID NEQ "") AND (isDefined("form.schoolName") AND form.schoolName NEQ "")>
  <cfset fileName = createUUID()>
  <cftry>
    <cfquery datasource = "gallery" name = "qGetSchool">
          SELECT locNumber
          FROM SCHOOLSTEMP
          WHERE fullName LIKE '#form.schoolName#'
          OR name LIKE '#form.schoolName#';
      </cfquery>
    <cfset schoolID = qGetSchool.locNumber>
    <cfquery datasource = "gallery">
            INSERT INTO ARTWORK (artwork_ID, artwork_title, submission_artist, staff_ID, school_ID, artwork_reviewed, artwork_approval, artwork_slides) VALUES ('#fileName#', '#form.artworkTitle#', '#form.submissionArtist#', '#form.staffID#', '#schoolID#', '0', 'undecided', '0');
        </cfquery>
    <cfif isDefined("form.artworkPhoto") and form.artworkPhoto NEQ "">
      <!---get server root directory--->
      <cfset variables.serverRootDirectory = "/opt/lucee/tomcat/webapps/ROOT/">
      <cffile action = "upload" fileField = "artworkPhoto" destination = "#variables.serverRootDirectory#uploads/#Variables.fileName#.jpg" accept = "image/jpg,image/jpeg,image/pjpeg" nameConflict = "makeUnique">
    </cfif>
    <cfif (isDefined("form.studentID") AND form.studentID NEQ "")>
      <cfloop list= "#form.studentID#" delimiters="," index="thisStudent">
        <cfquery datasource = "gallery">
        INSERT INTO SUBMISSION (artwork_ID, student_ID) VALUES ('#fileName#', '#thisStudent#');
    </cfquery>
      </cfloop>
    </cfif>
    <cfif (isDefined("form.tag") AND form.tag NEQ "")>
      <cfloop list= "#form.tag#" delimiters="," index="thisTag">
        <cfquery datasource = "gallery">
        INSERT INTO PIN (artwork_ID, tag_ID) VALUES ('#fileName#', '#thisTag#');
    </cfquery>
      </cfloop>
    </cfif>
    <cflocation url="#cgi.script_name#?success=y" addtoken="no">
    <cfcatch type="database">
      <cfquery datasource="gallery">
          DELETE FROM ARTWORK WHERE artwork_ID = '#fileName#';
      </cfquery>
      <cfif (isDefined("form.studentID") AND form.studentID NEQ "")>
        <cfquery datasource="gallery">
          DELETE FROM SUBMISSION WHERE artwork_ID = '#fileName#';
          </cfquery>
      </cfif>
      <cfif (isDefined("form.tag") AND form.tag NEQ "")>
        <cfquery datasource="gallery">
          DELETE FROM PIN WHERE artwork_ID = '#fileName#';
          </cfquery>
      </cfif>
      <cflocation url="#cgi.script_name#?success=n" addtoken="no">
    </cfcatch>
  </cftry>
</cfif>
<cfif isDefined("url.success") and url.success EQ "y">
  <div style="background-color:green;padding:10px;padding-left: 5em;">
    <p style="color:white;">Artwork was sucessfully submitted.</p>
  </div>
  <cfelseif isDefined("url.success") and url.success EQ "n">
  <div style="background-color:red;padding:10px;padding-left: 5em;">
    <p style="color:white;">Artwork was not submitted.</p>
  </div>
  <cfelse>
</cfif>
<!---END OF DEFINED SECTION--->

<div class = "center-form">
  <div class="container-fluid" id="alt-fluid">
  <form id = "alt-form" action="submit.cfm" method="post" enctype="multipart/form-data">
    <h1 class = "alt-page-label">UPLOAD</h1>
    <div class="form-group">
      <input type="text" class="form-control" id="formGroupExampleInput4" name = "staffID" placeholder="LPS Staff Username" required>
    </div>
    <div class="form-group">
      <input type="text" class="form-control" id="student-id" name = "submissionArtist" placeholder="Artist(s) Description">
    </div>
    <div class = "row">
      <div class = "col">
        <label for="artwork-school">School</label>
        <div class="form-group">
          <input type="text" class="form-control" id="artwork-school" name = "schoolName" placeholder="Lincoln High" required>
        </div>
      </div>
      <div class = "col">
        <div class="form-group">
          <label for="exampleFormControlTextarea1">Add Students: ex. 1231231234,2342342345</label>
          <textarea class="form-control" id="artwork-students" rows="3" name = "studentID"></textarea>
          <small class = "tag-description">*Commas are used to separate students</small> </div>
      </div>
    </div>
    <div class="form-group">
      <input type="text" class="form-control" id="artwork-title" name = "artworkTitle" placeholder="Title of Submission" required>
    </div>
    <div class="row">
      <div class="col">
        <div class="form-group">
          <label for="exampleFormControlTextarea1">Tags: ex. 2020Summer,2020Fall</label>
          <textarea class="form-control" id="artwork-tags" rows="3" name = "tag"></textarea>
          <small class = "tag-description" >*Commas are used to separate tags. <span style = "color:red;"> Do not use a hashtag/pound sign.</span> </small> </div>
      </div>
      <div class="col">
        <div class="form-group">
          <label for="artwork-upload" id = "upload-label">Upload a file</label>
          <input type="file" name = "artworkPhoto" class="form-control-file" id="artwork-upload">
        </div>
      </div>
    </div>
    </div>
    
    <button type="submit" class="btn btn-danger" id = "upload">Submit</button>
    <a href = "index-admin.cfm" role="button" class="btn btn-secondary">Cancel</a>
       
  </form>
</div>
</div>
<!-- InstanceEndEditable --> 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) --> 
<script src="../js/jquery-3.4.1.min.js"></script> 

<!-- Include all compiled plugins (below), or include individual files as needed --> 
<script src="../js/popper.min.js"></script> 
<script src="../js/bootstrap-4.4.1.js"></script>
</body>
<!-- InstanceEnd -->
</html>
