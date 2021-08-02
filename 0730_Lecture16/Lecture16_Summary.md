# Lecture16 도전 : 사원 관리 시스템

Key Word : 메인 페이지 구현, 정보 페이지 구현, DAO 기능 구현 (userCheck , getEmployee, updateEmployee), 테스트 10, a태그 form 보내기

<hr>

## 메인 페이지

**main.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body align="center">
<c:import url="header.jsp"/>
<div style="text-align: center;"><h1>회원 전용 페이지</h1></div>
<img alt="" src="images/yuna.jpg" width="30%">
</body>
</html>
```

<br><br><hr>

## 정보 페이지

**mypage.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="mypage.do" method="post" name="frm">
		<table style="text-align: center; margin: 0 auto; width: 50%;">
			<tr>
				<td colspan="2" style="" class="">마이페이지</td>
			</tr>
			<tr>
				<td>아이디</td>
				<td>
					<input type="text" size="20" name="id" readonly="readonly" value="${loginUser.id }">
				</td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td>
					<input type="password" size="20" name="pwd" value="">
				</td>
			</tr>
			<tr>
				<td>이름</td>
				<td>
					<input type="text" size="20" name="name" value="${loginUser.name }">
				</td>
			</tr>
			<tr>
				<td>권한</td>
				<td>
					<select name="lev" id="lev">
						<c:if test="${loginUser.lev == 'A' }">
							<option value="A" selected="selected">운영자</option>
							<option value="B">일반회원</option>
						</c:if>
						<c:if test="${loginUser.lev == 'B' }">
							<option value="A">운영자</option>
							<option value="B" selected="selected">일반회원</option>
						</c:if>
					</select>
				</td>
			</tr>
			<tr>
				<td>성별</td>
				<td>
					<select name="gender" id="gender">
						<c:if test="${loginUser.gender == 1 }">
							<option value="1" selected="selected">남자</option>
							<option value="2">여자</option>
						</c:if>
						<c:if test="${loginUser.gender == 2 }">
							<option value="1">남자</option>
							<option value="2" selected="selected">여자</option>
						</c:if>
					</select>
				</td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td>
					<input type="tel" size="13" name="phone" value="${loginUser.phone }">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="수정">
					<input type="reset" value="취소">
				</td>
			</tr>
		</table>
		<div style="color: red; text-align: center;">${message}</div>
	</form>
</body>
</html>
```

**MypageServlet.java**
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


@WebServlet("/mypage.do")
public class MypageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		EmployeesVO emp = (EmployeesVO) session.getAttribute("loginUser");
		
		if(emp != null) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("mypage.jsp");
			dispatcher.forward(request, response);			
		}
		
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		EmployeesVO eVo = new EmployeesVO();
		EmployeesDAO eDao = EmployeesDAO.getInstance();
		
		eVo.setId(request.getParameter("id"));
		eVo.setPass(request.getParameter("pwd"));
		eVo.setName(request.getParameter("name"));
		eVo.setLev(request.getParameter("lev"));
		eVo.setGender(Integer.parseInt(request.getParameter("gender")));
		eVo.setPhone(request.getParameter("phone"));

		int result = eDao.updateMypage(eVo);
		
		if (result == 1) {
			HttpSession session = request.getSession();
			session.setAttribute("loginUser", eVo);
			request.setAttribute("message", "회원 정보가 수정되었습니다.");
		} else {
			request.setAttribute("message", "회원 정보 수정에 실패하였습니다.");
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("updatesuccess.jsp");
		dispatcher.forward(request, response);
	}

}
```




<br><br><hr>

## DAO : userCheck , getEmployee, updateEmployee

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
	
	public int updateMypage(EmployeesVO eVo) {
		int result = -1;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE EMPLOYEES SET PASS=?, NAME=?, LEV=?, GENDER=?, PHONE=? WHERE ID = ?";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, eVo.getPass());
			pstmt.setString(2, eVo.getName());
			pstmt.setString(3, eVo.getLev());
			pstmt.setInt(4, eVo.getGender());
			pstmt.setString(5, eVo.getPhone());
			pstmt.setString(6, eVo.getId());
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return result;	
	}
}
```


<br><br><hr>

# Test10 JSP

**결과 화면**
![image](https://user-images.githubusercontent.com/84966961/127870996-18576518-ad1b-4d77-ae76-24d59c246bad.png) ![image](https://user-images.githubusercontent.com/84966961/127871023-d63db949-45ed-4156-a4ec-a6f998122564.png)    
![image](https://user-images.githubusercontent.com/84966961/127871052-5a6e0a21-d231-417d-bdeb-1a0d17edb851.png) ![image](https://user-images.githubusercontent.com/84966961/127871076-976fc1d4-a45e-4c3f-8ac8-ce522fdd5866.png)


## a태그로 form 보내기


```js
	function joinCheck() {
		if (document.frm.id.value == "") {
			alert("아이디를 입력해주세요.");
			frm.id.focus();
			return false;
		}
		if (document.frm.password.value == "") {
			alert("비밀번호를 입력해주세요.");
			frm.password.focus();
			return false;
		}
		if (document.frm.name.value.length == 0) {
			alert("이름을 입력해주세요.");
			frm.name.focus();
			return false;
		}
		if (document.frm.age.value.length == 0) {
			alert("나이를 입력해주세요.");
			frm.age.focus();
			return false;
		}
		if (document.frm.gender.value.length == 0) {
			alert("성별을 체크해주세요.");
			frm.age.focus();
			return false;
		}
		if (document.frm.email.value.length == 0) {
			alert("이메일을 입력해주세요.");
			frm.email.focus();
			return false;
		}
		return submitForm();
	}
	function submitForm() {
		var frm = document.frm;
	    frm.setAttribute("id", frm.id.value);
	    frm.setAttribute("password", frm.password.value);
	    frm.setAttribute("name", frm.name.value);
	    frm.setAttribute("age", frm.age.value);
	    frm.setAttribute("gender", frm.gender.value);
	    frm.setAttribute("email", frm.email.value);
		frm.setAttribute("action", "joinProcess.jsp");
		frm.setAttribute("method", "Post");
		frm.submit();
	}
```

## 이외 기능
  - jsp로 db연결하여 구현하였다.
  - 새로운 기술이 접목되지는 않았던 것 같다.





























