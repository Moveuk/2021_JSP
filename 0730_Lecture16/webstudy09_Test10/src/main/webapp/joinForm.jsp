<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="member.js">
</script>
</head>
<body>
	<form action="joinProcess.jsp" method="post" name="frm">
		<table border="1" style="width: 400px; margin: 0 auto;">
			<tr>
				<td colspan="2" align="center">
					<h2>회원 가입 페이지</h2>
				</td>
			</tr>
			<tr>
				<td>아이디 :</td>
				<td>
					<input type="text" name="id" size="20">
				</td>
			</tr>
			<tr>
				<td>비밀번호 :</td>
				<td>
					<input type="password" name="password" size="20">
				</td>
			</tr>
			<tr>
				<td>이름 :</td>
				<td>
					<input type="text" name="name" size="20">
				</td>
			</tr>
			<tr>
				<td>나이 :</td>
				<td>
					<input type="text" name="age" size="8">
				</td>
			</tr>
			<tr>
				<td>성별 :</td>
				<td>
					<input type="radio" name="gender" value="남" checked="checked">
					남자
					<input type="radio" name="gender" value="여">
					여자
				</td>
			</tr>
			<tr>
				<td>이메일 주소 :</td>
				<td>
					<input type="text" name="email" size="20">
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<a type="submit" href="#" onclick="return joinCheck()">회원가입</a>
					<a href="joinForm.jsp">다시작성</a>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>