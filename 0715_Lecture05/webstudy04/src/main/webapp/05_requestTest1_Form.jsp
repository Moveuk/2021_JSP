<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Request 예제입니다.</h1>
	<form method="post" action="05_requestTest1.jsp">
		<table border="1">
			<tr>
				<td>이름</td>
				<td><input type="text" name="name" value="홍길동"></td>
			</tr>
			<tr>
				<td>성별</td>
				<td><input type="radio" name="gender" value="남자" checked="checked">남자<input type="radio" name="gender" value="여자">여자</td>
			</tr>
			<tr>
				<td>취미</td>
				<td>독서<input type="checkbox" name="hobby" value="독서" checked>게임<input type="checkbox" name="hobby" value="게임">TV시청<input type="checkbox" name="hobby" value="TV시청" checked>축구<input type="checkbox" name="hobby" value="축구">기타<input type="checkbox" name="hobby" value="기타"></td>
			</tr>
			<tr>
				<td colspan="2"><button type="submit">전송</button></td>
			</tr>
		</table>
	</form>
</body>
</html>