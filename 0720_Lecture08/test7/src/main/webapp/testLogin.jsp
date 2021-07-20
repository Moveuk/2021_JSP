<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
	String id = "pinksung";
	String pwd = "1234";
	String name = "성윤정";
	
	if (id.equals(request.getParameter("id")) && pwd.equals(request.getParameter("pwd"))) {
		session.setAttribute("name", name);
		
		if (request.getParameter("idsave")!=null) {
		Cookie idCookie = new Cookie("id",request.getParameter("id"));
		idCookie.setMaxAge(60*60);
		response.addCookie(idCookie);}
%>	
<h1> 성공적으로 로그인하셨습니다.</h1><br>
<div><a href="main.jsp">메인페이지로 가기</a></div>
<% } else {%>
<h1> 로그인에 실패했습니다.</h1>
<div><a href="loginForm.jsp">로그인페이지로 가기</a></div>
<% } %>
</body>
</html>