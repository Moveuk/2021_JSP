<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>

<% 
	request.setCharacterEncoding("UTF-8");	
%>
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
	String sql = "insert into item values(?,?,?)";


	try{
		String url="jdbc:oracle:thin:@localhost:1521:XE";
		String uid="scott";
		String pass="TIGER";
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url, uid, pass);
		pstmt = conn.prepareStatement(sql);
		
		String name = request.getParameter("name");
		String price = request.getParameter("price");
		String description = request.getParameter("description");
		
		pstmt.setString(1,name);
		pstmt.setInt(2,Integer.parseInt(price));
		pstmt.setString(3,description);
		
		pstmt.executeUpdate();
		
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
<a href="itemWrite.jsp">결과보기</a>
</body>
</html>