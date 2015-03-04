package com.fullerton;

import java.io.IOException;
import java.util.Hashtable;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(
        name = "loginServlet",
        urlPatterns = "/login"
)
public class LoginServlet extends HttpServlet
{
    private static final Map<String, String> userDatabase = new Hashtable<>();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        HttpSession session = request.getSession();
        if(request.getParameter("logout") != null)
        {
            session.invalidate();
            response.sendRedirect("login");
            return;
        }
        else if(request.getParameter("userform")!=null){
        	showUserForm(request,response);
        }
        else if(request.getAttribute("loginaction")!= null ){
        	String action = (String) request.getSession().getAttribute("action");
        	if(action != null){
        		createUser(request,response);
        	}
        }
        else if(session.getAttribute("username") != null)
        {
            response.sendRedirect("main");
            return;
        }
        else{
        	request.setAttribute("loginFailed", false);
        	request.getRequestDispatcher("/WEB-INF/jsp/view/login.jsp")
               .forward(request, response);
        }
    }

    private void showUserForm(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
    	request.getRequestDispatcher("/WEB-INF/jsp/view/userForm.jsp")
        .forward(request, response);
		
	}

	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        HttpSession session = request.getSession();
        if(session.getAttribute("username") != null)
        {
            response.sendRedirect("main");
            return;
        }
        else{
        	if(request.getParameter("action") != null ){
        		createUser(request, response);
        	}else{
        		login(request,response);
        	}
        }
        
    }
    
    private void createUser(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		String name = request.getParameter("name");
		String password = request.getParameter("pswd");
		System.out.println(name);
		if(name!= null && password != null){
			userDatabase.put(name, password);
			System.out.println(userDatabase.get(name));
			request.setAttribute("action", null);
			response.sendRedirect("login");
		}else{
			request.getSession().invalidate();
            response.sendRedirect("login");
		}
		
	}

	private void login(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
    	HttpSession session = request.getSession();
    	String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        if(username == null || password == null ||
                !LoginServlet.userDatabase.containsKey(username) ||
                !password.equals(LoginServlet.userDatabase.get(username)))
        {
            request.setAttribute("loginFailed", true);
            request.getRequestDispatcher("/WEB-INF/jsp/view/login.jsp")
                   .forward(request, response);
        }
        else
        {
            session.setAttribute("username", username);
            request.changeSessionId();
            response.sendRedirect("main");
        }
    }
}
