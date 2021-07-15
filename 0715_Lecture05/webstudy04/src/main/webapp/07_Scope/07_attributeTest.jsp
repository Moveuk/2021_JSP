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
	// request 는 값을 받아올때 보낸 곳과 같이 인코딩을 해줘야함.
	request.setCharacterEncoding("UTF-8"); 
	String name = request.getParameter("name");
	String id = request.getParameter("id");
	
	if (!(name==null || id==null)) {
		application.setAttribute("name", name);
		application.setAttribute("id", id);
	}
	%>
	
	<h3><%= name %>님 반갑습니다. 아이디는 <%= id %>입니다.</h3>
	
	<form action="07_attributeTest2.jsp" method="post">
	<table>
		<tr>
			<td colspan="2">Session 영역에 저장</td>
		</tr>
		<tr>
			<td>Email주소</td>
			<td><input name="email"></td>
		</tr>
		<tr>
			<td>집주소</td>
			<td><input name="addr"></td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td><input name="tel"></td>
		</tr>
		<tr>
			<td colspan="2"><input type="submit" value="전송"></td>
		</tr>
	</table>
</form>
	
</body>
</html>