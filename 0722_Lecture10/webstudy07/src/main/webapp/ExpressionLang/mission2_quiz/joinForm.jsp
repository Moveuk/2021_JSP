<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="joinAction.jsp" method="post">
		<table>
			<tr>
				<td>이름 </td>
				<td><input type="text" name="name" size="20" value="이동욱"/></td>
			</tr>
			<tr>
				<td>아이디 </td>
				<td><input type="text" name="id" size="20" value="moveuk"/></td>
			</tr>
			<tr>
				<td>암 &nbsp; 호 </td>
				<td><input type="password" name="pwd" size="20" value="1234"/></td>
			</tr>
			<tr>
				<td>이메일 </td>
				<td><input type="email" name="email" size="20" value="v_donguk@naver.com"/></td>
			</tr>
			<tr>
				<td>전화번호 </td>
				<td><input type="tel" name="tel" size="13" value="010-1000-1000"/></td>
			</tr>
			<tr>
				<td>등급 </td>
				<td><input type="radio" name="check" value="관리자" checked/>관리자<input type="radio" name="check" value="일반회원"/>일반회원</td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="전송"/><input type="reset" value="취소"/></td>
			</tr>
		</table>
	</form>
</body>
</html>