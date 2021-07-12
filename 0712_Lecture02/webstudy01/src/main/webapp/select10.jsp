<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form method="get" action="SelectServlet">
		<label for="job">직업</label> <br> 
		<select id="job" name="job">
			<option value="">선택하세요</option>
			<option value="학생">학생</option>
			<option value="컴퓨터/인터넷">컴퓨터/인터넷</option>
			<option value="언론">언론</option>
			<option value="공무원">공무원</option>
			<option value="군인">군인</option>
			<option value="서비스업">서비스업</option>
			<option value="교육">교육</option>
			<option value="기타">기타</option>
		</select><br> 
		
		<label for="interest">관심분야</label> <br> 
		<select id="interest" name="interest" size="5" multiple="multiple">
			<option value="">선택하세요</option>
			<option value="에스프레소">에스프레소</option>
			<option value="로스팅">로스팅</option>
			<option value="생두">생두</option>
			<option value="원두">원두</option>
			<option value="핸드드립">핸드드립</option>
		</select><br> 
		
		<input type="submit" value="전송">
	</form>
</body>
</html>