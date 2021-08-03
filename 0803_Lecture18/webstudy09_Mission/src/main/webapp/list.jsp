<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body align="center">
<table border="1" style="margin: 0 auto;">
	<thead>
		<tr>
			<th colspan="6"><h1> 회원 목록 </h1><div style="color: red;">${message }</div></th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>아이디</td>
			<td>비밀번호</td>
			<td>이름</td>
			<td>권한</td>
			<td>성별</td>
			<td>전화번호</td>
		</tr>
		<c:forEach var="emp" items="${members }">
		<tr>
			<td>${emp.id }</td>
			<td>${emp.pass }</td>
			<td>${emp.name }</td>
			<td>${emp.lev == 'A' ? "운영자" : "일반회원" }</td>
			<td>${emp.gender == 1 ? "남자" : "여자" }</td>
			<td>${emp.phone }</td>
		</tr>
		</c:forEach>
		<tr>
			<td colspan="6" style="color: red;"> 어레이 리스트 이터레이터 사용 </td>
		</tr>
		<% ArrayList<EmployeesVO> members = (ArrayList<EmployeesVO>) request.getAttribute("members");
		Iterator iterator = members.iterator();
		while (iterator.hasNext()) {
			EmployeesVO eVo = (EmployeesVO) iterator.next();
			out.print("<tr>");
				out.println("<td>"+eVo.getId()+"</td>");
				out.println("<td>"+eVo.getPass()+"</td>");
				out.println("<td>"+eVo.getName()+"</td>");
				out.println("<td>"+(eVo.getLev().equals("A") ? "운영자" : "일반회원")+"</td>");
				out.println("<td>"+(eVo.getGender() == 1 ? "남자" : "여자" )+"</td>");
				out.println("<td>"+eVo.getPhone()+"</td>");
			out.print("</tr>");
		}
		%>
		<tr>
			<td colspan="6"><input type="button" value="메인화면으로 이동" onclick="location.href='main.jsp'"></td>
		</tr>
	</tbody>
</table>
</body>
</html>