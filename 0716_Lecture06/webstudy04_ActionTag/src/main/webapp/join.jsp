<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>회원가입</h1>
<form action="./template.jsp?page=joinCheck.jsp" method="post">
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
			<td>이메일 : </td>
			<td><input type="email" name="email" size="20" value="moveuk@naver.com"></td>
		</tr>
		<tr>
			<td>주소 : </td>
			<td><input type="text" name="addr" size="20" value="영등포구"></td>
		</tr>
		<tr>
			<td>전화번호 : </td>
			<td><input type="tel" name="tel" size="20" value="010-1000-1000"></td>
		</tr>
		<tr>
			<td colspan="2"><input type="submit" value="회원가입"></td>
		</tr>
	</table>	
</form>