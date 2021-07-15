<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	int age = Integer.parseInt(request.getParameter("age"));
	if (age <= 19) {
	%>
<script> 
alert("19세 미만 입장 불가");
history.back();
</script>
<% } else {
	request.setAttribute("name","홍길동");
	request.getRequestDispatcher("06_forwardResult.jsp").forward(request, response);
	}
%>

	
</body>
</html>