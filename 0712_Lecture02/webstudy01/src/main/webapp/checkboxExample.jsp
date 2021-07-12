<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form method="get" action="CheckboxExServlet">
		<h1> 당신이 좋아하는 강아지를 선택하세요. </h1> <br>
		<input type="checkbox" name="item" value="pu" checked> 푸들 
		<input type="checkbox" name="item" value="jin" checked> 진돗개 
		<input type="checkbox" name="item" value="pung" checked> 풍산개 
		<input type="checkbox" name="item" value="sap" checked> 삽살개 <br>
		<br><br>
		<input type="submit" value="전송">
	</form>
</body>
</html>