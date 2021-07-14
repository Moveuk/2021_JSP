
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%
	String id="pinksung";
	String pwd="1234";
	String name="성윤정";
	request.setCharacterEncoding("UTF-8");
	if(id.equals(request.getParameter("id")) && pwd.equals(request.getParameter("pwd"))) {
		// redirect 방식
		response.sendRedirect("04_main.jsp?name="+URLEncoder.encode(name,"UTF-8"));
		// forward 방식
		//request.setAttribute("name", "성윤정");
		//request.getRequestDispatcher("04_main.jsp").forward(request, response);
	} else {
		response.sendRedirect("04_loginForm.jsp");
	}
	%>