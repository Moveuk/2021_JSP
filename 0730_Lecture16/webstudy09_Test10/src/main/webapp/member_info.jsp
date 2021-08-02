<%@page import="java.sql.ResultSet"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.PreparedStatement"%>
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
	String sql = "SELECT * FROM MEMBER WHERE id=?";
	String id = null;
	String password = null;
	String name = null;
	int age = 0;
	String gender = null;
	String email = null;

	try {
		init = new InitialContext();
		ds = (DataSource) init.lookup("java:/comp/env/jdbc/OracleDB");
		conn = ds.getConnection();
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, request.getParameter("id"));
		rs = pstmt.executeQuery();

		if (rs.next()) {
			id = rs.getString("id");
			password = rs.getString(2);
			name = rs.getString(3);
			age = rs.getInt(4);
			gender = rs.getString(5);
			email = rs.getString(6);
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
	<table border="1" style="width: 400px; text-align:center; margin: 0 auto;">
		<tr>
			<td>아이디 :</td>
			<td><%= id %></td>
		</tr>
		<tr>
			<td>비밀번호 :</td>
			<td><%= password %></td>
		</tr>
		<tr>
			<td>이름 :</td>
			<td><%= name %></td>
		</tr>
		<tr>
			<td>나이 :</td>
			<td><%= age %></td>
		</tr>
		<tr>
			<td>성별 :</td>
			<td><%= gender %></td>
		</tr>
		<tr>
			<td>이메일 주소 :</td>
			<td><%= email %></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<a href="member_list.jsp">리스트로 돌아가기</a>
			</td>
		</tr>
	</table>
</body>
</html>