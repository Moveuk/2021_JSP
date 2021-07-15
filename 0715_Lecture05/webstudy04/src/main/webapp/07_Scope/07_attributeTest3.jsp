<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% 
	request.setCharacterEncoding("UTF-8"); 
	String name = (String) application.getAttribute("name");
	String id = (String) application.getAttribute("id");
	String email = (String) session.getAttribute("email");
	String addr = (String) session.getAttribute("addr");
	String tel = (String) session.getAttribute("tel");
	%>
	
	<b>Application 방식 불러오기<br></b>
	<%= name %><br>
	<%= id %><br>
	<br>
	<b>Session 방식 불러오기<br></b>
	<%= email %><br>
	<%= addr %><br>
	<%= tel %><br>
	<br><br>
	<b><%= "enumeration을 통해 출력한 값들" %></b>
	<table border="1">
		<% 
		Enumeration e = session.getAttributeNames();
		while(e.hasMoreElements()) {
			String attributeName = (String) e.nextElement();
			String attributeValue = (String) session.getAttribute(attributeName);
		%>

		<tr>
			<td> <%= attributeName %></td>
			<td> <%= attributeValue %></td>
		</tr>
		<%
		}%>
	</table>
	<br><br>
			<% 
			Enumeration e2 = session.getAttributeNames();
		while(e2.hasMoreElements()) {
			String attributeName = (String) e2.nextElement();
			String attributeValue = (String) session.getAttribute(attributeName);
			out.print(attributeValue);}
		%>
	
</body>
</html>