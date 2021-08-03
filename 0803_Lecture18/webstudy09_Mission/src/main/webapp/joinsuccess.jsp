<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "header.jsp" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table border = "1" align = "center" width="550px">
		<tr>
			<td colspan="2"><h3>사원 정보</h3><div style="color: red">${message}</div></td>
		</tr>
		<tr>
			<td>아이디</td><td>${member.id }</td>
		</tr>
		<tr>
			<td>비밀번호</td><td>${member.pass }</td>
		</tr>
		<tr>
			<td>이름</td><td>${member.name }</td>
		</tr>
		<tr>
			<td>권한</td>
			<%-- <td>${member.lev }</td> --%>
			<td>
				<c:choose>
					<c:when test="${member.lev == 'A' }">운영자</c:when>
					<c:otherwise>일반회원</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<td>성별</td><td>${member.gender }</td>
		</tr>
		<tr>
			<td>전화번호</td><td>${member.phone }</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type = "button" value = "메인 페이지로 이동" onclick ="location.href='main.jsp'">
				
			</td>
		</tr>
	</table>
</body>
</html>