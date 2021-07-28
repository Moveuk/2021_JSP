<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%> 
<%@page import="com.saeyan.dao.MemberDAO" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	MemberDAO memDAO = MemberDAO.getInstance();
	Connection conn = memDAO.getConnection();
	out.print("DBCP연동 성공");
%>
</body>
</html>