<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Request 예제입니다.</h1>
	<table border="1">
	<% request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	String[] hobbies = request.getParameterValues("hobby");%>
	<tr>
		<td>이름</td>
		<td><%= name %></td>
	</tr>
	<tr>
		<td>성별</td>
		<td><%= gender %></td>
	</tr>
	<tr>
		<td>취미</td>
		<td><% for (String hobby : hobbies) { out.print(hobby+" "); } %></td>
	</tr>
	</table>
	
</body>
</html>