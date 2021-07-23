<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String table = request.getParameter("table");
if (table == null) {
	table = "emp";
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table border="1">
		<tr>
			<td>
				<a href="quiz2_main.jsp?table=emp">emp</a>
				<a href="quiz2_main.jsp?table=dept">dept</a>
				<a href="quiz2_main.jsp?table=salgrade">salgrade</a>
				<form action='quiz2_main.jsp?table=<%=table%>'>

					<select name="table" id="table">
						<option value="emp">emp</option>
						<option value="dept">dept</option>
						<option value="salgrade">salgrade</option>
					</select>
					<input type="submit" value="전송">
				</form>
			</td>
		</tr>		
		<tr>
			<td>
				<form action='quiz2.jsp'>
					<input type="text">
					<input type="submit" value="전송">
				</form>
			</td>
		</tr>
		<tr>
			<td><jsp:include page='quiz2.jsp?table=<%=table%>'></jsp:include></td>
		</tr>
	</table>
</body>
</html>