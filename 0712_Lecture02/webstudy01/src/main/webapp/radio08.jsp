<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form method="get" action="RadioServlet">
		<label for = "gender">성별 : </label> <br>
		<!-- radio는 name 속성이 같아야 한다. -->
		<input type="radio" id="gender" name = "gender" value="남자" checked > 남자 <br>
		<input type="radio" id="gender" name = "gender" value="여자"> 여자 <br>
		<br><br>
		<label for = "chk_mail">메일정보 수신 여부 : </label> <br>
		<!-- label 의 for와 input의 id가 같아야 연동이 된다. -->		
		<input type="radio" id="chk_mail" name = "chk_mail" value="yes" checked > 수신 <br>
		<input type="radio" id="chk_mail" name = "chk_mail" value="no" > 거부 <br>
		<br><br>
		<label for="content">간단한 가입 인사 부탁드립니다.</label> <br>
		<textarea id="content" name="content" rows="3" cols="35"></textarea>
		<br><br>
		<input type="submit" value="전송" >
	</form>
</body>
</html>