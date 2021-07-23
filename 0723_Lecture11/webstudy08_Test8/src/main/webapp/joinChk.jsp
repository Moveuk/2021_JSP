<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="member" class="javabeans.JoinBean"/>
<jsp:setProperty property="*" name="member"/>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table style="margin: 0 auto;">
<tr>
	<td><b>아이디:&nbsp;&nbsp;&nbsp;</b></td>
	<td><jsp:getProperty property="usrid" name="member"/></td>
</tr>
<tr>
	<td><b>비밀번호:&nbsp;&nbsp;&nbsp;</b></td>
	<td><jsp:getProperty property="usrpwd" name="member"/></td>
</tr>
<tr>
	<td><b>이름:&nbsp;&nbsp;&nbsp;</b></td>
	<td><jsp:getProperty property="usrName" name="member"/></td>
</tr>
<tr>
	<td><b>성별:&nbsp;&nbsp;&nbsp;</b></td>
	<td><jsp:getProperty property="usrGender" name="member"/></td>
</tr>
<tr>
	<td><b>나이:&nbsp;&nbsp;&nbsp;</b></td>
	<td><jsp:getProperty property="usrAge" name="member"/></td>
</tr>
<tr>
	<td><b>이메일주소:&nbsp;&nbsp;&nbsp;</b></td>
	<td><jsp:getProperty property="usrEmail" name="member"/></td>
</tr>
</table>
</body>
</html>