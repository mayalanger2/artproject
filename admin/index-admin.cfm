<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>index-admin</title>
<!-- Bootstrap -->
<link href="../css/bootstrap-4.4.1.css" rel="stylesheet">
<link href="../basic.css" rel="stylesheet" type="text/css">
<link href="../back-end.css" rel = "stylesheet" type="text/css">
</head>
<body>

<!--LAYOUT FOR UNEQUAL COLUMN PAGE-->
<div id = "unequal-col" class="container-fluid">
  <form action="index-admin.cfm" method="get">
  <div class="row">
  <!--LEFT-COLUMN-->
  <div id = "left-col-small" class="col-lg-4" style="background-repeat: no-repeat"> 
    <!--BUTTONS-->
    <div id = "left-col-buttons" class = "col-lg-12">
      <div class = "row"><a href="../manage-galleries.cfm" id = "manage-galleries-btn" class="btn btn-primary btn-lg active" role="button" aria-pressed="true">Manage Galleries</a> </div>
      <div class = "row"><a href="submit.cfm" id = "upload-art-btn" class="btn btn-danger btn-lg active" role="button" aria-pressed="true">Upload Art</a> </div>
      <!--END-OF-BUTTONS--> 
    </div>
    <!--SELECTION LINKS-->
    <cfset status = "Unreviewed">
    <div id = "left-col-links">
      <ul id = "left-col-list">
        <li><a href="<cfoutput>#cgi.script_name#?status=Reviewed</cfoutput>" name = "reviewed">Reviewed Submissions</a></li>
        <hr class = "left-col-separate">
        <li><a href="<cfoutput>#cgi.script_name#?status=Unreviewed</cfoutput>" name = "unreviewed">Unreviewed Submissions</a></li>
        <hr class = "left-col-separate">
        <li><a href="<cfoutput>#cgi.script_name#?status=Approved</cfoutput>" name = "approved">Approved Submissions</a></li>
        <hr class = "left-col-separate">
        <li><a href="<cfoutput>#cgi.script_name#?status=Unapproved</cfoutput>" name = "unapproved">Unapproved Submmissions</a></li>
        <hr class = "left-col-separate">
        <li><a href="<cfoutput>#cgi.script_name#?status=Undecided</cfoutput>" name = "undecided">Undecided Submissions</a></li>
      </ul>
    </div>
  </div>
  <!--END-OF-LEFT-COL-->
  
  <cfparam name="url.status" default = "Unreviewed">
  <cfset #status# = "#url.status#">
  <cfif #status# is "Unreviewed">
    <cfquery name = "qGetArtwork" datasource="gallery">
            SELECT *
            FROM ARTWORK
            LEFT JOIN SCHOOLSTEMP ON ARTWORK.school_id = SCHOOLSTEMP.locNumber
            LEFT JOIN SUBMISSION ON ARTWORK.artwork_id = SUBMISSION.artwork_id
            LEFT JOIN PIN ON ARTWORK.artwork_id = PIN.artwork_id
            WHERE artwork_reviewed = "0";
        </cfquery>
  </cfif>
  <cfif #status# is "Reviewed">
    <cfquery name = "qGetArtwork" datasource="gallery">
            SELECT *
            FROM ARTWORK
            LEFT JOIN SCHOOLSTEMP ON ARTWORK.school_id = SCHOOLSTEMP.locNumber
            LEFT JOIN SUBMISSION ON ARTWORK.artwork_id = SUBMISSION.artwork_id
            LEFT JOIN PIN ON ARTWORK.artwork_id = PIN.artwork_id
            WHERE artwork_reviewed = "1";
        </cfquery>
  </cfif>
  <cfif #status# is "Approved">
    <cfquery name = "qGetArtwork" datasource="gallery">
            SELECT *
            FROM ARTWORK
            LEFT JOIN SCHOOLSTEMP ON ARTWORK.school_id = SCHOOLSTEMP.locNumber
            LEFT JOIN SUBMISSION ON ARTWORK.artwork_id = SUBMISSION.artwork_id
            LEFT JOIN PIN ON ARTWORK.artwork_id = PIN.artwork_id
            WHERE artwork_approval = "approved";
        </cfquery>
  </cfif>
  <cfif #status# is "Unapproved">
    <cfquery name = "qGetArtwork" datasource="gallery">
            SELECT *
            FROM ARTWORK
            LEFT JOIN SCHOOLSTEMP ON ARTWORK.school_id = SCHOOLSTEMP.locNumber
            LEFT JOIN SUBMISSION ON ARTWORK.artwork_id = SUBMISSION.artwork_id
            LEFT JOIN PIN ON ARTWORK.artwork_id = PIN.artwork_id
            WHERE artwork_approval = "unapproved";
        </cfquery>
  </cfif>
  <cfif #status# is "Undecided">
    <cfquery name = "qGetArtwork" datasource="gallery">
            SELECT *
            FROM ARTWORK
            LEFT JOIN SCHOOLSTEMP ON ARTWORK.school_id = SCHOOLSTEMP.locNumber
            LEFT JOIN SUBMISSION ON ARTWORK.artwork_id = SUBMISSION.artwork_id
            LEFT JOIN PIN ON ARTWORK.artwork_id = PIN.artwork_id
            WHERE artwork_approval = "undecided";
        </cfquery>
  </cfif>
  
  <!--RIGHT-COLUMN-->
  
  <div id = "right-col-large" class="col-lg-8">
  <!--ADVANCED-SEARCH-->
  
  <div id = "advanced-search" style = "display: none;" class="container-fluid">
  <form>
    <h4>Advanced Search</h4>
    <div class = "row">
      <label for="search" style="margin-left: 1em;">Search by Student ID, Artist Description, Teacher Username, School, Tag, or Artwork Title</label>
      <input type="text" class="form-control" id="search" name = "search" style = "margin: auto; margin-bottom: .5em; margin-left: 1em; margin-right: 5em;">
    </div>
    <div class = "row">
      <button id = "advanced-search-btn" type="submit" class="btn btn-danger btn-lg active" style = "margin-bottom: em;">Search</button>
    </div>
  </form>
</div>
<cfset search = "N">
<cfif isDefined("url.search") AND url.search NEQ "">
  <cfset #search# = "Y">
  <cfquery name = "qGetSearch" datasource="gallery">
           SELECT *
           FROM ARTWORK
           LEFT JOIN SCHOOLSTEMP ON ARTWORK.school_id = SCHOOLSTEMP.locNumber
           LEFT JOIN SUBMISSION ON ARTWORK.artwork_id = SUBMISSION.artwork_id
           LEFT JOIN PIN ON ARTWORK.artwork_id = PIN.artwork_id
           WHERE SCHOOLSTEMP.name LIKE '%#url.search#%'
           OR ARTWORK.artwork_title LIKE '%#url.search#%'
           OR ARTWORK.submission_artist LIKE '%#url.search#%'
           OR SUBMISSION.student_id LIKE '%#url.search#%'
           OR ARTWORK.staff_id LIKE '%#url.search#%'
           OR PIN.tag_id LIKE '%#url.search#%';
        </cfquery>
</cfif>
<!--END-OF-ADVANCED-SEARCH--> 

<script>
              function advancedSearchHide() {
  var advSearch = document.getElementById("advanced-search");
  if (advSearch.style.display === "none") {
    advSearch.style.display = "block";
  } else {
    advSearch.style.display = "none";
  }
}
          </script>
<button type="button" class="btn btn-danger btn-lg btn-block" onClick="advancedSearchHide()">Advanced Search</button>

<!--UNREVIEWED-SUBMISSIONS-HEADER-->
<div id = "unreviewed-submissions" class="container-fluid" >
  <h1 style = "margin-top: .5em; margin-bottom: -.1em;"><cfoutput>#status#</cfoutput> Submissions</h1>
  <!--END-OF-UNREVIEWED-SUBMISSIONS-HEADER--> 
</div>
<div id = "gallery"> 
  <!--CARD-DECK-->
  <div class="card-columns">
    <cfif #search# is "N">
      <cfloop query="qGetArtwork">
        <a href="details-admin.cfm?artworkid=<cfoutput>#qGetArtwork.artwork_id#</cfoutput>">
        <div class="card">
          <div class = "text-center"> <img class="card-img-top" src="<cfoutput>#request.rootURL#</cfoutput>/uploads/<cfoutput>#qGetArtwork.artwork_id#</cfoutput>.jpg" alt="Card image cap"> </div>
          <div class="card-body">
            <h5 class="card-title"><cfoutput>#qGetArtwork.artwork_title#</cfoutput></h5>
            <p class="card-text"><cfoutput>#qGetArtwork.name#</cfoutput></p>
            <p class="card-text">by <cfoutput>#qGetArtwork.submission_artist#</cfoutput> <cfoutput>#qGetArtwork.student_id#</cfoutput> </p>
            <p class="card-text"><cfoutput>#qGetArtwork.tag_id#</cfoutput></p>
          </div>
        </div>
        </a>
      </cfloop>
      <cfelse>
      <cfloop query="qGetSearch">
        <a href="details-admin.cfm?artworkid=<cfoutput>#qGetSearch.artwork_id#</cfoutput>">
        <div class="card">
          <div class = "text-center"> <img class="card-img-top" src="<cfoutput>#request.rootURL#</cfoutput>/uploads/<cfoutput>#qGetSearch.artwork_id#</cfoutput>.jpg" alt="Card image cap"> </div>
          <div class="card-body">
            <h5 class="card-title"><cfoutput>#qGetSearch.artwork_title#</cfoutput></h5>
            <p class="card-text"><cfoutput>#qGetSearch.name#</cfoutput></p>
            <p class="card-text">by <cfoutput>#qGetSearch.submission_artist##qGetArtwork.student_id#</cfoutput></p>
            <p class="card-text"><cfoutput>#qGetSearch.tag_id#</cfoutput></p>
          </div>
        </div>
        </a>
      </cfloop>
    </cfif>
  </div>
  <!--END-OF-CARD-DECK--> 
  
</div>
</div>
<!--END-OF-RIGHT-COL-->

</div>
</form>
</div>
<!--END OF LAYOUT FOR UNEQUAL COLUMN PAGE--> 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) --> 
<script src="../js/jquery-3.4.1.min.js"></script> 

<!-- Include all compiled plugins (below), or include individual files as needed --> 
<script src="../js/popper.min.js"></script> 
<script src="../js/bootstrap-4.4.1.js"></script>
</body>
</html>
