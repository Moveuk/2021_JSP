<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	String lang = request.getParameter("lang");

	Cookie cookie = new Cookie("lang", lang);
	cookie.setMaxAge(60*60); // 1시간
	response.addCookie(cookie);
	
%>

<script type="text/javascript">
	location.href="cookieMain.jsp"
</script>