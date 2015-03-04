<!DOCTYPE html>
<html>
    <head>
        <title>Skimmdit</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    </head>
    <body>
    <div id="header">
			<h2>Skimmdit</h2>
	</div>
	<div>
		<%
			if (request.getAttribute("createFailed") != null) {
		%>
		<div class="alert alert-danger">
			<b>The username already exists. Please try again.</b>
		</div>
		<%	
			request.setAttribute("createFailed", null);
			}
		%>
		<h2>Create a New User</h2>
		<div class="row">
			<div class="col-md-6" style="width: 30%">
				<div class="panel panel-info">
					<div class="panel-heading"></div>
					<div class="panel-body">
						<form method="POST" action="login" class="form-horizontal">
							<input type="hidden" name="action" value="create" /> 
							<h4><label class="control-label" style ="background-color:none;">Name: </label></h4> 
							<input type="text" name="name" class="form-control">
							<h4><label class="control-label" style ="background-color:none;">Password: </label></h4> 
							<input type="password" name="pswd" class="form-control">
							<input class="btn btn-default" type="submit" value="Submit" />

						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
