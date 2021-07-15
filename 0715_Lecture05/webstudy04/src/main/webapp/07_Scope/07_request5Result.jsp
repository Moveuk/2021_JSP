<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	pageScope = <%= pageContext.getAttribute("pageScope") %>
	<br>
	requestScope = <%= request.getAttribute("requestScope") %>
</body>
</html>