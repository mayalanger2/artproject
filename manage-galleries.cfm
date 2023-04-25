<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>manage-galleries</title>

<!-- Bootstrap -->
<link href="css/bootstrap-4.4.1.css" rel="stylesheet">
<link href="basic.css" rel="stylesheet" type="text/css">
<link href="back-end.css" rel="stylesheet" type="text/css">
<link href="basic.css" rel="stylesheet" type="text/css">
</head>
<body>

<!--HEADER FOR MANAGE SINGLE COLUMN PAGE--->
<div id = "head" class="col-lg-12">
  <header>
    <nav class="navbar">
      <a class="btn btn-outline-light" href = "admin/index-admin.cfm" id = "back-btn">BACK TO GALLERY</a>
    </nav>
  </header>
</div>
<!--END OF HEADER FOR MANAGE SINGLE COLUMN COLUMN PAGE--> 
<!---TOGGLE BUTTON--->

<div class="container-fluid" id = "manage-choice">
  <h1 id = "manage-label" class = "d-flex justify-content-center">Select Galleries to Manage</h1>
</div>

<!-------END OF HEADER-------------------------->
<nav>
  <div class="nav nav-tabs " id="nav-tab" role="tablist"> <a class="nav-item nav-link active" id="nav-all-tab" data-toggle="tab" href="#nav-all" role="tab" aria-controls="nav-all" aria-selected="true">All Galleries</a> <a class="nav-item nav-link" id="nav-featured-tab" data-toggle="tab" href="#nav-featured" role="tab" aria-controls="nav-featured" aria-selected="false">Featured Galleries</a> <a class="nav-item nav-link" id="nav-front-tab" data-toggle="tab" href="#nav-front" role="tab" aria-controls="nav-front" aria-selected="false">Front Page</a> </div>
</nav>
<div class="tab-content" id="nav-tabContent">
<div class="tab-pane fade show active" id="nav-all" role="tabpanel" aria-labelledby="nav-all-tab">
  <cfquery name="qGetAllGalleries" datasource="gallery">
    SELECT tag_id
    FROM GALLERY
</cfquery>
  <cfloop query= #qGetAllGalleries#>
    <cfquery name="qGetGalleryDetails" datasource="gallery">
        SELECT *
        FROM GALLERY
        WHERE tag_id  = '#qGetAllGalleries.tag_id#'
    </cfquery>
    <cfquery name="qGetImages" datasource="gallery">
        SELECT *
        FROM PIN
        JOIN ARTWORK ON PIN.artwork_id = ARTWORK.artwork_id
        WHERE tag_id  = '#qGetAllGalleries.tag_id#'
        AND ARTWORK.artwork_approval = 'approved'
        LIMIT 3;
    </cfquery>
    <a href="admin/edit-gallery.cfm?gallery=<cfoutput>#qGetAllGalleries.tag_id#</cfoutput>">
    <div class="gallery-card col-md-12">
      <div class="gallery-card-body">
        <cfset imageClassCounter = 1>
        <cfloop query="qGetImages">
          <img class="gallery-img-<cfoutput>#imageClassCounter#</cfoutput>" src="uploads/<cfoutput>#qGetImages.artwork_id#</cfoutput>.jpg" alt="Card image cap">
          <cfset imageClassCounter = imageClassCounter + 1>
        </cfloop>
            
          
        <div class = "gallery-card-text">
          <h5 class="gallery-card-title"><cfoutput>#qGetGalleryDetails.gallery_title#</cfoutput></h5>
          <p class="gallery-tag"><cfoutput>#qGetGalleryDetails.tag_id#</cfoutput></p>
        </div>
      </div>
    </div>
    </a>
  </cfloop>
  <div class="gallery-card-new col-md-12"> <a href="admin/edit-gallery.cfm?gallery=">
    <div class="gallery-card-body"> <img class="new-gallery"src="resources/new-gallery.png" alt="Card image cap">
      <div class = "gallery-card-text" id = "new-text">
        <h5 class="gallery-card-title" >New Gallery</h5>
        <p class="gallery-tag">Tag Goes Here.</p>
      </div>
    </div>
    </a> </div>
</div>
<!-------------------------->
<div class="tab-pane fade" id="nav-featured" role="tabpanel" aria-labelledby="nav-featured-tab">
  <cfquery name="qGetFeaturedGalleries" datasource="gallery">
    SELECT tag_id
    FROM GALLERY
    WHERE gallery_featured = '1'
</cfquery>
  <cfloop query= #qGetFeaturedGalleries#>
    <cfquery name="qGetGalleryDetails" datasource="gallery">
        SELECT *
        FROM GALLERY
        WHERE tag_id  = '#qGetFeaturedGalleries.tag_id#'
    </cfquery>
    <cfquery name="qGetImages" datasource="gallery">
        SELECT *
        FROM PIN
        WHERE tag_id  = '#qGetFeaturedGalleries.tag_id#'
        LIMIT 3
    </cfquery>
    <a href="admin/edit-gallery.cfm?gallery=<cfoutput>#qGetFeaturedGalleries.tag_id#</cfoutput>">
    <div class="gallery-card col-md-12">
      <div class="gallery-card-body">
        <cfset imageClassCounter = 1>
        <cfloop query="qGetImages">
          <img class="gallery-img-<cfoutput>#imageClassCounter#</cfoutput>" src="uploads/<cfoutput>#qGetImages.artwork_id#</cfoutput>.jpg" alt="Card image cap">
          <cfset imageClassCounter = imageClassCounter + 1>
        </cfloop>
        <div class = "gallery-card-text">
          <h5 class="gallery-card-title" style= ""><cfoutput>#qGetGalleryDetails.gallery_title#</cfoutput></h5>
          <p class="gallery-tag"><cfoutput>#qGetGalleryDetails.tag_id#</cfoutput></p>
        </div>
      </div>
    </div>
    </a>
  </cfloop>
  <div class="gallery-card-new col-md-12"> <a href="admin/edit-gallery.cfm?gallery=">
    <div class="gallery-card-body"> <img class="new-gallery" src="resources/new-gallery.png" alt="Card image cap">
      <div class = "gallery-card-text" id = "new-text">
        <h5 class="gallery-card-title" >New Gallery</h5>
        <p class="gallery-tag">Tag Goes Here.</p>
      </div>
    </div>
    </a> </div>
  
  <!--------------------------> 
</div>
<div class="tab-pane fade" id="nav-front" role="tabpanel" aria-labelledby="nav-front-tab">
  <cfquery name = "qGetFrontGallery" datasource = "gallery">
    SELECT tag_id
    FROM GALLERY
    WHERE gallery_front = '1'
    LIMIT 1;
</cfquery>
  <cfquery name="qGetGalleryDetails" datasource="gallery">
        SELECT *
        FROM GALLERY
        WHERE tag_id  = '#qGetFrontGallery.tag_id#'
    </cfquery>
  <cfquery name="qGetImages" datasource="gallery">
        SELECT *
        FROM PIN
        WHERE tag_id  = '#qGetFrontGallery.tag_id#'
        LIMIT 3
    </cfquery>
  <a href="admin/edit-gallery.cfm?gallery=<cfoutput>#qGetFrontGallery.tag_id#</cfoutput>">
  <div class="gallery-card col-md-12">
    <div class="gallery-card-body">
      <cfset imageClassCounter = 1>
      <cfloop query="qGetImages">
        <img class="gallery-img-<cfoutput>#imageClassCounter#</cfoutput>" src="uploads/<cfoutput>#qGetImages.artwork_id#</cfoutput>.jpg" alt="Card image cap">
        <cfset imageClassCounter = imageClassCounter + 1>
      </cfloop>
      <div class = "gallery-card-text">
        <h5 class="gallery-card-title"><cfoutput>#qGetGalleryDetails.gallery_title#</cfoutput></h5>
        <p class="gallery-tag"><cfoutput>#qGetGalleryDetails.tag_id#</cfoutput></p>
      </div>
    </div>
  </div>
  </a> </div>
 
</div>
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) --> 
<script src="js/jquery-3.4.1.min.js"></script> 

<!-- Include all compiled plugins (below), or include individual files as needed --> 
<script src="js/popper.min.js"></script> 
<script src="js/bootstrap-4.4.1.js"></script>
</body>
</html>
