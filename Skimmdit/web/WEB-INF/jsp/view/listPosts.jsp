<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Comparator"%>
<%@page import="java.util.Collections"%>
<%@ page import="java.util.Map" %>
<%@ page import="com.fullerton.Post" %>
<%
	@SuppressWarnings("unchecked")
    Map<Integer, Post> postDatabase =
            (Map<Integer, Post>)request.getAttribute("postDatabase");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Skimmdit</title>
    </head>
    <body>
        <h2>Skimmdit</h2>
        <a href="<c:url value="/main"><c:param name="action" value="create" /></c:url>" >Create Post</a><br /><br />
	<%
            if(postDatabase.size() == 0)
            {
                %><i>There are no posts in the system.</i>
	<%
            }
            else
            {
                for(int id : postDatabase.keySet())
                {
                    String idString = Integer.toString(id);
                    Post post = postDatabase.get(id);
                    %><div> <span style = "float: left;margin-top: 15px;color: #c6c6c6;font-family: arial;font-size: medium;text-align: right;"><%= idString %></span>
	<div style="float: left;margin-right: 7px;margin-left: 7px;background: transparent;overflow: hidden;">
	<div style="margin: 2px 0px 0px 0px;
width: 100%;
height: 14px;
display: block;
cursor: pointer;
background-position: center center;
background-repeat: no-repeat;
width: 15px;
margin-left: auto;
margin-right: auto;
outline: none;"><a
		href="<c:url value="/main">
                        <c:param name="action" value="voteUp" />
                        <c:param name="postId" value="<%= idString %>" />
                    </c:url>"></div><img
		src="https://raw.githubusercontent.com/iconic/open-iconic/master/png/arrow-top-2x.png"></a>
	<div style =  "text-align: center;
color: #c6c6c6;"><%= post.getVotes() %></div>
	<div style="margin: 2px 0px 0px 0px;
width: 100%;
height: 14px;
display: block;
cursor: pointer;
background-position: center center;
background-repeat: no-repeat;
width: 15px;
margin-left: auto;
margin-right: auto;
outline: none;"><a
		href="<c:url value="/main">
                        <c:param name="action" value="voteDown" />
                        <c:param name="postId" value="<%= idString %>" />
                    </c:url>"><img
		src="https://raw.githubusercontent.com/iconic/open-iconic/master/png/arrow-bottom-2x.png">
	</a></div></div>
	<div style ="overflow: hidden;
margin-left: 3px;
opacity: 1;">
		<p style= "font-size: medium;font-weight: normal;margin-bottom: 1px; font-style:sans-serif;">
		<a href=" <%= post.getLink() %>" target="_blank"><%= post.getTitle() %></a>
		</p>
		<p style="color: #888;
font-size: small">(user:
		<%= post.getName() %>)
		</p>
	</div>
	</div>
	<%
                }
            }
        %>
</body>
</html>