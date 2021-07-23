<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<%
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
ResultSetMetaData rsmd = null;
String sql = "select * from ?";
String table = "EMP";

out.print(request.getParameter("table"));
try {
	Context init = new InitialContext();
	DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
	conn = ds.getConnection();
	pstmt = conn.prepareStatement(sql);
	
	pstmt.setString(1,"emp");
	
	rs = pstmt.executeQuery();
	rsmd = pstmt.getMetaData();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table border="1" style="border-collapse: collapse; width:600px; padding: 2px">
		<thead>
			<tr>
				<%
				for (int i = 1; i <= rsmd.getColumnCount(); i++) {
					out.println("<th>" + rsmd.getColumnName(i) + "</th>");
				}
				%>
			</tr>
		</thead>
		<tbody>
			<%
			while (rs.next()) {
				out.println("<tr>");
				for (int i = 1; i <= rsmd.getColumnCount(); i++) {
					out.println("<td>" +rs.getString(i)+ "</td>");
				}

				out.println("</tr>");
			}	

			} catch (Exception e) {
			e.printStackTrace();
			out.print("데이터 처리 실패");
			} finally {

			}
			%>
		</tbody>
	</table>
</body>
</html>