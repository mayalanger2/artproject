<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>details</title>
<!-- Bootstrap -->
<link href="css/bootstrap-4.4.1.css" rel="stylesheet">
<link href="basic.css" rel="stylesheet" type="text/css">
<link href="front-end.css" rel="stylesheet" type="text/css">
</head>
<body>
<!--HEADER FOR DOUBLE COLUMN PAGE--->
<div id = "head" class="col-lg-12">
  <header>
    <nav class="navbar"> <a class="navbar-brand" href="https://www.lps.org/"> <img src="resources/Small%20LPS%20Logo.png" width = "39" height = "30" class="d-inline-block align-top" alt=""> LPS Gallery </a> <a class="btn btn-outline-light" role="button" href = "index.cfm" id = "back-btn">BACK TO GALLERY</a> </nav>
  </header>
</div>
<!--END OF HEADER FOR DOUBLE COLUMN PAGE--> 

<!--LAYOUT FOR EQUAL COLUMN PAGE-->
<div id = "equal-col" class="container-fluid">
  <div class="row"> 
    
    <!--LEFT-COLUMN-->
    <div id = "left-col" class="col-lg-6">
      <cfparam name="url.artworkid" default = "">
      <cfset url.artworkid = "#url.artworkid#">
      <cfset madeArtwork = "N">
      <cfif isDefined("url.artworkid") and url.artworkid NEQ "">
        <cfset madeArtwork = "Y">
        <cfquery name = "qGetImageDetails" datasource="gallery">
              SELECT *
              FROM ARTWORK
            LEFT JOIN SCHOOLSTEMP ON ARTWORK.school_id = SCHOOLSTEMP.locNumber
           LEFT JOIN SUBMISSION ON ARTWORK.artwork_id = SUBMISSION.artwork_id
           LEFT JOIN PIN ON ARTWORK.artwork_id = PIN.artwork_id
              WHERE ARTWORK.artwork_id = '#url.artworkid#';
          </cfquery>
      </cfif>
      <div class = "drip-dec">
        <div class = "artwork-text">
          <cfif #madeArtwork# is "Y">
            <h1 class = "artwork-title"><cfoutput>#qGetImageDetails.artwork_title#</cfoutput></h1>
            <cfelse>
            <h1 class = "artwork-title">Artwork Title</h1>
          </cfif>
          <p id = "by">by</p>
          <cfif #madeArtwork# is "Y">
            <h3 class = "artwork-student"><cfoutput>#qGetImageDetails.submission_artist#</cfoutput></h3>
            <cfquery name = "qGetStudents" datasource="gallery">
                SELECT SUBMISSION.student_id
                FROM SUBMISSION
                WHERE SUBMISSION.artwork_id = '#url.artworkid#';
            </cfquery>
            <cfloop query = "qGetStudents">
              <h3 class = "artwork-student"><cfoutput>#qGetStudents.student_id#</cfoutput></h3>
            </cfloop>
            <cfelse>
            <h3 class = "artwork-student">Student Name</h3>
          </cfif>
        </div>
      </div>
    </div>
    <!--END-OF-LEFT-COL--> 
    
    <!--RIGHT-COLUMN-->
    <div id = "right-col" class="col-lg-6">
      <cfif #madeArtwork# is "Y">
        <img class = "artwork" src="<cfoutput>#request.rootURL#</cfoutput>/uploads/<cfoutput>#qGetImageDetails.artwork_id#</cfoutput>.jpg" alt=""/>
      </cfif>
    </div>
    <!--END-OF-RIGHT-COL--> 
    
  </div>
</div>
<!--END OF LAYOUT FOR EQUAL COLUMN PAGE--> 

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) --> 
<script src="js/jquery-3.4.1.min.js"></script> 

<!-- Include all compiled plugins (below), or include individual files as needed --> 
<script src="js/popper.min.js"></script> 
<script src="js/bootstrap-4.4.1.js"></script>
</body>
</html>
