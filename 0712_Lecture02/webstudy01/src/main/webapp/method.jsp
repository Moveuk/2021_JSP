<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<form method="get" action="MethodServelet">
		<input type="submit" value="get방식의 호출">
	</form>
	<br>
	
	<a href="http://localhost:8181/webstudy01/MethodServelet">get방식 호출</a>
	
	<br>
	<form method="post" action="MethodServelet">
		<input type="submit" value="post방식의 호출">
	</form>
	
</body>
</html>