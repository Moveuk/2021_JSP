<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.saeyan.dao.MemberDAO" %>
<%@page import="java.sql.Connection" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
// 인스턴스 메모리에서 공유 (getConnection() 불러오기만 하면 되니까 많이 쓸 일이 없음.)
MemberDAO memberDAO = MemberDAO.getInstance();
// 공유한 인스턴스에서 커넥션 불러와서 conn에 저장
Connection conn = memberDAO.getConnection();
out.print("db 연동 성공");
%>	
</body>
</html>