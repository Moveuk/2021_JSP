
<%@page import="javabeans.JoinBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:set var="member" value="<%=new JoinBean()%>" />
	<c:set target="${member }" property="name" value="${param.name }" />
	<c:set target="${member }" property="id" value="${param.id }" />
	<c:set target="${member }" property="pwd" value="${param.pwd }" />
	<c:set target="${member }" property="email" value="${param.email }" />
	<c:set target="${member }" property="tel" value="${param.tel }" />
	<c:set target="${member }" property="level" value="${param.check }" />

	${member }
</body>
</html>