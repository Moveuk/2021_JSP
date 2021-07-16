<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% 
	String lang = "kor";
	String cookie = request.getHeader("Cookie");
	
	if (cookie != null) {
		Cookie[] cookies = request.getCookies();
		for (Cookie c : cookies) {
			if(c.getName().equals("lang")) {
				lang = c.getValue();				
			}
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
if ( lang.equals("kor")){ %>
	<h2>안녕하세요. 이것은 쿠키 예제입니다.</h2>
<%} else {%>
	<h2>Hello. This is Cookie example.</h2>
<% } %>

	<form action="cookieExample2.jsp" method="post">
		<input type="radio" name="lang" value="kor" <%if(lang.equals("kor")) {%>checked<% } %>>한국어 페이지 보기
		<input type="radio" name="lang" value="eng" <%if(lang.equals("eng")) {%>checked<% } %>>영어 페이지 보기
		<input type="submit" value="설정">
	</form>
</body>
</html>