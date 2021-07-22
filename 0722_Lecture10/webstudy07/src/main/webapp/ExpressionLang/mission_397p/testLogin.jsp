<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:if test="${param.id == 'moveuk' && param.pwd == 1234}">
		<div>
			<c:if test="${param.check == '사용자'}">
			${param.id} 님 ${param.check}로 로그인하셨습니다.
			</c:if>
			<c:if test="${param.check == '관리자'}">
			${param.id} 님 ${param.check}로 로그인하셨습니다.
			</c:if>
		</div>
	</c:if>
</body>
</html>