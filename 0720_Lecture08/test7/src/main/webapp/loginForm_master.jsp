<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%
	String idcheck = "";
	String userid = "";
	String cookie = request.getHeader("Cookie");
	
	if(cookie!=null){
		Cookie cookies[]=request.getCookies();
		
		for(int i=0;i<cookies.length;i++){
			if(cookies[i].getName().equals("idcheck")){
				idcheck=cookies[i].getValue();
			}
			
			if(cookies[i].getName().equals("userid")){
				userid=cookies[i].getValue();
			}
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	fieldset{
		width : 300px;
		margin : 0 auto;
	}
	label {
		display : inline-block;
		width : 70px;
	}
</style>
</head>
<body>
<fieldset>
    <legend>로그인</legend>
	<form method="post" action="testLogin.jsp">
	<label for="userid"> 아이디 : </label>
	<input type="text" name="id" id="userid" value="<%=idcheck!=""? userid : ""%>"><br>
	
	<label for="userpwd"> 암&nbsp;&nbsp;&nbsp;호 : </label>
	<input type="password" name="pwd" id="userpwd" ><br>
	
	<input type="checkbox" name="idcheck"  <%=idcheck!=""?"checked" : ""%>>아이디 저장
	<br>
	
	<input type="submit" value="로그인">
</fieldset>
</form>
</body>
</html>