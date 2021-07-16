<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<form action="./template.jsp?page=loginCheck.jsp" method="post">
	<table>
		<tr>
			<td>아이디 : </td>
			<td><input type="text" name="id" size="20" value="moveuk"></td>
		</tr>
		<tr>
			<td>비밀번호 : </td>
			<td><input type="password" name="pwd" size="20" value="1234"></td>
		</tr>
		<tr>
			<td colspan="2"><input type="submit" value="로그인"></td>
		</tr>
	</table>
</form>
