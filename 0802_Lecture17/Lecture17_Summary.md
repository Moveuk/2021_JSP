# Lecture17 도전 : 사원 관리 시스템 마무리

Key Word : test10 설명, 커스텀조인, 회원가입 폼, 회원가입 성공, DAO 구현, 로그아웃

<hr>

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

