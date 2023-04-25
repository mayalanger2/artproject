<!DOCTYPE html>
<html lang="en">
<!-- InstanceBegin template="/Templates/alt-single-column.dwt" codeOutsideHTMLIsLocked="false" -->
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- InstanceBeginEditable name="doctitle" -->
<title>edit gallery</title>
<!-- InstanceEndEditable -->
<!-- Bootstrap -->
<link href="../css/bootstrap-4.4.1.css" rel="stylesheet">
<link href="../basic.css" rel="stylesheet" type="text/css">
<link href="../back-end.css" rel="stylesheet" type="text/css">
<!-- InstanceBeginEditable name="head" -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<!-- InstanceEndEditable -->
</head>
<body id = "alt-body">
<!-- InstanceBeginEditable name="page-content" -->
<cfparam name="url.gallery" default = "">
<cfset url.gallery = "#url.gallery#">

<!--- SEE IF THERE IS A GALLERY DESIGNATED IN THE URL --->
<cfset madeGallery = "N">
<cfif isDefined("url.gallery") and url.gallery NEQ "">
  <cfset madeGallery = "Y">
  <cfquery name="qGetGallery" datasource="#request.dsn#">
        SELECT tag_id
        FROM GALLERY
        WHERE tag_id  = '#url.gallery#'
        limit 1;
    </cfquery>
  <!--- IF THERE IS ONE, GRAB THE CONTENTS OF IT --->
  <cfif qGetGallery.recordCount GTE 1>
    <cfquery name="qGetGalleryDetails" datasource="gallery">
            SELECT *
            FROM GALLERY
            WHERE tag_id  = '#url.gallery#'
            limit 1;
    </cfquery>
  </cfif>
</cfif>

            
      <!---DELETE BUTTON--->
<cfif isDefined("delete") AND #madeGallery# is "Y">
  <cfquery datasource="gallery">
        DELETE FROM GALLERY WHERE tag_id = '#form.galleryTag#';
    </cfquery>
</cfif>      
            
<!---NEW GALLERY SECTION--->
<cfif (isDefined("form.galleryTitle") AND form.galleryTitle NEQ "") AND (isDefined("form.galleryTag") AND form.galleryTag NEQ "") AND (madeGallery is "N")>
  <cftry>
    <cfset insFront = 0>
    <cfif (isDefined("form.galleryFront"))>
      <cfif #form.galleryFront# is "on">
        <cfquery datasource = "gallery" name = "qFrontPageDeletions">
            UPDATE GALLERY
            SET gallery_front = '0';
        </cfquery>
        <cfset #insFront# = 1>
      </cfif>
    </cfif>
    <cfset insFeatured = 0>
    <cfif (isDefined("form.galleryFeatured"))>
      <cfif #form.galleryFeatured# is "on">
        <cfset #insFeatured# = 1>
      </cfif>
    </cfif>
    <cfquery datasource = "gallery">
        INSERT INTO TAG (tag_id) VALUES ('#form.galleryTag#');
    </cfquery>
    <cfquery datasource = "gallery">
        INSERT INTO GALLERY (tag_id, gallery_title, gallery_description, gallery_featured, gallery_front) VALUES ('#form.galleryTag#', '#form.galleryTitle#', '#form.galleryDescription#', '#insFeatured#', '#insFront#');
    </cfquery>
    <cflocation url="#cgi.script_name#?success=y" addtoken="no">
    <cfcatch type="all">
      <cflocation url="#cgi.script_name#?success=n" addtoken="no">
    </cfcatch>
  </cftry>
</cfif>
<!---END OF NEW GALLERY SECTION--->
<cfif (isDefined("form.galleryTitle") AND form.galleryTitle NEQ "") AND #madeGallery# is "Y">
  <cfquery datasource = "gallery">
        UPDATE GALLERY
        SET gallery_title = '#form.galleryTitle#'
        WHERE tag_id = '#form.galleryTag#';
    </cfquery>
</cfif>
<cfif (isDefined("form.galleryTag") AND form.galleryTag NEQ "") AND #madeGallery# is "Y">
  <cfquery datasource = "gallery">
        UPDATE GALLERY
        SET tag_id = '#form.galleryTag#'
        WHERE tag_id = '#form.galleryTag#';
    </cfquery>
</cfif>
<cfif (isDefined("form.galleryDescription") AND form.galleryDescription NEQ "") AND #madeGallery# is "Y">
  <cfquery datasource = "gallery">
        UPDATE GALLERY
        SET gallery_description = '#form.galleryDescription#'
        WHERE tag_id = '#form.galleryTag#';
    </cfquery>
</cfif>
<cfif (isDefined("form.galleryTag") and form.galleryTag NEQ "") and #madeGallery# is "Y">
  <cfset inFeatured = 0>
  <cfif (isDefined("form.galleryFeatured") AND form.galleryFeatured EQ "on")>
    <cfset #inFeatured# = 1>
  </cfif>
  <cfquery datasource = "gallery">
        UPDATE GALLERY
        SET gallery_featured = '#inFeatured#'
        WHERE tag_id = '#form.galleryTag#';
    </cfquery>
</cfif>
<cfif (isDefined("form.galleryFront") AND form.galleryFront NEQ "")>
  <cfset inFront = 0>
  <cfif #form.galleryFront# EQ "on">
    <cfquery datasource = "gallery" name = "qFrontPageDeletions">
            UPDATE GALLERY
            SET gallery_front = '0';
        </cfquery>
    <cfset #inFront# = 1>
  </cfif>
  <cfquery datasource = "gallery">
        UPDATE GALLERY
        SET gallery_front = '#inFront#'
        WHERE tag_id = '#form.galleryTag#';
    </cfquery>
  <cflocation url="#cgi.script_name#?success=y" addtoken="no">
</cfif>
<cfif isDefined("url.success") and url.success EQ "y">
  <div style="background-color:green;padding:10px;padding-left: 5em;">
    <p style="color:white;">Gallery was modified.</p>
  </div>
  <cfelseif isDefined("url.success") and url.success EQ "n">
  <div style="background-color:red;padding:10px;padding-left: 5em;">
    <p style="color:white;">Gallery was not modified.</p>
  </div>
  <cfelse>
</cfif>
<div id = "folder-body">
  <div class="center-form-folder">
    <div class="container-fluid" id="alt-fluid">
      <form id = "alt-form" action="edit-gallery.cfm?<cfoutput>#cgi.query_string#</cfoutput>" method="post" enctype="multipart/form-data">
        <h1 class = "folder-label">EDIT GALLERY</h1>
        <div class="form-group">
          <label for = "gallery-title">Gallery Title</label>
          <cfif #madeGallery# is "Y">
            <input type="text" class="form-control" id="gallery-title" name = "galleryTitle" value = "<cfoutput query = "qGetGalleryDetails">#gallery_title#"</cfoutput>" required>
            <cfelse>
            <input type="text" class="form-control" id="gallery-title" name = "galleryTitle" value = "Gallery Title" required>
          </cfif>
        </div>
        <div class="form-group">
          <label for="exampleFormControlTextarea1">Gallery Description (255 characters maximum allowed)</label>
          <cfif #madeGallery# is "Y">
            <textarea class="form-control" id="gallery-tags" rows="3" name = "galleryDescription" value = "qGetGalleryDetails.gallery-description" placeholder = "<cfoutput query = "qGetGalleryDetails">#gallery_description#</cfoutput>"></textarea>
            <cfelse>
            <textarea class="form-control" id="gallery-tags" rows="3" name = "galleryDescription" value = "qGetGalleryDetails.gallery-description" placeholder = "Gallery Description"></textarea>
          </cfif>
        </div>
        <div class="form-group">
          <label for="exampleFormControlTextarea1">Tag: ex. 2020Summer</label>
          <cfif #madeGallery# is "Y">
            <input type="text" class="form-control" id="gallery-tag" name = "galleryTag" value = "<cfoutput query = "qGetGalleryDetails">#tag_id#</cfoutput>" required>
            <cfelse>
            <input type="text" class="form-control" id="gallery-tag" name = "galleryTag" value = "Tag Name" required>
          </cfif>
        </div>
        <cfset isFeatured = "0">
        <cfif #madeGallery# is "Y">
          <cfif qGetGalleryDetails.gallery_featured EQ "1">
            <cfset isFeatured = "1">
          </cfif>
        </cfif>
        <cfset isFront = "0">
        <cfif #madeGallery# is "Y">
          <cfif qGetGalleryDetails.gallery_front EQ "1">
            <cfset isFront= "1">
          </cfif>
        </cfif>
        <cfif #isFeatured# is "1">
          <input type="checkbox" name = "galleryFeatured" checked>
          <cfelseif #isFeatured# is "0">
          <input type="checkbox" name = "galleryFeatured">
          <cfelse>
        </cfif>
        <span>Will this Gallery be on the FEATURED Page?</span> <br>
        <cfif #isFront# is "1">
          <input type="checkbox" name = "galleryFront" checked>
          <cfelseif #isFront# is "0">
          <input type="checkbox" name = "galleryFront">
          <cfelse>
        </cfif>
        <span>Will this Gallery be on the FRONT Page?</span> <br>
        <cfif #madeGallery# is "Y">
          <div class="row">
          <cfquery name="qGetImages" datasource="gallery">
            SELECT *
            FROM PIN
            WHERE tag_id  = '#url.gallery#'
            LIMIT 3
            </cfquery>
          <cfset imageClassCounter = 1>
          <cfloop query="qGetImages">
            <div class="col-4">
                <img class = "edit-gallery-img<cfoutput>#imageClassCounter#</cfoutput>" src="<cfoutput>#request.rootURL#</cfoutput>/uploads/<cfoutput>#qGetImages.artwork_id#</cfoutput>.jpg">
              </div>
            <cfset imageClassCounter = imageClassCounter + 1>
          </cfloop>
        </cfif>
        <button type="submit" class="btn btn-primary" id = "confirm-btn">Confirm</button>
              
        <cfif #madeGallery# is "Y">
        <button type="button" class="btn btn-danger" id = "delete-btn" data-toggle="modal" data-target="#exampleModal">Delete</button>
        </cfif>
        
        <a href ="../manage-galleries.cfm" role="button" class="btn btn-secondary" id= "cancel-btn">Cancel</a>
              
              
            
            
              
              
              
              
      </form>
    </div>
  </div>
</div>
          
            

            <div class="modal fade" id="exampleModal" tabindex = "-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
                              <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Delete Gallery</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <div class="modal-body">
                Are you sure you want to delete this gallery?
              </div>
              <div class="modal-footer">
                <form action="edit-gallery.cfm?<cfoutput>#cgi.query_string#</cfoutput>" method="post">
                    <input type="hidden" class="form-control" name = "galleryTag" value = "<cfoutput query = "qGetGalleryDetails">#tag_id#</cfoutput>">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-danger" name = "delete">Delete Gallery</button>
                </form>
              </div>
            </div>
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
