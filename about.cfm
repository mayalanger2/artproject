<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>about</title>
<!-- Bootstrap -->
<link href="css/bootstrap-4.4.1.css" rel="stylesheet">
<link href="basic.css" rel="stylesheet" type="text/css">
<link href="front-end.css" rel="stylesheet" type="text/css">
</head>

<body>
<!--HEADER FOR SINGLE COLUMN PAGE--->
<div id = "head" class="col-lg-12">
  <header>
    <nav class="navbar"> <a class="navbar-brand" href="https://www.lps.org/"> <img src="resources/Small%20LPS%20Logo.png" width = "39" height = "30" class="d-inline-block align-top" alt=""> LPS Gallery </a>
      
        
  
      <!--CONIDITIONAL START--> 
  
      <cfif cgi.script_name contains "index.cfm">
      <!--SEARCH--> 
        <form class="form-inline my-2 my-lg-0" method="post" enctype="multipart/form-data">
          <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
          <button class="btn btn-light my-2 my-sm-0" id = "submit-btn" type="submit" name = "search-bar">Search</button>
        </form>
        <cfelse>
      <!--NON SEARCH--> 
        <a type="button" href = "index.cfm" class="btn btn-outline-light" id = "back-btn">BACK TO GALLERY</a>
      </cfif>
    
      <!---END OF CONIDITIONAL---> 
      
    </nav>
  </header>
</div>
<!--END OF HEADER FOR SINGLE COLUMN PAGE--> 

<!--START OF SINGLE COLUMN CONTENT--->
<div id="content-single" class="col-lg-12"> <!--START OF JUMBOTRON-->
  <div class="jumbotron jumbotron-fluid mb-0" id ="about-jumbo">
    <div class="container">
      <h1 class="display-4" id = "jumbo-head">Lincoln Public Schools Art Gallery</h1>
      <p class="lead" id = "jumbo-description">Description of gallery goes here.</p>
    </div>
  </div>
  <!--END OF JUMBOTRON--> 
  
  <!--START OF DESCRIPTION-->
  <div id="description-about">
    <h2 class = "description-text-header">Mission Statement</h2>
    <p class = "description-text"> The LPS Visual Art Department provides instruction in the discipline of aesthetics, and in the production, criticism and history of art.
      
      By studying and practicing art, students develop visual perception, problem-solving skills, and an appreciation of a diverse aesthetic heritage. It is part of our purpose to communicate to students and to the community the significance of the Visual Arts as a most important form of communication about the human condition, and a vital visual literacy component of a comprehensive education. </p>
  </div>
  <!--END OF DESCRIPTION--> 
  
  <!--START OF PICTURES-->
  <div class="row" id= "pic-about">
 
    <div class="col-lg-4"><div id = "pic1-about"></div></div>
    <div class="col-lg-4"><div id = "pic2-about"></div></div>
    <div class="col-lg-4"><div id = "pic3-about"></div></div>
      
  </div>

  <!--END OF PICTURES--> 
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
