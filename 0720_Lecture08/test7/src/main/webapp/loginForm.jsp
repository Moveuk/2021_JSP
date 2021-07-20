<%@page import="org.apache.catalina.servlets.CGIServlet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
Cookie[] cookies = request.getCookies();
String id = "";
for (Cookie c : cookies) {
	if (c.getName().equals("id")) {
		id = c.getValue();
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
	<form action="testLogin.jsp">
		<fieldset>
			<legend>로그인</legend>
			<table>
			<tr>
				<td><label for="id"> 아이디 : </label></td>
				<td><input type="text" id="id" name="id" value="<%=id%>" /></td>
			</tr>
			<tr>
				<td><label for="pwd"> 암 &nbsp; 호 : </label></td>
				<td><input type="password" id="pwd" name="pwd"/></td>
			</tr>
			<tr>
				<td colspan="2"><input type="checkbox" name="idsave" <%if(id!=null) {%>checked<%}%>><label for="idsave">아이디 저장</label></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="로그인"></td>
			</tr>
			</table>
		</fieldset>
	</form>
</body>
</html>