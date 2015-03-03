package com.fullerton;

import java.io.IOException;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(
		name = "postServlet",
        urlPatterns = "/main")
public class PostServlet extends HttpServlet {
	private volatile int POST_ID_SEQUENCE = 1;
    private static Map<Integer,Post> postDatabase = new LinkedHashMap<>();
   
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if(action == null)
            action = "list";
        switch(action)
        {
            case "create":
            	if(request.getSession().getAttribute("username") == null)
                {
                    response.sendRedirect("login");
                    return;
                }
            	System.out.println("Creating a post");
                this.showPostForm(request, response);
                break;
            case "voteUp":
            	if(request.getSession().getAttribute("username") == null)
                {
                    response.sendRedirect("login");
                    return;
                }
            	voteUp(request,response);
            	System.out.println("More one vote");
            	break;
            case "voteDown":
            	if(request.getSession().getAttribute("username") == null)
                {
                    response.sendRedirect("login");
                    return;
                }
            	voteDown(request,response);
            	System.out.println("Least one vote");
            	break;
            case "list":
            default:
                this.listPosts(request, response);
                break;
        }
	}
    
    private void voteDown(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
    	String id = request.getParameter("postId");
		Post post = this.getPostbyID(id, response);
		if(post==null)
			return;
		else{
			if(post.getVotes()>0)
				post.setVotes(post.getVotes() - 1);
			postDatabase.replace(Integer.parseInt(id), post);
			this.sortPosts();
		}
		response.sendRedirect("main");
		
	}

	private void voteUp(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("postId");
		Post post = this.getPostbyID(id, response);
		if(post==null)
			return;
		else{
			post.setVotes(post.getVotes() + 1);
			postDatabase.replace(Integer.parseInt(id), post);
			this.sortPosts();
		}
		response.sendRedirect("main");
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Post works");
        String action = request.getParameter("actionPost");
        System.out.println(action);
        if(action == null){
        	System.out.println("Action: " + action);
            action = "list";
        }
        switch(action)
        {
            case "create":
            	System.out.println("Creating a post");
                this.createPost(request, response);
                break;
            case "list":
            default:
                response.sendRedirect("main");
                break;
        }
	}
	
	private void createPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		if(request.getSession().getAttribute("username") == null)
        {
            response.sendRedirect("login");
            return;
        }
		System.out.println("Creating a post");
		Post post = new Post();
		post.setName((String)request.getSession().getAttribute("username"));
		post.setTitle(request.getParameter("title"));
		post.setLink(request.getParameter("link"));
		post.setVotes(0);
		int id;
        synchronized(this)
        {
            id = this.POST_ID_SEQUENCE++;
            this.postDatabase.put(id, post);
            sortPosts();
        }
        System.out.println(post.getLink());
        response.sendRedirect("main");
	}
	private void sortPosts() {
			List<Map.Entry<Integer, Post>> list = 
				new LinkedList<Map.Entry<Integer, Post>>(postDatabase.entrySet());
	 
			// Sort list with comparator, to compare the Map values
			Collections.sort(list, new Comparator<Map.Entry<Integer, Post>>() {
				public int compare(Map.Entry<Integer, Post> o1,
	                                           Map.Entry<Integer, Post> o2) {
					return (Integer.toString(o2.getValue().getVotes())).compareTo(Integer.toString(o1.getValue().getVotes()));
				}
			});
	 
			// Convert sorted map back to a Map
			Map<Integer, Post> sortedMap = new LinkedHashMap<Integer, Post>();
			for (Iterator<Map.Entry<Integer, Post>> it = list.iterator(); it.hasNext();) {
				Map.Entry<Integer, Post> entry = it.next();
				sortedMap.put(entry.getKey(), entry.getValue());
			}
			this.postDatabase =  sortedMap;
		
	}

	private void listPosts(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException{
		request.setAttribute("postDatabase", this.postDatabase);

        request.getRequestDispatcher("/WEB-INF/jsp/view/listPosts.jsp")
                .forward(request, response);
		
	}

	private void viewPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String idString = request.getParameter("postId");
        Post post = this.getPostbyID(idString, response);
        if(post == null)
            return;

        request.setAttribute("postId", idString);
        request.setAttribute("post", post);

        request.getRequestDispatcher("/WEB-INF/jsp/view/viewTicket.jsp")
               .forward(request, response);
		
	}
	private Post getPostbyID(String id, HttpServletResponse response)
            throws ServletException, IOException
    {
        if(id == null || id.length() == 0)
        {
            response.sendRedirect("main");
            return null;
        }

        try
        {
            Post post = this.postDatabase.get(Integer.parseInt(id));
            if(post == null)
            {
                response.sendRedirect("main");
                return null;
            }
            return post;
        }
        catch(Exception e)
        {
            response.sendRedirect("main");
            return null;
        }
    }
	private void showPostForm(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException{
		 request.getRequestDispatcher("/WEB-INF/jsp/view/postForm.jsp")
         .forward(request, response);
		
	}

	public static Map<Integer, Post> getPostDatabase() {
		return postDatabase;
	}

	public static void setPostDatabase(Map<Integer, Post> postDatabase) {
		PostServlet.postDatabase = postDatabase;
	}
	

}
