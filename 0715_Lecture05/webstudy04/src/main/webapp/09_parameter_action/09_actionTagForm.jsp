<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="09_actionTagTest.jsp">
	<table>
		<tr>
			<td>아이디 : </td>
			<td><input type="text" name="id" value="Moveuk" size="30"></td>
		</tr>
		<tr>
			<td>암 &nbsp; 호 : </td>
			<td><input type="password" name="pwd" value="password" size="30"></td>
		</tr>
		<tr>
			<td colspan="2"><input type="radio" name="loginCheck" value="user" checked="checked">사용자 <input type="radio" name="loginCheck" value="관리자"> 관리자 </td>
		</tr>
		<tr>
			<td colspan="2"><input type="submit" value="로그인"></td>
		</tr>
	</table>
</form>
</body>
</html>