<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<% 
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "insert into student (num,name) values (13,'새로운')";
	String sql2 = "select * from student where num = 12";

	try {
  		Context init = new InitialContext();
  		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
  		conn = ds.getConnection();
		
  		// 수동 트랜잭션 처리 방법
  		conn.setAutoCommit(false); // 트랜잭션 처리 후 자동 커밋되는것을 false로 중지함
  		
  		pstmt=conn.prepareStatement(sql);	// insert 쿼리문 실행
  		int cnt = pstmt.executeUpdate();	// update 횟수.
		
		
  		pstmt=conn.prepareStatement(sql2);	// 없는 12번 데이터 출력문 -> 오류
  		rs = pstmt.executeQuery();	// select : 반환 타입이 ResultSet이기 때문에 사용함.

  		// 12번이 없어서 null
		if (!rs.next()) {
			conn.rollback();
			out.println("<h3>번호가 일치하지 않아서 롤백 처리</h3>");
		} else {	// rs에 데이터 있으면 커밋 처리
			conn.commit();
			out.println("<h3>커밋 성공</h3>");
		}
		
  		// 다시 자동 커밋처리
		conn.setAutoCommit(true);
  		
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