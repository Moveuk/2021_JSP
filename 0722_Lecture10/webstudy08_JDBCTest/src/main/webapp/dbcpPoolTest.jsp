
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
	Connection conn = null;

	try {
		// javax.naming.Context 네이밍을 사용하여 pool 접근? 라이브러리 추가해줘야함.
		Context init = new InitialContext();
		// xml 파일에 name으로 지정한 값을 lookup으로 호출해줘야함.
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/oracleDB");
		conn = ds.getConnection();
		
		
		out.print("연결 성공");
	} catch (Exception e) {
		out.print("연결 실패");
		e.printStackTrace();
	}
%>
</body>
</html>