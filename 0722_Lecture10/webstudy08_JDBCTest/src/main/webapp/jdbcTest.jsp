<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"  %>
<% 
	Connection conn = null;
	// 메이커마다 정해진 oracle 드라이버명을 사용함.
	String driver = "oracle.jdbc.driver.OracleDriver";
	// 오라클에서 정해준 url 값을 사용함.
	// 1521 : 기본 포트 - 회사에서는 보안을 위해 변경하여 사용함.
	// 마지막 XE 전역변수 값으로 한 서버에 존재하는 여러 개의 데이터 베이스를 구분할 때 설정함.
	String url = "jdbc:oracle:thin:@localhost:1521:XE";

	Boolean connect = false; // 데이터 베이스에 연결했는지 확인하기 위해서 사용.
	
	try {
		// 이런 클래스(오라클 driver)가 존재하는지 확인함
		Class.forName(driver);
		// 데이터베이스 접속
		conn = DriverManager.getConnection(url,"scott","TIGER");
		
		connect = true;
	} catch (Exception e) {
		connect = false;
		e.printStackTrace();
	} finally {
		conn.close();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
	if(connect == true) {
%>		
	연결되었습니다.		
<% 
	} else {
%>
	연결에 실패하였습니다.
<% 
	}
%>


</body>
</html>