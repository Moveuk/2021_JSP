<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form method="get" action="CheckboxServlet">
	<!-- item에 0~아이템 갯수 까지 다양하게 넘어감으로 배열로 넘어감 -->
		<input type="checkbox" name="item" value="신발"> 신발 <br>
		<input type="checkbox" name="item" value="가방"> 가방 <br>
		<input type="checkbox" name="item" value="벨트"> 벨트  <br><br>
		<input type="checkbox" name="item" value="모자"> 모자 <br>
		<input type="checkbox" name="item" value="시계"> 시계 <br>
		<input type="checkbox" name="item" value="쥬얼리"> 쥬얼리 <br>
		<br><br>
		<input type="submit" value="전송">
	</form>
</body>
</html>