# Lecture12 JSP, JDBC와 SQL

Key Word : select, update, delete, insert 기능 구현, 자바 빈을 이용한 데이터 읽고 쓰기

<hr>

## DB 접근 방식 if문으로 나누기 

**quiz2_transaction.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	ResultSetMetaData rsmd = null;
	
	String sql = request.getParameter("sql");

	try{
		
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/OracleDB");
		conn = ds.getConnection();
		
		pstmt = conn.prepareStatement(sql);
		
		if(sql.startsWith("select")){
			rs = pstmt.executeQuery();
			rsmd = rs.getMetaData();
			
			out.print("<table border ='1'>");
				out.print("<tr>");
				for(int i=1;i<=rsmd.getColumnCount();i++){
					out.print("<td>");
					out.print(rsmd.getColumnName(i));
					out.print("</td>");
				}
				out.print("</tr>");
				
				while(rs.next()){
					out.print("<tr>");
					for(int i=1; i <= rsmd.getColumnCount(); i++){
						out.print("<td>");
							if(rsmd.getColumnTypeName(i) == "NUMBER"){
								out.print(rs.getInt(i));
							}else if(rsmd.getColumnTypeName(i) == "VARCHAR2"){
								out.print(rs.getString(i));
							}else{
								out.print(rs.getDate(i));
							}
						out.print("</td>");
					}
					out.print("</tr>");
				}
			out.print("</table>");
		}//select if
		else if(sql.startsWith("insert")){
			int result = pstmt.executeUpdate();
			if(result != 0){
				out.print("데이터 삽입 성공");
			}
		}//insert if
		else if(sql.startsWith("update")){
			int result = pstmt.executeUpdate();
			if(result != 0){
				out.print("데이터 수정 성공");
			}
		}//update if
		else if(sql.startsWith("delete")){
			int result = pstmt.executeUpdate();
			if(result != 0){
				out.print("데이터 삭제 성공");
			}
		}//delete if
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		try{
			if(rs != null){
				rs.close();
			}
			pstmt.close();
			conn.close();
		}catch(Exception e){
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
```



## 자바 빈을 이용한 아이템 속성 등록 및 불러오기

**자바 빈 사용 전 itemWrite.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "select * from item";

	try{
		String url="jdbc:oracle:thin:@localhost:1521:XE";
		String uid="scott";
		String pass="TIGER";
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url, uid, pass);
		pstmt = conn.prepareStatement(sql);
		
		rs = pstmt.executeQuery();
		
		out.println("<table border=1>");
		
		while(rs.next()){
			out.println("<tr>");
			out.println("<td>" + rs.getString(1) + "</td>");
			out.println("<td>" + rs.getInt(2) + "</td>");
			out.println("<td>" + rs.getString(3) + "</td>");
			out.println("</tr>");
		}
		
		out.println("</table>");
		
	}catch(Exception e)
	{
		e.printStackTrace();
	}finally{
		if(pstmt!= null)
			pstmt.close();
		if(conn!= null)
			conn.close();
	}
%>
</body>
</html>
```



**자바 빈 사용 후 itemWrite.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="javabeans.ItemBean" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	ItemBean ib = new ItemBean();
	String sql = "select * from item";

	try{
		String url="jdbc:oracle:thin:@localhost:1521:XE";
		String uid="scott";
		String pass="TIGER";
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url, uid, pass);
		pstmt = conn.prepareStatement(sql);
		
		rs = pstmt.executeQuery();
		
		while (rs.next()) {
			ib.setName(rs.getString(1));
			ib.setPrice(rs.getInt(2));
			ib.setDescription(rs.getString(3));
			out.println("<tr>");
			out.println("<td>" + ib.getName() + "</td>");
			out.println("<td>" + ib.getPrice() + "</td>");
			out.println("<td>" + ib.getDescription() + "</td>");
			out.println("</tr>");
		}
		
		out.println("<table border=1>");
		
// 		while(rs.next()){
// 			out.println("<tr>");
// 			out.println("<td>" + rs.getString(1) + "</td>");
// 			out.println("<td>" + rs.getInt(2) + "</td>");
// 			out.println("<td>" + rs.getString(3) + "</td>");
// 			out.println("</tr>");
// 		}
		
		out.println("</table>");
		
	}catch(Exception e)
	{
		e.printStackTrace();
	}finally{
		if(pstmt!= null)
			pstmt.close();
		if(conn!= null)
			conn.close();
	}
%>
</body>
</html>
```


