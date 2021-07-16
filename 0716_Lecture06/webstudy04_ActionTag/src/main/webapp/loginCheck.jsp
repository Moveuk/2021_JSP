<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

String id = "moveuk";
String pwd = "1234";

if (id.equals(request.getParameter("id")) && pwd.equals(request.getParameter("pwd"))) {%>
	<h3> <%=id %> 로그인 하셨습니다.</h3>
<%} else { %>
	<script>alert("아이디 혹은 비밀번호가 잘못되었습니다.");
	history.go(-1);
	</script>
<%}


%>