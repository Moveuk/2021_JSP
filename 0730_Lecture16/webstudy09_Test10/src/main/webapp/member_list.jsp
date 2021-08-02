<%@page import="java.sql.ResultSet"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	Connection conn = null;
	Context init = null;
	DataSource ds = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "SELECT * FROM MEMBER";

	try {
		init = new InitialContext();
		ds = (DataSource) init.lookup("java:/comp/env/jdbc/OracleDB");
		conn = ds.getConnection();
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
	%>
	<table border="1" style="width: 400px; text-align:center; margin: 0 auto;">
		<tr>
			<td colspan="5">회원 목록</td>
		</tr>
		<tr>
			<td>아이디</td>
			<td>이름</td>
			<td>나이</td>
			<td>성별</td>
			<td>이메일</td>
		</tr>
		<%
		while (rs.next()) {
			out.print("<tr>");
			out.print("<td><a href='member_info.jsp?id="+rs.getString(1)+"'>" + rs.getString(1) + "</a></td>");
			out.print("<td>" + rs.getString(3) + "</td>");
			out.print("<td>" + rs.getInt(4) + "</td>");
			out.print("<td>" + rs.getString(5) + "</td>");
			out.print("<td>" + rs.getString(6) + "</td>");
			out.print("</tr>");
		}

		} catch (Exception e) {
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
	</table>

</body>
</html>