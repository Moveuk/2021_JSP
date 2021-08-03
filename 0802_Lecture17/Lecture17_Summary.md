# Lecture17 : test 10 답안 리뷰 & 사원 관리 시스템 마무리

Key Word : test10 설명, 커스텀조인, 회원가입 폼, 회원가입 성공, DAO 구현, 로그아웃

<hr>

## 테스트 복기

**a태그를 이용한 form 태그 전송**
```js
function joinCheck() {
	if(document.frm.id.value ==""){
		alert("아이디를 입력하세요.");
		frm.id.focus();
		return false;
	}else if(document.frm.pass.value ==""){
		alert("비밀번호를 입력하세요.");
		frm.pass.focus();
		return false;
	}else if(document.frm.name.value ==""){
		alert("이름을 입력하세요.");
		frm.name.focus();
		return false;
	}else if(document.frm.age.value ==""){
		alert("나이를 입력하세요.");
		frm.age.focus();
		return false;
	}else if(document.frm.gender.value ==""){
		alert("성별을 선택하세요.");
		frm.gender.focus();
		return false;
	}else if(document.frm.email.value ==""){
		alert("이메일을 입력하세요.");
		frm.email.focus();
		return false;
	}else {
		document.frm.submit(); //페이지 이동
	}
}
```

**joinForm.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="member.js"></script>
</head>
<body>
	<form name="frm" action="joinProcess.jsp" method="post">
		<table border="1">
			<tr>
				<td colspan="2" align="center">
					<b><font size=5>회원 가입 페이지</font></b>
				</td>
			</tr>
			<tr>
				<td><label for="id">아이디 : </label></td>
				<td><input type="text" name="id"></td>
			</tr>
			<tr>
				<td><label for="pwd">비밀번호 : </label></td>
				<td><input type="password" name="pass"></td>
			</tr>
			<tr>
				<td>이름 : </td>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<td>나이 : </td>
				<td><input type="text" name="age"></td>
			</tr>
			<tr>
				<td>성별 : </td>
				<td><input type="radio" name="gender" value="남">남자
					<input type="radio" name="gender" value="여">여자
				</td>
			</tr>
			<tr>
				<td>이메일 : </td>
				<td><input type="text" name="email"></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<a href="#" onclick="return joinCheck()">회원가입</a>
					<a href="javascript:frm.reset()">다시작성</a>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
```


**joinProcess.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	String name = request.getParameter("name");
	int age = Integer.parseInt(request.getParameter("age"));
	String gender = request.getParameter("gender");
	String email = request.getParameter("email");
	
	Connection conn=null;
	PreparedStatement pstmt=null;
	
	try {
		
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
  		conn = ds.getConnection();
  		
  		pstmt = conn.prepareStatement("insert into member1 values(?,?,?,?,?,?)");
  		pstmt.setString(1, id);
  		pstmt.setString(2, pass);
  		pstmt.setString(3, name);
  		pstmt.setInt(4, age);
  		pstmt.setString(5, gender);
  		pstmt.setString(6, email);
  		
  		int result = pstmt.executeUpdate();
  		
  		if(result != 0){
  			out.println("<script>");
  			out.println("location.href='member_list.jsp'");
  			out.println("</script>");
  		}else{
  			out.println("<script>");
  			out.println("location.href='loginFrom.jsp'");
  			out.println("</script>");
  		}
  		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		try {
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
%>
</body>
</html>
```



**member_info.jsp**
```
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%
	String info_id=request.getParameter("id");
	
	Connection conn=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	
	try {
			Context init = new InitialContext();
			DataSource ds = 
				(DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
			conn = ds.getConnection();
			
			pstmt=conn.prepareStatement("SELECT * FROM member1 WHERE id=?");
			pstmt.setString(1,info_id);
			rs=pstmt.executeQuery();
			if(rs.next()) {%>
			<table border=1 width=300>	
				<tr>
					<td>아이디 : </td><td><%=rs.getString("id") %></td>
				</tr>
				<tr>
					<td>비밀번호 : </td><td><%=rs.getString("pass") %></td>
				</tr>
				<tr>
					<td>이름 : </td><td><%=rs.getString("name") %></td>
				</tr>
				<tr>
					<td>나이 : </td><td><%=rs.getInt("age") %></td>
				</tr>
				<tr>
					<td>성별 : </td><td><%=rs.getString("gender") %></td>
				</tr>
				<tr>
					<td>이메일 주소 : </td><td><%=rs.getString("email") %></td>
				</tr>
				<tr>
					<td colspan=2><a href="member_list.jsp">리스트 돌아가기</a></td>
				</tr>
			</table>
		
	<% }
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		try {
			rs.close();
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
</body>
</html>
```




**member_list.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%
	
	
	Connection conn=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	try {
			Context init = new InitialContext();
			DataSource ds = 
				(DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
			conn = ds.getConnection();
			
			pstmt=conn.prepareStatement("SELECT * FROM member1");
			rs=pstmt.executeQuery();
%>
			<table border=1 width=500>
			<tr align=center>
				<td colspan="5">회원 목록</td>
			</tr>
			<tr align=center>
				<td>아이디</td><td>이름</td><td>나이</td><td>성별</td><td>이메일</td>
			</tr>
			
			<%while(rs.next()){%>
				<tr align=center>
					<td>
						<a href="member_info.jsp?id=<%=rs.getString("id") %>">
							<%=rs.getString("id") %>
						</a>
					</td>
					<td><%=rs.getString("name") %></td>
					<td><%=rs.getInt("age") %></td>
					<td><%=rs.getString("gender") %></td>
					<td><%=rs.getString("email") %></td>
				</tr>
			<%}%>
			</table>
		<%	
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		try {
			rs.close();
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>



</body>
</html>
```





<br><br><hr>

# 도전 이어서

<br><br><hr>

## 회원가입 성공

**joinsuccess.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "header.jsp" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table border = "1" align = "center" width="550px">
		<tr>
			<td colspan="2"><h3>사원 정보</h3><div style="color: red">${message}</div></td>
		</tr>
		<tr>
			<td>아이디</td><td>${member.id }</td>
		</tr>
		<tr>
			<td>비밀번호</td><td>${member.pass }</td>
		</tr>
		<tr>
			<td>이름</td><td>${member.name }</td>
		</tr>
		<tr>
			<td>권한</td>
			<%-- <td>${member.lev }</td> --%>
			<td>
				<c:choose>
					<c:when test="${member.lev == 'A' }">운영자</c:when>
					<c:otherwise>일반회원</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<td>성별</td><td>${member.gender }</td>
		</tr>
		<tr>
			<td>전화번호</td><td>${member.phone }</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type = "button" value = "메인 페이지로 이동" onclick ="location.href='main.jsp'">
				
			</td>
		</tr>
	</table>
</body>
</html>
```

<br><br><hr>

## DAO : insert 추가

**EmployeesDAO.java**
```java
	public void insertMember(EmployeesVO eVo) {
		String sql = "insert into employees values(?,?,?,?,SYSDATE,?,?)";
		Connection conn = null;
		PreparedStatement ptsm = null;
		try {
			conn = getConnection();
			ptsm = conn.prepareStatement(sql);
			ptsm.setString(1, eVo.getId());
			ptsm.setString(2, eVo.getPass());
			ptsm.setString(3, eVo.getName());
			ptsm.setString(4, eVo.getLev());
			ptsm.setInt(5, eVo.getGender());
			ptsm.setString(6, eVo.getPhone());
			ptsm.executeUpdate();
		}catch (Exception e) {
			// TODO: handle exception
		}finally {
			try {
				if(ptsm!=null) {
					ptsm.close();
				}
				if(conn!=null) {
					conn.close();
				}
			}catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
	}
```


<br><br><hr>

## 회원 가입 서블렛


**CustomJoinServlet.java**
```java
package com.magic.controller;

import java.io.IOException;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.magic.dao.EmployeesDAO;
import com.magic.dto.EmployeesVO;

/**
 * Servlet implementation class CustomJoinServlet
 */
@WebServlet("/custom.do")
public class CustomJoinServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		EmployeesVO emp = (EmployeesVO)session.getAttribute("loginUser");
		int result = (Integer)session.getAttribute("result");
		if(emp != null && result == 2 && session!=null) {
			RequestDispatcher rd = request.getRequestDispatcher("customjoin.jsp");
			rd.forward(request, response);
		}else {
			response.sendRedirect("login.do");
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		String name = request.getParameter("name");
		String lev = request.getParameter("lev");
		String gender = request.getParameter("gender");
		String phone = request.getParameter("phone");
		
		
		EmployeesVO eVo = new EmployeesVO();
		eVo.setId(id);
		eVo.setPass(pwd);
		eVo.setName(name);
		eVo.setLev(lev);
		eVo.setGender(Integer.parseInt(gender));
		eVo.setPhone(phone);
		EmployeesDAO eDAO = EmployeesDAO.getInstance();
		eDAO.insertMember(eVo);
		
		request.setAttribute("message","회원 등록이  성공했습니다.");
		request.setAttribute("member", eVo);
		RequestDispatcher dispatcher = request.getRequestDispatcher("joinsuccess.jsp");
		dispatcher.forward(request, response);
	}

}

```


<br><br><hr>

## 회원 가입 폼


**customjoin.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "header.jsp" %>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type = "text/javascript" src = "member.js"></script>
</head>
<body>
	<form action="custom.do" method = "post" name = "frm">
		<table>
			<tr>
				<td colspan="2">마이페이지</td>
			</tr>
			<tr>
				<td> 아이디 </td>
				<td><input name = "id"></td>
			</tr>
			<tr>
				<td> 비밀번호 </td>
				<td><input type = "password"name = "pwd"></td>
			</tr>
			<tr>
				<td> 이름 </td>
				<td><input name = "name"></td>
			</tr>
			<tr>
				<td> 권한 </td>
				<td>
					<select name ="lev">
						<option value = "A">운영자</option>
						<option value = "B">일반회원</option>
					</select>
				</td>
			</tr>
			<tr>
				<td> 성별 </td>
				<td>
					<select name ="gender" >
						<option value = "1">남자</option>
						<option value = "2">여자</option>
					</select>
				</td>
			</tr>
			<tr>
				<td> 전화번호 </td>
				<td colspan="3"><input name = "phone"></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type = "submit" value="등록">
					<input type = "reset" value="취소">
					<input type = "button" value = "메인화면이동하기" onclick="location.href='main.jsp'">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
```

<br><br><hr>

## 로그아웃

**LogoutServlet.java**
```java
package com.magic.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LogoutServlet
 */
@WebServlet("/logout.do")
public class LogoutServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		session.invalidate();
		RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
		dispatcher.forward(request, response);	
		}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	}

}

```

