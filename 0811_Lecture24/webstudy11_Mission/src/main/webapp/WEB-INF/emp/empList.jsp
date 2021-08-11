<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원 정보 리스트</title>
</head>
<link rel="stylesheet" href="<%=request.getContextPath() + "/css/emp.css"%>" />
<body>
	<div id="wrap" align="center">
		<h1>리스트</h1>
		<table class="list">
			<tr>
				<td colspan="6" style="border: white; text-align: right"><a href="empWriteForm">정보등록</a></td>
			</tr>
			<tr>
				<th>사원번호</th>
				<th>아이디</th>
				<th>이름</th>
				<th>권한</th>
				<th>성별</th>
				<th>전화번호</th>
			</tr>
			<c:forEach var="empList" items="${empList }">
				<tr class="record" style="text-align: center;">
					<td>${empList.num }</td>
					<td><a href="empDetail?id=${empList.id }">${empList.id }</a></td>
					<td>${empList.name }</td>
					<td>${empList.lev == 'A' ? '운영자' : '일반사원' }</td>
					<td>${empList.gender == '1' ? '남자' : '여자' }</td>
					<td>${empList.phone }</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</body>
</html>