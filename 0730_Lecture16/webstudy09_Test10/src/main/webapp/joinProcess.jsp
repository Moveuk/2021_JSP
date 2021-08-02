<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	Connection conn = null;
	Context init = null;
	DataSource ds = null;
	PreparedStatement pstmt = null;
	int result = -1;
	String sql = "INSERT INTO member VALUES (?,?,?,?,?,?)";

	try {
		init = new InitialContext();
		ds = (DataSource) init.lookup("java:/comp/env/jdbc/OracleDB");
		conn = ds.getConnection();
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, request.getParameter("id"));
		pstmt.setString(2, request.getParameter("password"));
		pstmt.setString(3, request.getParameter("name"));
		pstmt.setInt(4, Integer.parseInt(request.getParameter("age")));
		pstmt.setString(5, request.getParameter("gender"));
		pstmt.setString(6, request.getParameter("email"));
		result = pstmt.executeUpdate();
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		try {
		pstmt.close();
		conn.close();			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	if (result == 1) {
		RequestDispatcher dispatcher = request.getRequestDispatcher("member_list.jsp");
		dispatcher.forward(request, response);
	} else {
		response.sendRedirect("loginFrom.jsp");
	}
	
	
%>

