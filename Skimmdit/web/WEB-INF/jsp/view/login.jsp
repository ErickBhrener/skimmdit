<!DOCTYPE html>
<html>
    <head>
        <title>Skimmdit</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
		<style type="text/css">
        	#header {
				border-bottom: 1px solid #5f99cf;position: relative;background-color: #cee3f8;z-index: 99;
			}
		</style>
    </head>
    <body style="background-color: #eee;">
    	<div id="header">
			<h2>Skimmdit</h2>
		</div>
    	<div class = "container">
	        <%
	            if(((Boolean)request.getAttribute("loginFailed")))
	            {
	                %>
	        <div class="alert alert-danger">
	        <b>The username or password you entered are not correct. Please try
	            again.</b>
	        </div><br /><br />
	                <%
	            }
	        %>
	        <form method="POST" style = "max-width: 330px; padding: 15px;margin: 0 auto;" class="form-signin" action="<c:url value="/login" />">
	        	<h2 class="form-signin-heading">Login</h2>
	            <h3><label class="control-label" style ="background-color:none;">Username</label></h3>
	            <input id= "inputEmail" class = "form-control" type="text" name="username" />
	            <h3><label class="control-label" style ="background-color:none;">Password</label></h3>
	            <input id= "inputPassword" class = "form-control" type="password" name="password" /><br/>
	            <input class="btn btn-lg btn-primary btn-block" type="submit" value="Log In" />
	            <p><a class="btn btn-lg btn-link" href="<c:url value="/login?userform" />">Create New User</a></p>
	        </form>
        </div>
    </body>
</html>
