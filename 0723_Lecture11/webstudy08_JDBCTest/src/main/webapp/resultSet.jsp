<%@page import="oracle.net.aso.e"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<% 
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "select * from student";

	try {
  		Context init = new InitialContext();
  		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
  		conn = ds.getConnection();
		
  		pstmt=conn.prepareStatement(sql);
  		rs=pstmt.executeQuery();	// select : 반환 타입이 ResultSet이기 때문에 사용함.
		
		out.println("<h3>num&nbsp;&nbsp;&nbsp;&nbsp;name</h3>");	
  		
		while (rs.next()) { 	// while 조건 next() 칼럼 이동하면서 값이 있는지 확인 있으면 true
			out.println("<h3>"+ rs.getInt(1)+", "+		// 컬럼 번호 1번
			rs.getString(2)+"</h3>");					// 컬럼 번호 2번
		}
		
	} catch (Exception e) {
		out.println("<h3> 데이터 가져오기 실패 </h3>");
		e.printStackTrace();
	} finally {
		try {
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>