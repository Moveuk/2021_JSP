<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:if test="${param.fruit == 1}">
	<span style="color: red;">사과</span>
</c:if>
<c:if test="${param.fruit == 2}">
	<span style="color: green;">메론</span>
</c:if>
<c:if test="${param.fruit == 3}">
	<span style="color: blue;">바나나</span>
</c:if>
</body>
</html>