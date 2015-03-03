<!DOCTYPE html>
<html>
    <head>
        <title>Skimmdit</title>
    </head>
    <body>
        <a href="<c:url value="/login?logout" />">Logout</a>
        <h2>Create a Post</h2>
        <form method="POST" action="main">
            <input type="hidden" name="actionPost" value="create"/>
            Title<br/>
            <input type="text" name="title"><br/><br/>
            Link<br/>
            <input name="link" type="text"/><br/><br/>
            <input type="submit" value="Submit"/>
        </form>
    </body>
</html>

