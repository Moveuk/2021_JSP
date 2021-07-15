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
pageContext.setAttribute("pageScop", "pageValue");
request.setAttribute("requestScope", "requestValue");
%>
	pageScope = <%= pageContext.getAttribute("pageScope") %>
	<br>
	requestScope = <%= request.getAttribute("requestScope") %>
	<jsp:forward page="07_request5Result.jsp"></jsp:forward>
	<% 
	// 제어권 넘기는 두 가지 방법
	// 1. forward로 넘겨야 제어권을 줄 수 있음. (requestDispatcher)
	// 2. <jsp:forward page="request5Result.jsp"
	%>
</body>
</html>