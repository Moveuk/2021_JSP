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
	�� �ȳ��ϼ���!<br>
	���� Ȩ�������� �湮�� �ּż� �����մϴ�.<br>
	��ſ� �ð��Ǽ���...<br>
	<form method="post" action="logout.jsp">
		<input type="submit" value="�α׾ƿ�">
	</form>
<%} else { %>
	<h2>�α��ο� �����߽��ϴ�.</h2>
	<p><a href="loginForm.jsp">���ư���</a>
<%} %>
</body>
</html>