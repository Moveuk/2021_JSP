<%@page import="com.manage.dto.EmployeesVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.nav {
	width: 100%;
	min-height: 40px
}

td {
	border: 1px solid black;
	text-align: center;
	min-width: 150px;
}

.navbar:hover {
	background: pink;
	duration: 1s;
}

a {
	text-decoration: none;
}
</style>
<body>
	<table class="nav">
		<tr>
			<!-- 처음 로그인 시도 화면 -->
			<c:if test="${empty loginUser }">
				<td class=""></td>
				<td class=""></td>
				<td class="navbar"><a href="login.do">로그인</a></td>
				<td class="navbar">사원 등록<br> <span style="color: red;">(관리자로 로그인 후 사용가능)</span></td>
				<td class="navbar">마이페이지<br> <span style="color: red;">(로그인 후 사용가능)</span></td>
				<td class="navbar">사원 목록<br> <span style="color: red;">(관리자로 로그인 후 사용가능)</span></td>
			</c:if>
			
			<!-- 관리자 / 일반회원 로그인 화면 -->
			<c:if test="${!empty loginUser}">
				<td class="">${loginUser.name}님 반갑습니다.</td>
				<td class="">레벨 : ${loginUser.lev}</td>
				<td class="navbar"><a href="logout.do">로그아웃</a></td>
				
				<!-- 관리자 로그인 화면 분기 -->
				<c:choose>
					<c:when test="${result==2 }">
						<td class="navbar"><a href="custom.do" style="text-decoration: none;">사원 등록</a></td>
					</c:when>
					<c:when test="${result==3 }">
						<td class="navbar">사원 등록<br> <span style="color: red;">(관리자로 로그인 후 사용가능)</span></td>
					</c:when>
				</c:choose>
				<td class="navbar"><a href="mypage.do" style="text-decoration: none;">마이페이지</a></td>
				<c:choose>
					<c:when test="${result==2 }">
						<td class="navbar"><a href="list.do" style="text-decoration: none;">사원 목록</a></td>
					</c:when>
					<c:when test="${result==3 }">
				<td class="navbar">사원 목록<br> <span style="color: red;">(관리자로 로그인 후 사용가능)</span></td>
					</c:when>
				</c:choose>				
			</c:if>
		</tr>
	</table>
</body>
</html>