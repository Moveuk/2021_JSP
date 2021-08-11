<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정보 등록</title>
<link rel="stylesheet" href="<%=request.getContextPath() + "/css/emp.css"%>" />
<script type="text/javascript" src="<%=request.getContextPath() + "/script/board.js"%>"></script>
</head>
<body>
<div id="wrap" align="center">
	<h1> 정보 등록 </h1>
	<form action="empUpdate" name="frm" method="post">
		<table>
			<tr>
				<th>아이디</th>
				<td><input type="text" name="id" value="${eVo.id }" readonly="readonly"/></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="pass" value="${eVo.pass }"/></td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input type="text" name="name" value="${eVo.name }"/></td>
			</tr>
			<tr>
				<th>권한</th>
				<td>
					<select id="lev" name="lev">
						<option value="A">운영자</option>
						<option value="B" ${eVo.lev == 'B' ? "selected" : "" }>일반회원</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>성별</th>
				<td>
					<select id="gender" name="gender">
						<option value="1">남자</option>
						<option value="2" ${eVo.gender == '2' ? "selected" : "" }>여자</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><input type="text" name="phone" value="${eVo.phone }"/></td>
			</tr>

		</table>
		<br><br>
		<input type="submit" value="수정" onclick="return boardCheck()">
		<input type="reset" value="다시 작성">
		<input type="button" value="목록" onclick="location.href='empList'">
	</form>
</div>	
</body>
</html>