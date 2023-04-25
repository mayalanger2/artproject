<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap - Prebuilt Layout</title>

    <!-- Bootstrap -->
    <link href="css/bootstrap-4.4.1.css" rel="stylesheet">
    <link href="basic.css" rel="stylesheet" type="text/css">
    <link href="back-end.css" rel="stylesheet" type="text/css">
  </head>
  <body>
    

      <div class="form-group">
          <input type="text" class="form-control" id="title" placeholder="title here" required>
     </div>
 
      <cfquery datasource="gallery" name="qAddTitle">
            INSERT INTO TESTING (title)
          VALUES ('#titleMine#');
      </cfquery>
      
      
      
<!---
      <cfset artworkTitle = "coldtest">
        <cfset submissionArtist = "me">
            <cfset staffID = "dtuttle">
                <cfset schoolID = '303'>
          
 --->     
      <!--
        <cfquery datasource="gallery" name="qAddArtwork">
      
       INSERT INTO ARTWORK (artwork_id, artwork_title, submission_artist, staff_id, school_id)
    VALUES
	(UUID(), '#artworkTitle#' , '#submissionArtist#', '#staffID#', '#schoolID#');
      </cfquery>

   
    -->
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) --> 
    <script src="js/jquery-3.4.1.min.js"></script>

    <!-- Include all compiled plugins (below), or include individual files as needed --> 
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap-4.4.1.js"></script>
  </body>
</html>
