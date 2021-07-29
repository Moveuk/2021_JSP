# Lecture15 도전 : 사원 관리 시스템

Key Word : 헤더 로그인 화면 분리, 로그인 기능, DAO 구현, DTO 구현

<hr>

## 개발 환경구성

 개발 전 구조에 대한 구상을 하고 문서화하여 정리하고 시작하는 것이 좋다.   

1. 라이브러리 추가
2. DB 접속 환경 구성 
   - context.xml 파일 구성
   - 테스트

<br><br><hr>

## 로그인 등급 차이에 따른 헤더 구성

**header.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.nav {
	width: 100%;
	min-height: 40px
}

td {
	border: 1px solid black;
	text-align: center;
	min-width: 150px;
}

.navbar:hover {
	background: pink;
	duration: 1s;
}

a {
	text-decoration: none;
}
</style>
<body>
	<table class="nav">
		<tr>
			<!-- 처음 로그인 시도 화면 -->
			<c:if test="${empty loginUser }">
				<td class=""></td>
				<td class=""></td>
				<td class="navbar"><a href="login.do">로그인</a></td>
				<td class="navbar">사원 등록<br> <span style="color: red;">(관리자로 로그인 후 사용가능)</span></td>
				<td class="navbar">마이페이지<br> <span style="color: red;">(로그인 후 사용가능)</span></td>
			</c:if>
			
			<!-- 관리자 / 일반회원 로그인 화면 -->
			<c:if test="${!empty loginUser}">
				<td class="">${loginUser.name }님반갑습니다.</td>
				<td class="">레벨 : ${loginUser.lev }</td>
				<td class="navbar"><a href="logout.do">로그아웃</a></td>
				
				<!-- 관리자 로그인 화면 분기 -->
				<c:choose>
					<c:when test="${result==2 }">
						<td class="navbar"><a href="custom.do" style="text-decoration: none;">사원 등록</a></td>
					</c:when>
					<c:when test="${result==3 }">
						<td class="navbar">사원 등록<br> <span style="color: red;">(관리자로 로그인 후 사용가능)</span></td>
					</c:when>
				</c:choose>
				<td class="navbar"><a href="mypage.do" style="text-decoration: none;">마이페이지</a></td>
			</c:if>
		</tr>
	</table>
</body>
</html>
```

<br>

taglib JSTL import 태그를 이용해서 login.jsp 위에 붙여줌.


**login.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:import url="../header.jsp"/>
	<form action="login.do" method="post">
		<table style="text-align: center; margin: 0 auto; width: 40%;">
			<tr>
				<td colspan="2" style="center;" class="">로그인</td>
			</tr>
			<tr>
				<td>아이디</td>
				<td><input type="text" size="20" name="usrid"></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" size="20" name="usrpwd"></td>
			</tr>
			<tr>
				<td>레벨</td>
				<td>
					<select name="lev" id="lev">
						<option value="A">운영자</option>
						<option value="B">일반회원</option>
					</select>
				</td>
			</tr>
			<tr>
				<td colspan="2">
				<input type="submit" value="로그인"> 
				<input type="reset" value="취소">
				</td>
			</tr>
		</table>
		<div style="color: red; text-align: center;">${message}</div>
	</form>
</body>
</html>
```



<br><br><hr>

## 회원 DTO 구성

**EmployeesVO.java**
```java
package com.manage.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EmployeesVO {
	private String id,pass,name,lev,phone;
	private Date enter;
	private Integer gender;
	
	@Override
	public String toString() {
		return "EmployeesVO [id=" + id + ", pass=" + pass + ", name=" + name + ", lev=" + lev + ", phone=" + phone
				+ ", enter=" + enter + ", gender=" + gender + "]";
	}
}
```



<br><br><hr>

## 회원 DAO 구성 : DAO 싱글턴 패턴 구성, 서버 커넥션, 로그인 체크 기능, 회원 정보 불러오기 기능 구현

**EmployeesDAO.java**
```java
package com.manage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.manage.dto.EmployeesVO;

public class EmployeesDAO {

	private static final EmployeesDAO DAO = new EmployeesDAO();

	private EmployeesDAO() {

	}

	public static EmployeesDAO getInstance() {
		return DAO;
	}

	public Connection getConnection() throws Exception {
		Connection conn = null;
		Context init = null;

		try {
			init = new InitialContext();
			DataSource ds = (DataSource) init.lookup("java:/comp/env/jdbc/OracleDB");
			conn = ds.getConnection();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return conn;
	}

	public int userCheck(String userid, String pwd, String lev) {
	      int result = 1;
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      String sql = "select * from employees where id = ?";
	      
	      try {
	         
	         conn = getConnection();
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, userid);
	         
	         rs = pstmt.executeQuery();
	         
	         if(rs.next()){
	            //비밀번호가 일치하고
	            if(pwd.equals(rs.getString("PASS"))){
	               //회원등급이 일치하면
	               if(lev.equals(rs.getString("LEV"))){
	                  result = 2; //관리자로 로그인 성공
	                  if(lev.equals("B")){
	                     result=3;//일반 회원으로 로그인 성공
	                  }
	               }else{//레벨 불일치 로그인 실패
	                  result =1;
	               }
	            }else{  //비밀번호 불일치 로그인 실패
	               result = 0;
	            }
	         }else{  //아이디 불일치 로그인 실패
	            result = -1;
	         }
	         
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
	      return result;
	   }

	public EmployeesVO getEmployee(String userid) {
		EmployeesVO eVo = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from employees where id = ?";

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				// 인덱스 번호 1번째부터 불러와짐
				eVo = new EmployeesVO();
				eVo.setId(rs.getString(1));
				eVo.setPass(rs.getString(2));
				eVo.setName(rs.getString(3));
				eVo.setLev(rs.getString(4));
				eVo.setEnter(rs.getDate(5));
				eVo.setGender(rs.getInt(6));
				eVo.setPhone(rs.getString(7));
//				eVo = new EmployeesVO();
//				eVo.setId(rs.getString("ID"));
//				eVo.setPass(rs.getString("PASS"));
//				eVo.setName(rs.getString("name"));
//				eVo.setLev(rs.getString("lev"));
//				eVo.setEnter(rs.getDate("ENTER"));
//				eVo.setGender(rs.getInt("GENDER"));
//				eVo.setPhone(rs.getString("PHONE"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				pstmt.close();
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}

		return eVo;

	}
}
```



<br><br><hr>

## 로그인 실행 서블릿 파일 작성

**LoginServlet.java**
```java
package com.manage.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.manage.dao.EmployeesDAO;
import com.manage.dto.EmployeesVO;

@WebServlet("/login.do")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
		dispatcher.forward(request, response);
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String url = "login.jsp";
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		String lev = request.getParameter("lev");
		
		EmployeesDAO instance = EmployeesDAO.getInstance();
		int result = instance.userCheck(id, pwd, lev);
		
		if (result ==2 || result == 3) {
			EmployeesVO eVo = new EmployeesVO();
			eVo = instance.getEmployee(id);
			
			HttpSession session = request.getSession();
			session.setAttribute("loginUser", eVo);
			session.setAttribute("result", result);
			url = "main.jsp";
		} else if (result == 1) {
			request.setAttribute("message", "회원 등급이 맞지 않습니다.");
		} else if (result == 0) {
			request.setAttribute("message", "비밀번호가 맞지 않습니다.");
		} else if (result == -1) {
			request.setAttribute("message", "아이디가 존재하지 않습니다.");
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request, response);
	}

}
```





<br><br><hr>










