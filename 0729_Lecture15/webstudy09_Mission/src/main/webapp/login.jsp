<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="header.jsp"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="login.do" method="post">
		<table style="text-align: center; margin: 0 auto; width: 40%;">
			<tr>
				<td colspan="2" style="center;" class="">로그인</td>
			</tr>
			<tr>
				<td>아이디</td>
				<td><input type="text" size="20" name="id"></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" size="20" name="pwd"></td>
			</tr>
			<tr>
				<td>레벨</td>
				<td>
					<select name="lev" id="lev">
						<option value="A">운영자</option>
						<option value="B">일반회원</option>
					</select>
				</td>
			</tr>
			<tr>
				<td colspan="2">
				<input type="submit" value="로그인"> 
				<input type="reset" value="취소">
				</td>
			</tr>
		</table>
		<div style="color: red; text-align: center;">${message}</div>
	</form>
</body>
</html>