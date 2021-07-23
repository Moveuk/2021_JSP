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
	ResultSetMetaData rsmd = null;

	try {
  		Context init = new InitialContext();
  		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
  		conn = ds.getConnection();
		
  		pstmt=conn.prepareStatement(sql);
  		rs=pstmt.executeQuery();	// select : 반환 타입이 ResultSet이기 때문에 사용함.
		
		// 테이블 생성시의 META 정보 불러오기
		// META 정보 불러오기 위해 필드에 ResultSetMetaData rsmd = null; 을 초기화.
		rsmd = rs.getMetaData(); // resultSet 내부에 들어있는 META 데이타를 끌어옴.
		
		// getColumnCount() 	: 컬럼의 갯수 확인
		// getColumnName() 		: 컬럼의 이름 확인
		// getColumnTypeName() 	: 컬럼의 타입 확인
		
		out.println("컬럼 갯수 : " + rsmd.getColumnCount()+"<br>");
		for (int i = 1; i <= rsmd.getColumnCount(); i++) {
		out.println(i+"번째 컬럼 이름 : " + rsmd.getColumnName(i)+"&nbsp;&nbsp;&nbsp;");
		out.println(i+"번째 컬럼 타입 : " + rsmd.getColumnTypeName(i)+"<br>");
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