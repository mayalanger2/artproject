<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>details</title>
<!-- Bootstrap -->
<link href="../css/bootstrap-4.4.1.css" rel="stylesheet">
<link href="../basic.css" rel="stylesheet" type="text/css">
<link href = "../back-end.css" rel="stylesheet" type="text/css">
</head>
<body>
<cfif isDefined("url.success") and url.success EQ "y">
  <div style="background-color: green; height: 100%; width: 100%; position: absolute; z-index: 2;">
    <p style="color:white; position: absolute; margin: 0; top: 50%; left: 50%; transform: translate(-50%, -50%);">Image was modified.</p>
    <a class="btn btn-outline-light" style = " position: absolute; margin: 0; top: 55%; left: 50%; transform: translate(-50%, -50%);"href = "index-admin.cfm" id = "back-btn">BACK TO GALLERY</a> </div>
  <cfelseif isDefined("url.success") and url.success EQ "n">
  <div style="background-color: red; height: 100%; width: 100%; position: absolute; z-index: 2;">
    <p style="color:white; position: absolute; margin: 0; top: 50%; left: 50%; transform: translate(-50%, -50%);">Image was not modified.</p>
    <a class="btn btn-outline-light" style = " position: absolute; margin: 0; top: 55%; left: 50%; transform: translate(-50%, -50%);"href = "index-admin.cfm" id = "back-btn">BACK TO GALLERY</a> </div>
  <cfelse>
</cfif>

<!--HEADER FOR DOUBLE COLUMN PAGE--->
<div id = "head" class="col-lg-12">
  <header>
    <nav class="navbar"> <a class="btn btn-outline-light" href = "index-admin.cfm" id = "back-btn">BACK TO GALLERY</a> </nav>
  </header>
</div>
<!--END OF HEADER FOR DOUBLE COLUMN PAGE--> 
<!--LAYOUT FOR EQUAL COLUMN PAGE-->

<div id = "equal-col" class="container-fluid">
  <div class="row"> 
    
    <!--LEFT-COLUMN-->
    <div id = "left-col" class="col-lg-6">
      <form action="details-admin.cfm?<cfoutput>#cgi.query_string#</cfoutput>" method="post" enctype="multipart/form-data">
        <cfparam name="url.artworkid" default = "">
        <cfset url.artworkid = "#url.artworkid#">
        <cfset madeArtwork = "N">
        <cfif isDefined("url.artworkid") and url.artworkid NEQ "">
          <cfset madeArtwork = "Y">
          <cfquery name = "qGetImageDetails" datasource="gallery">
              SELECT *
              FROM ARTWORK
              LEFT JOIN SUBMISSION ON ARTWORK.artwork_id = SUBMISSION.artwork_id
            LEFT JOIN SCHOOLSTEMP ON ARTWORK.school_id = SCHOOLSTEMP.locNumber
           LEFT JOIN PIN ON ARTWORK.artwork_id = PIN.artwork_id
              WHERE ARTWORK.artwork_id = '#url.artworkid#';
          </cfquery>
        </cfif>
        <div class = "artwork-text">
        <h2 class = "review-page">Review Submission</h2>
        <hr class = "details-divider">
        <cfif #madeArtwork# is "Y">
          <h1 class = "artwork-title"><cfoutput>#qGetImageDetails.artwork_title#</cfoutput></h1>
          <p id = "by">by</p>
          <cfloop query="qGetImageDetails">
            <h3 class = "artwork-student"><cfoutput>#qGetImageDetails.student_id#</cfoutput></h3>
          </cfloop>
          <h3 class = "artwork-teacher"><cfoutput>#qGetImageDetails.staff_id#</cfoutput></h3>
          <p id = "tags">Current Tags: </p>
          <cfloop query="qGetImageDetails">
            <h3 class = "artwork-tags"><cfoutput>#qGetImageDetails.tag_id#</cfoutput></h3>
          </cfloop>
          <div class="form-group">
            <label for="exampleFormControlTextarea1">Add a Tag: ex. 2020Summer</label>
            <input type="text" class="form-control" id="gallery-tag" name = "galleryTag" style = "width: 80%;">
          </div>
           <div class="form-group">
            <label for="exampleFormControlTextarea1">Delete a Tag: ex. 2020Summer</label>
            <input type="text" class="form-control" id="gallery-tag" name = "galleryDelTag" style = "width: 80%;">
          </div>
          <cfif qGetImageDetails.artwork_slides EQ "1">
            <div class="checkbox">
              <label class="checkbox-inline no_indent">
                <input type="checkbox" name = "slides" class="form-check-input" id="slides-decision" checked>
                Include in the Front Page Slides? </label>
            </div>
            <cfelse>
            <div class="checkbox">
              <label class="checkbox-inline no_indent">
                <input type="checkbox" name = "slides" class="form-check-input" id="slides-decision" >
                Include in the Front Page Slides? </label>
            </div>
          </cfif>
          <br>
          <hr class = "details-divider">
          <p>Current Approval Status: <cfoutput>#qGetImageDetails.artwork_approval#</cfoutput></p>
          <p>New Approval Status:</p>
          <div id = "approval" style = "margin-top: 1em;">
            <div class="form-group">
              <select class="form-control" id="sel1" name = "decision" style = "width: 80%;">
                <option value = "approved">Approve</option>
                <option value = "unapproved">Disapprove</option>
                <option value = "undecided">Undecided</option>
              </select>
            </div>
          </div>
          <cfif isDefined("form.galleryTag") and form.galleryTag NEQ "">
                  
            <cfquery datasource="gallery">
              INSERT INTO PIN
              (artwork_id, tag_id)
              VALUES ('#qGetImageDetails.artwork_id#', '#form.galleryTag#');
            </cfquery>
          </cfif>
              
        <cfif isDefined("form.galleryDelTag") and form.galleryDelTag NEQ "">
             <cfquery datasource="gallery">
              DELETE FROM PIN WHERE tag_id LIKE '#form.galleryDelTag#' AND artwork_id = '#qGetImageDetails.artwork_id#';
           </cfquery>
        </cfif>
          <button type = "submit" name = "confirm" class="btn btn-primary" id = "confirm-btn" style = "background-color: #0A6F9E;">Confirm</button>
          <cfset slidesDecision = 0>
          <cfif isDefined("form.slides") and form.slides EQ "on">
            <cfset slidesDecision = 1>
          </cfif>
          <cfquery datasource = "gallery">
        UPDATE ARTWORK
        SET artwork_slides = '#slidesDecision#'
        WHERE ARTWORK.artwork_id = '#qGetImageDetails.artwork_id#';
        </cfquery>
          <cfif isDefined("form.decision")>
            <cfquery datasource="gallery">
            UPDATE ARTWORK
            SET artwork_approval = '#form.decision#'
            WHERE ARTWORK.artwork_id = '#qGetImageDetails.artwork_id#';
            </cfquery>
            <cfquery datasource="gallery">
            UPDATE ARTWORK
            SET artwork_reviewed = '1'
            WHERE artwork_id = '#qGetImageDetails.artwork_id#';
            </cfquery>
          </cfif>
          </div>
          <cfelse>
        </cfif>
        <cfif isDefined("confirm")>
          <cflocation url="#cgi.script_name#?success=y" addtoken="no">
        </cfif>
      </form>
    </div>
    <!--END-OF-LEFT-COL--> 
    
    <!--RIGHT-COLUMN-->
    <cfif #madeArtwork# is "Y">
      <div id = "right-col" class="col-lg-6">
        <cfif #madeArtwork# is "Y">
          <img class = "artwork" src="<cfoutput>#request.rootURL#</cfoutput>/uploads/<cfoutput>#qGetImageDetails.artwork_id#</cfoutput>.jpg" alt=""/>
        </cfif>
      </div>
    </cfif>
    <!--END-OF-RIGHT-COL--> 
    
  </div>
</div>
<!--END OF LAYOUT FOR EQUAL COLUMN PAGE--> 

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) --> 
<script src="../js/jquery-3.4.1.min.js"></script> 

<!-- Include all compiled plugins (below), or include individual files as needed --> 
<script src="../js/popper.min.js"></script> 
<script src="../js/bootstrap-4.4.1.js"></script>
</body>
</html>
