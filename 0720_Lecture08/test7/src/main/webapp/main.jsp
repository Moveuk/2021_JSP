<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% if (session.getAttribute("name") == null) {%>
<h1> 로그인에 실패했습니다.</h1>
<div><a href="loginForm.jsp">로그인페이지로 가기</a></div>
<% } else {%>
<h3><%= session.getAttribute("name") %> 님 안녕하세요!<br>
저희 홈페이지에 방문해 주셔서 감사합니다.<br>
즐거운 시간 되세요...</h3>
<a href="logout.jsp"><input type="button"  value="로그아웃"></a>
<% } %>
</body>
</html>