<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>index</title>
<!-- Bootstrap --> 
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script> 
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<link href="css/bootstrap-4.4.1.css" rel="stylesheet">
<link href="basic.css" rel="stylesheet" type="text/css">
<link href="front-end.css" rel="stylesheet" type="text/css">
</head>

<body style = "background-color: black;">
<!--HEADER FOR SINGLE COLUMN PAGE--->
<div id = "head" class="col-lg-12">
  <header>
    <nav class="navbar"> <a class="navbar-brand" href="https://www.lps.org/"> <img src="resources/Small%20LPS%20Logo.png" width = "39" height = "30" class="d-inline-block align-top" alt=""> LPS Gallery </a>
      <cfparam name="url.gallery" default = "">
      <cfset url.gallery = "#url.gallery#">
      <cfset featuredGallery = "N">
      <cfif isDefined("url.gallery") and url.gallery NEQ "">
        <cfset featuredGallery = "Y">
        <cfquery name = "qGetFeaturedGallery" datasource = "gallery">
        SELECT *
        FROM PIN 
        JOIN GALLERY ON PIN.tag_id = GALLERY.tag_id
        JOIN ARTWORK ON PIN.artwork_id = ARTWORK.artwork_id
        WHERE PIN.tag_id = '#url.gallery#'
        AND ARTWORK.artwork_approval = 'approved';
    </cfquery>
      </cfif>
      <cfset search = "N">
      <cfif isDefined("url.search") AND url.search NEQ "">
        <cfset #search# = "Y">
        <cfquery name = "qGetSearch" datasource="gallery">
           SELECT ARTWORK.artwork_id
           FROM ARTWORK
           LEFT JOIN SCHOOLSTEMP ON ARTWORK.school_id = SCHOOLSTEMP.locNumber
           LEFT JOIN SUBMISSION ON ARTWORK.artwork_id = SUBMISSION.artwork_id
           WHERE SCHOOLSTEMP.name LIKE '%#url.search#%'
           OR ARTWORK.artwork_title LIKE '%#url.search#%'
           OR ARTWORK.submission_artist LIKE '%#url.search#%'
           OR SUBMISSION.student_id LIKE '%#url.search#%'
           AND ARTWORK.artwork_approval = 'approved';
        </cfquery>
        <cfelse>
        <cfquery name = "qGetFrontGallery" datasource = "gallery">
            SELECT *
             FROM PIN 
        JOIN GALLERY ON PIN.tag_id = GALLERY.tag_id
        JOIN ARTWORK ON PIN.artwork_id = ARTWORK.artwork_id
            WHERE gallery_front = '1'
            AND ARTWORK.artwork_approval = 'approved'
            LIMIT 1;
            </cfquery>
        <cfquery name="qGetSearch" datasource="gallery">
                SELECT ARTWORK.artwork_id
                FROM PIN
                JOIN ARTWORK ON PIN.artwork_id = ARTWORK.artwork_id
                WHERE PIN.tag_id  = '#qGetFrontGallery.tag_id#'
                AND ARTWORK.artwork_approval = 'approved';
            </cfquery>
      </cfif>
      
      <!--CONIDITIONAL START-->
      
      <cfif cgi.script_name contains "index.cfm">
        <!--SEARCH-->
        
        <form class="form-inline my-2 my-lg-0" action="index.cfm" method="get">
          <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search" name = "search">
          <button class="btn btn-light my-2 my-sm-0" id = "submit-btn" type="submit"data-container="body" data-toggle="popover" data-placement="bottom" data-content="You can search by Student ID, School, or Artwork Title!">Search</button>
        </form>
        <cfelse>
        <!--NON SEARCH-->
        <button type="button" href = "index.cfm" class="btn btn-outline-light" id = "back-btn">BACK TO GALLERY</button>
      </cfif>
      
      <!---END OF CONIDITIONAL---> 
      
    </nav>
  </header>
</div>
<!--END OF HEADER FOR SINGLE COLUMN PAGE--> 

<!--START OF SINGLE COLUMN CONTENT--->
<div id="content-single" class="container-fluid">
<!--NAVBAR--> 

<!--END-OF-NAVBAR--> 
<!--CAROUSEL-->

<cfif #search# is "N">
  <div id="carousel-slides" class="carousel slide" data-ride="carousel">
    <div class="carousel-inner">
      <div class="carousel-item active">
        <div class="carousel-content">
          <h1><cfoutput>
              <cfif #featuredGallery# is "Y">
                #qGetFeaturedGallery.gallery_title#
                <cfelse>
                #qGetFrontGallery.gallery_title#
              </cfif>
            </cfoutput> </h1>
        </div>
        <div class="carousel-content-2">
          <h3><cfoutput>
              <cfif #featuredGallery# is "Y">
                #qGetFeaturedGallery.gallery_description#
                <cfelse>
                #qGetFrontGallery.gallery_description#
              </cfif>
            </cfoutput></h3>
        </div>
        <cfset currTag = '#qGetFrontGallery.tag_id#'>
        <cfif #featuredGallery# is "Y">
          <cfset currTag = '#qGetFeaturedGallery.tag_id#'>
        </cfif>
        <cfquery name = "qGetFrontSlides" datasource="gallery">
            SELECT ARTWORK.artwork_id
            FROM ARTWORK
            JOIN PIN ON ARTWORK.artwork_id = PIN.artwork_id
            WHERE ARTWORK.artwork_slides = '1'
            AND PIN.tag_id = '#currTag#';
        </cfquery>
        <cfquery name = "qGetSlidesNone" datasource="gallery">
            SELECT ARTWORK.artwork_id
            FROM ARTWORK
            JOIN PIN ON ARTWORK.artwork_id = PIN.artwork_id
            WHERE PIN.tag_id = '#currTag#'
            AND ARTWORK.artwork_approval = 'approved';
      </cfquery>
        <cfif qGetFrontSlides.RecordCount>
          <img class="d-block w-100" src="<cfoutput>#request.rootURL#</cfoutput>/uploads/<cfoutput>#qGetFrontSlides.artwork_id#</cfoutput>.jpg" alt="First slide">
          <cfelse>
          <img class="d-block w-100" src="<cfoutput>#request.rootURL#</cfoutput>/uploads/<cfoutput>#qGetSlidesNone.artwork_id#</cfoutput>.jpg" alt="First slide">
        </cfif>
      </div>
      <cfloop query="qGetFrontSlides">
        <div class = "carousel-item"> <img class="d-block w-100" src="<cfoutput>#request.rootURL#</cfoutput>/uploads/<cfoutput>#qGetFrontSlides.artwork_id#</cfoutput>.jpg"> </div>
      </cfloop>
    </div>
  </div>
  </div>
</cfif>
<!--END-OF-CAROUSEL-->
<nav class="navbar navbar-dark navbar-expand-lg" id = "index-nav" style="background-color: #151515;">
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation"> <span class="navbar-toggler-icon"></span> </button>
  <div class="collapse navbar-collapse" id="navbarNavDropdown">
    <ul class="navbar-nav">
      <li class="nav-item active"> <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a> </li>
      <li class="nav-item"> <a class="nav-link" href="features.cfm">Featured Galleries</a> </li>
      <li class="nav-item"> <a class="nav-link" href="about.cfm">About</a> </li>
      <li class="nav-item"> <a class="nav-link" href="https://home.lps.org/art/">Curriculum</a> </li>
    </ul>
  </div>
</nav>

<!--GALLERY-ART--> 
<script>// init Masonry
var $grid = $('.grid').masonry({
  itemSelector: '.grid-item',
  percentPosition: true,
  columnWidth: '.grid-sizer'
});

// layout Masonry after each image loads
$grid.imagesLoaded().progress( function() {
  $grid.masonry();
});</script>
<div class="grid">
  <div class="grid-sizer"></div>
  <cfif #featuredGallery# is "N">
    <cfloop query="qGetSearch">
      <div class="grid-item"> <a href="details.cfm?artworkid=<cfoutput>#qGetSearch.artwork_id#</cfoutput>"> <img class = "front-img" src="<cfoutput>#request.rootURL#</cfoutput>/uploads/<cfoutput>#qGetSearch.artwork_id#</cfoutput>.jpg"> </a> </div>
    </cfloop>
    <cfelse>
    <cfloop query="qGetFeaturedGallery">
      <div class="grid-item"> <a href="details.cfm?artworkid=<cfoutput>#qGetFeaturedGallery.artwork_id#</cfoutput>"> <img class = "front-img" src="<cfoutput>#request.rootURL#</cfoutput>/uploads/<cfoutput>#qGetFeaturedGallery.artwork_id#</cfoutput>.jpg"> </a> </div>
    </cfloop>
  </cfif>
</div>
<!--END-OF-GALLERY-ART-->
</div>
<!--END OF SINGLE COLUMN CONTENT---> 

<!--FOOTER-->
<div id="footer-single" class="col-lg-12">
  <footer>
    <div id= "footer-black"> <img id="footer-logo" src= "resources/Full%20LPS%20Logo.png"> <small id="footer-text">Learn more about Art Education at Lincoln Public Schools</small> </div>
  </footer>
</div>
<!--END OF FOOTER--> 

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) --> 
<script src="file:///Macintosh HD/Users/mlanger2/Desktop/js/jquery-3.4.1.min.js"></script> 

<!-- Include all compiled plugins (below), or include individual files as needed --> 
<script src="file:///Macintosh HD/Users/mlanger2/Desktop/js/popper.min.js"></script> 
<script src="file:///Macintosh HD/Users/mlanger2/Desktop/js/bootstrap-4.4.1.js"></script>
</body>
</html>
