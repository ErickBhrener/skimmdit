<!DOCTYPE html>
<html>
    <head>
        <title>Skimmdit</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    </head>
    <body>
        
        <div>
        	
	        <h2>Create a Post</h2>
	        <a href="<c:url value="/login?logout" />">Logout</a>
	        <br/>
	        <div class="row">
	        <div class="col-md-6" style="width:30%">
	        <div class = "panel panel-info"><div class="panel-heading"></div>
	        <div class="panel-body">
	        <form method="POST" action="main" class="form-horizontal">
	            <input type="hidden" name="actionPost" value="create"/>
	            <label class="control-label" style ="background-color:none;">Title: </label>
	            <input type="text" name="title" class="form-control">
	            <label class="control-label" style ="background-color:none;">Link Adress: </label>
	            <input name="link" type="text" class="form-control" /><br/>
	            <input type="submit" value="Submit" class="btn btn-default"/>
	        </form>
	        </div>
	        </div>
	        </div>
	        </div>
        </div>
    </body>
</html>

