<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% String name = (String) request.getAttribute("name"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	redirect 방식 :
	<%= request.getParameter("name") %> 님 안녕하세요!<br>
	id : <%= request.getParameter("id") %><br>
	forward 방식 :
	<%= name %> 님 안녕하세요!<br>
	id : <%= request.getParameter("id") %><br>
	<br> 저희 홈페이지에 방문해 주셔서 감사합니다.
	<br> 즐거운 시간 되세요...
	<br>
</body>
</html>