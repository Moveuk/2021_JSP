<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정보 보기</title>
<link rel="stylesheet" href="<%=request.getContextPath() + "/css/emp.css"%>" />
</head>
<body>
<div id="wrap" align="center">
	<h1> 정보 보기 </h1>
		<table>
			<tr>
				<th>회원번호</th>
				<td>${eVo.num }</td>
			</tr>
			<tr>
				<th>아이디</th>
				<td>${eVo.id }</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>${eVo.pass }</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>${eVo.name }</td>
			</tr>
			<tr>
				<th>권한</th>
				<td>${eVo.lev }</td>
			</tr>
			<tr>
				<th>성별</th>
				<td>${eVo.gender }</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>${eVo.phone }</td>
			</tr>

		</table>
		<br><br>
		<input type="submit" value="수정" onclick="location.href='empUpdateForm?id=${eVo.id}'">
		<input type="submit" value="삭제" onclick="location.href='empDelete?id=${eVo.id}'">
		<input type="button" value="목록" onclick="location.href='empList'">
</div>	
</body>
</html>