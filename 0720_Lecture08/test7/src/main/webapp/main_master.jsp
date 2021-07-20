<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String cookie = request.getHeader("Cookie");
String username = "";

if(cookie!=null){
	Cookie cookies[]=request.getCookies();
	
	for(int i=0;i<cookies.length;i++){
		if(cookies[i].getName().equals("username")){
			username=URLDecoder.decode(cookies[i].getValue(),"UTF-8");
		}
	}
	out.print(username);
%>
	님 안녕하세요!<br>
	저희 홈페이지에 방문해 주셔서 감사합니다.<br>
	즐거운 시간되세요...<br>
	<form method="post" action="logout.jsp">
		<input type="submit" value="로그아웃">
	</form>
<%} else { %>
	<h2>로그인에 실패했습니다.</h2>
	<p><a href="loginForm.jsp">돌아가기</a>
<%} %>
</body>
</html>