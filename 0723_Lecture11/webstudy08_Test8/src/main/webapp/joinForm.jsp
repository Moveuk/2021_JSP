<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<fieldset style="text-align: center; width: max-content;">
<h2>회원 정보 입력</h2>
<form action="joinChk.jsp" method="post" >
<table style="margin: 0 auto;">
<tr>
	<td>아이디:&nbsp;&nbsp;&nbsp;</td>
	<td><input type="text" name="usrid" /></td>
</tr>
<tr>
	<td>비밀번호:&nbsp;&nbsp;&nbsp;</td>
	<td><input type="password" name="usrpwd" /></td>
</tr>
<tr>
	<td>이름:&nbsp;&nbsp;&nbsp;</td>
	<td><input type="text" name="usrName" /></td>
</tr>
<tr>
	<td>성별:&nbsp;&nbsp;&nbsp;</td>
	<td><input type="radio" name="usrGender" value="1" checked/>남 <input type="radio" name="usrGender" value="2"/>여</td>
</tr>
<tr>
	<td>나이:&nbsp;&nbsp;&nbsp;</td>
	<td><input type="text" name="usrAge" /></td>
</tr>
<tr>
	<td>이메일주소:&nbsp;&nbsp;&nbsp;</td>
	<td><input type="email" name="usrEmail" /></td>
</tr>
</table>
<input type="submit" value="가입" /> <input type="reset" value="다시 작성" />
</form>
</fieldset>
</body>
</html>