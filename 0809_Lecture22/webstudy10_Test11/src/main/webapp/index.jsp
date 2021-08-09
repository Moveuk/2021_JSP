<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% if (session.getAttribute("id") != null){ %>
		<%= session.getAttribute("id") %>님 로그인하셨습니다 <br>
	<a href="logout">로그아웃</a>
	<% } else { %>
	<a href="loginForm.html">로그인</a>
	<% } %>
</body>
</html>