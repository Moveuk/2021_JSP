<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<h2> <%=request.getParameter("id") %>님 회원가입이 되셨습니다.</h2>
	<h3> 다음과 같은 정보들이 저장되었습니다.</h3>
	
<table>
  <tr>
    <td><h4>아이디 : </h4></td>
    <td><%=request.getParameter("id") %></td>
  </tr>
  <tr>
    <td><h4>비밀번호 : </h4></td>
    <td><%=request.getParameter("pwd") %></td>
  </tr>  
  <tr>
    <td><h4> 이메일 : </h4></td>
    <td><%=request.getParameter("email") %></td>
  </tr>  
  <tr>
    <td><h4> 주소 : </h4></td>
    <td><%=request.getParameter("addr") %></td>
  </tr>  
  <tr>
    <td><h4> 전화번호 : </h4></td>
    <td><%=request.getParameter("tel") %></td>
  </tr>
</table>
