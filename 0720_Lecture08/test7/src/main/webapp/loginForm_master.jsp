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
    <legend>�α���</legend>
	<form method="post" action="testLogin.jsp">
	<label for="userid"> ���̵� : </label>
	<input type="text" name="id" id="userid" value="<%=idcheck!=""? userid : ""%>"><br>
	
	<label for="userpwd"> ��&nbsp;&nbsp;&nbsp;ȣ : </label>
	<input type="password" name="pwd" id="userpwd" ><br>
	
	<input type="checkbox" name="idcheck"  <%=idcheck!=""?"checked" : ""%>>���̵� ����
	<br>
	
	<input type="submit" value="�α���">
</fieldset>
</form>
</body>
</html>