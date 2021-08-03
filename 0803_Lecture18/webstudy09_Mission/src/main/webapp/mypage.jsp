<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="mypage.do" method="post" name="frm">
		<table style="text-align: center; margin: 0 auto; width: 50%;">
			<tr>
				<td colspan="2" style="" class="">마이페이지</td>
			</tr>
			<tr>
				<td>아이디</td>
				<td>
					<input type="text" size="20" name="id" readonly="readonly" value="${loginUser.id }">
				</td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td>
					<input type="password" size="20" name="pwd" value="">
				</td>
			</tr>
			<tr>
				<td>이름</td>
				<td>
					<input type="text" size="20" name="name" value="${loginUser.name }">
				</td>
			</tr>
			<tr>
				<td>권한</td>
				<td>
					<select name="lev" id="lev">
						<c:if test="${loginUser.lev == 'A' }">
							<option value="A" selected="selected">운영자</option>
							<option value="B">일반회원</option>
						</c:if>
						<c:if test="${loginUser.lev == 'B' }">
							<option value="A">운영자</option>
							<option value="B" selected="selected">일반회원</option>
						</c:if>
					</select>
				</td>
			</tr>
			<tr>
				<td>성별</td>
				<td>
					<select name="gender" id="gender">
						<c:if test="${loginUser.gender == 1 }">
							<option value="1" selected="selected">남자</option>
							<option value="2">여자</option>
						</c:if>
						<c:if test="${loginUser.gender == 2 }">
							<option value="1">남자</option>
							<option value="2" selected="selected">여자</option>
						</c:if>
					</select>
				</td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td>
					<input type="tel" size="13" name="phone" value="${loginUser.phone }">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="수정">
					<input type="reset" value="취소">
				</td>
			</tr>
		</table>
		<div style="color: red; text-align: center;">${message}</div>
	</form>
</body>
</html>