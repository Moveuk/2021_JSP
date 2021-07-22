<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
Connection conn = null;
// prepared는 와일드카드(?)를 사용할 수 있다.
String sql = "insert into student (num,name) values (?,'뉴길동')";
PreparedStatement pstmt = null;

try {
	Context init = new InitialContext();
	DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/oracleDB");
	conn = ds.getConnection();
	
	// createStatement와는 달리 sql문을 미리 넣어서 객체화 한다.  
	pstmt = conn.prepareStatement(sql);
	
	for (int i= 8; i < 12; i++){ // 8~11 까지 넣음.
	pstmt.setInt(1, i); // 첫번째 와일드카드(?)에 두번째 인자 값을 넣음
	int result = pstmt.executeUpdate(); 	// insert delete update - 처리 횟수 리턴
	if (result != 0) {
		out.print("<h3>"+i+"번째 레코드 삽입 성공</h3>");
	}
	}	
	
} catch (Exception e) {
	out.print("<h3>레코드 삽입 실패</h3>");
	e.printStackTrace();
} finally {
	try {
		pstmt.close();
		conn.close();
	} catch(Exception e) {
		e.printStackTrace();
	}
}
%>
</body>
</html>