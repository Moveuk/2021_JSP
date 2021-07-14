<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
컨텍스트 박스 : <%= request.getContextPath()  %> <br>
요청한 URL : <%= request.getRequestURL() %> <br>
요청한 URI : <%= request.getRequestURI() %> <br>
<br>
---- 위의 3가지가 클라이언트가 요청한 정보이므로 우리가 신경 써야할 중요한 정보이다. <br>
<br>
요청방식 : <%= request.getMethod() %> <br>
서버의 이름 : <%= request.getServerName() %> <br>
프로토콜 : <%= request.getProtocol()  %> <br>
</body>
</html>