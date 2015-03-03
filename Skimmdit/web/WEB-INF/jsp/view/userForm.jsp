<!DOCTYPE html>
<html>
    <head>
        <title>Customer Support</title>
    </head>
    <body>
        <h2>New User</h2>
        <form method="POST" action="login">
<%--         <% request.getSession().setAttribute("action", "create"); %> --%>
            <input type="hidden" name="action" value="create"/>
            Name<br/>
            <input type="text" name="name"><br/><br/>
            Password<br/>
            <input type="text" name="pswd"><br/><br/>
            <input type="submit" value="Submit"/>
        </form>
    </body>
</html>
