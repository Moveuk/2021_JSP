<%@page import="java.util.Enumeration"%>
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
	session.setAttribute("s_name1", "저는 세션에 저장된 첫 번째 값이에요. ^o^ ");
	session.setAttribute("s_name2", "저는 세션에 저장된 두 번째 값이에요. ^o^ ");
	session.setAttribute("s_name3", "저는 세션에 저장된 세 번째 값이에요. ^o^ ");
	
	out.print(" <h3> >> 세션값을 삭제하기 전 << </h3> ");
	Enumeration names;
	names = session.getAttributeNames();
	while (names.hasMoreElements()) {
		String name = names.nextElement().toString();
		String value = session.getAttribute(name).toString();
		out.println(name +" : " + value + "<br>");
	}
	
	// 설정된 세션의 값들을 모두 사라지도록 한다.
	session.invalidate();
	
	out.print(" <h3> >> 세션값을 삭제한 후 << </h3> ");
	out.print(" Q : 과연 세션 아이디가 유효할까요? <br>");
	if (request.isRequestedSessionIdValid() == true) 
		out.print(" A : 세션 아이디가 유효합니다.<hr>");
	else
		out.print(" A : 세션 아이디가 유효하지 않습니다.<hr>");
%>
</body>
</html>