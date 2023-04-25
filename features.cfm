<!DOCTYPE html>
<html lang="en">
<!-- InstanceBegin template="/Templates/unequal-column.dwt" codeOutsideHTMLIsLocked="false" -->
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- InstanceBeginEditable name="doctitle" -->
<title>features</title>
<!-- InstanceEndEditable -->
<!-- Bootstrap -->
<link href="css/bootstrap-4.4.1.css" rel="stylesheet">
<link href="basic.css" rel="stylesheet" type="text/css">
<!-- InstanceBeginEditable name="head" -->
<link href="front-end.css" rel="stylesheet" type="text/css">
<!-- InstanceEndEditable -->
</head>
<body>

<!--HEADER FOR DOUBLE COLUMN PAGE--->
<div id = "head" class="col-lg-12">
  <header>
    <nav class="navbar"> <a class="navbar-brand" href="https://www.lps.org/"> <img src="resources/Small%20LPS%20Logo.png" width = "39" height = "30" class="d-inline-block align-top" alt=""> LPS Gallery </a> <a class="btn btn-outline-light" role="button" href = "index.cfm" id = "back-btn">BACK TO GALLERY</a> </nav>
  </header>
</div>
<!--END OF HEADER FOR DOUBLE COLUMN PAGE--> 

<!--LAYOUT FOR UNEQUAL COLUMN PAGE-->
<div id = "unequal-col" class="container-fluid">
  <div class="row"> 
    <!--FULL-COLUMN-->
    <div id = "full-col" class = "col-lg-12"> <!-- InstanceBeginEditable name="page-content" -->
      <h1 class = "title">Features</h1>
      <!-- InstanceEndEditable --> </div>
    <!--END-OF-FULL-COLUMN--> 
    <!--LEFT-COLUMN-->
    <div id = "left-col-small" class="col-lg-4"> <!-- InstanceBeginEditable name="page-left" -->
      <div class = "drip-dec">
        <div id = "pic-featured"></div>
        <h3 class = "featured-title">Featured Pages</h3>
        <p class = "featured-description">The previous galleries featured for Lincoln Public Schools.</p>
      </div>
      <!-- InstanceEndEditable --> </div>
    <!--END-OF-LEFT-COL--> 
    
    <!--RIGHT-COLUMN-->
    <div id = "right-col-large" class="col-lg-8"> <!-- InstanceBeginEditable name="page-right" -->
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
        JOIN ARTWORK ON PIN.artwork_id = ARTWORK.artwork_id
        WHERE tag_id  = '#qGetFeaturedGalleries.tag_id#'
        AND ARTWORK.artwork_approval = 'approved'
        LIMIT 3;
    </cfquery>
        <a href="index.cfm?gallery=<cfoutput>#qGetFeaturedGalleries.tag_id#</cfoutput>" style = "color: black;">
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
      <!-- InstanceEndEditable --> </div>
    <!--END-OF-RIGHT-COL--> 
    
  </div>
</div>
<!--END OF LAYOUT FOR UNEQUAL COLUMN PAGE--> 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) --> 
<script src="js/jquery-3.4.1.min.js"></script> 

<!-- Include all compiled plugins (below), or include individual files as needed --> 
<script src="js/popper.min.js"></script> 
<script src="js/bootstrap-4.4.1.js"></script>
</body>
<!-- InstanceEnd -->
</html>
