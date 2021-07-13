<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<% 
	String id = (String) session.getAttribute("id");
%>
<body>
<% 
	if (id == null){
%>	
	로그인 해주세요
<% 
	} else {
%>
	<%= id %>님 환영합니다.
<% 
	}
%>	
	<form method="post" action="LoginServlet">
		아이디 	:<input id="id" name="id" value="java"> <br> 
		비밀번호 	:<input id="pwd" name="pwd" value="java"> <br> 
		<button type="submit">제출</button>
	</form>
</body>
</html>