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
        <style type="text/css">
        	#header {
				border-bottom: 1px solid #5f99cf;position: relative;background-color: #cee3f8;z-index: 99;
			}
        	.index{
        		float: left;margin-top: 15px;color: #c6c6c6;font-family: arial;font-size: medium;text-align: right;
        	}
        	.div_votes{
        		float: left;margin-right: 7px;margin-left: 7px;background: transparent;overflow: hidden;
        	}
        	.arrow_up{
        		margin: 2px 0px 0px 0px;width: 100%;display: block;cursor: pointer;background-position: center center;background-repeat: no-repeat;
        		margin-left: auto;margin-right: auto;outline: none;
          	}
          	.arrow_down{
          		margin: 2px 0px 0px 0px;width: 100%;display: block;cursor: pointer;background-position: center center;background-repeat: no-repeat;
				margin-left: auto;margin-right: auto;outline: none;
          	}
          	a{ 
				text-decoration: none; 
			} 
			a:hover{ 
				text-decoration: underline; 
			} 
			a:visited{ text-decoration: none; 
				color: blue; 
			} 
			a:active{ /* For links that you are clicking on */ 
				text-decoration: none; 
				color: blue; 
			}
        </style>
    </head>
	<body>
		<div id="header">
			<h2>Skimmdit</h2>
		</div>
		
		<a style = "font-family: "Times New Roman", Times, serif; font-size: large;"
		href="<c:url value="/main"><c:param name="action" value="create" /></c:url>">Create Post</a>
		<br />
		<br />
		<%
			if (postDatabase.size() == 0) {
		%><i>There are no posts in the system.</i>
		<%
			} else {
				for (int id : postDatabase.keySet()) {
					String idString = Integer.toString(id);
					Post post = postDatabase.get(id);
		%><div>
			<span class="index"><%=idString%></span>
			<div class="div_votes">
				<div class="arrow_up">
					<a
						href="<c:url value="/main">
	                        <c:param name="action" value="voteUp" />
	                        <c:param name="postId" value="<%=idString%>" />
	                    </c:url>"><img
						src="https://raw.githubusercontent.com/iconic/open-iconic/master/png/arrow-top-2x.png"></a>
				</div>
				<div style="text-align: center; color: #c6c6c6;"><%=post.getVotes()%></div>
				<div class="arrow_down">
					<a
						href="<c:url value="/main">
	                        <c:param name="action" value="voteDown" />
	                        <c:param name="postId" value="<%=idString%>" />
	                    </c:url>"><img
						src="https://raw.githubusercontent.com/iconic/open-iconic/master/png/arrow-bottom-2x.png">
					</a>
				</div>
			</div>
			<div style="overflow: hidden; margin-left: 3px; opacity: 1;">
				<p style="font-family: Arial, Helvetica, sans-serif; font-size: large;">
					<a href=" <%=post.getLink()%>" target="_blank"><%=post.getTitle()%></a>
				</p>
				<p style="color: #888; font-size: small">
					(user:
					<%=post.getName()%>)
				</p>
			</div>
		</div>
		<%
	                }
	            }
	        %>
	</body>
</html>