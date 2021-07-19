<%@page import="org.apache.catalina.filters.CsrfPreventionFilter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
// 실제로는 DB에서 가져와야하는 값
	String id = "moveuk";
	String pwd = "1234";
	String name = "이동욱";
	
	if(id.equals(request.getParameter("id")) && pwd.equals(request.getParameter("pwd"))) {
		// id, pwd가 같을 때만 쿠키 생성하고 client에 추가
		Cookie cookie = new Cookie("username","이동욱");
		
//--------------------------------------------------------
		// 2. 속성 부여
		cookie.setMaxAge(60*60);
		// 3. 클라이언트에 전송
		response.addCookie(cookie);
		
//--------------------------------------------------------
%>
<h2> 성공적으로 로그인하셨습니다. </h2>
<p> <a href="main.jsp"> 들어가기 </a></p>
<%	} else { %>
<h2> 로그인에 실패했습니다. </h2>
<p> <a href="loginForm.jsp"> 되돌아가기 </a></p>
<%	} %>