<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="item" class="javabeans.ItemBean"></jsp:useBean>
<jsp:setProperty property="*" name="item" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>입력 완료된 정보</h2>
	<table>
		<tr>
			<td>핸드폰</td>
			<td>
				<jsp:getProperty property="name" name="item"/>
			</td>
		</tr>
		<tr>
			<td>가격</td>
			<td>
				<jsp:getProperty property="price" name="item"/>
			</td>
		</tr>
		<tr>
			<td>설명</td>
			<td>
				<jsp:getProperty property="description" name="item"/>
			</td>
		</tr>
	</table>
</body>
</html>