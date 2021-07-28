# Lecture14 JSP, JDBC와 SQL 회원 관리 시스템

Key Word : 회원 가입 기능, 로그아웃 기능, 회원 정보 수정 기능, 유효성 검사 

<hr>

## 로그인한 회원을 위한 main.jsp

**main.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>회원전용 페이지</h2>
	<form>
		<table>
			<tr>
				<td>안녕하세요!, ${loginUser.name }(${loginUser.userid })님</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="로그아웃">
					<input type="button" value="회원정보변경">
				</td>
			</tr>
		</table>
	
	</form>
</body>
</html>
```




<br><br><hr>

## 교재 489p : 회원 가입을 위한 프로그래밍


![image](https://user-images.githubusercontent.com/84966961/127320550-60ffbb45-aac0-4676-9abf-2bb31e9361cf.png)


<br><hr>

### 회원 정보 입력을 위한 서블릿 작성

**JoinServlet.java**
```java
package com.saeyan.cotroller;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.saeyan.dao.MemberDAO;
import com.saeyan.dto.MemberVO;


@WebServlet("/join.do")
public class JoinServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("member/join.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String name = request.getParameter("name");
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("pwd");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String admin = request.getParameter("admin");
		
		MemberVO mVo = new MemberVO();
		mVo.setName(name);
		mVo.setUserid(userid);
		mVo.setPwd(pwd);
		mVo.setEmail(email);
		mVo.setPhone(phone);
		mVo.setAdmin(Integer.parseInt(admin));
		
		MemberDAO mDao = MemberDAO.getInstance();
		int result = mDao.insertMember(mVo);
		
		HttpSession session = request.getSession();
		
		if(result == 1) {
			session.setAttribute("userid", mVo.getUserid());
			session.setAttribute("message", "회원가입에 성공했습니다.");
		} else {
			session.setAttribute("message", "회원가입에 실패했습니다.");
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("member/login.jsp");
		dispatcher.forward(request, response);
	}

}
```




<br><br><hr>

### 회원 정보 입력을 위한 폼 

**join.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="script/member.js"></script>
</head>
<body>
	<h2>회원 가입</h2>
	'*' 표시 항목은 필수 입력 항목입니다.
	<form action="join.do" method="post" name="frm">
		<table>
			<tr>
				<td>이름</td>
				<td><input type="text" name="name" size="20">*</td>
			</tr>
			<tr>
				<td>아이디</td>
				<td><input type="text" name="userid" size="20"  id="userid">* <input
					type="hidden" name="reid" size="20"> <input type="button"
					value="중복 체크" onclick="idCheck()"></td>
			</tr>
			<tr>
				<td>암 호</td>
				<td><input type="password" name="pwd" size="20">*</td>
			</tr>
			<tr height="30">
				<td width="80">암호 확인</td>
				<td><input type="password" name="pwd_check" size="20">*</td>
			</tr>
			<tr>
				<td>이메일</td>
				<td><input type="text" name="email" size="20"></td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td><input type="text" name="phone" size="20"></td>
			</tr>
			<tr>
				<td>등급</td>
				<td><input type="radio" name="admin" value="0"
					checked="checked"> 일반회원 <input type="radio" name="admin"
					value="1"> 관리자</td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="확인"
					onclick="joinCheck()">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="reset" value="취소">
				</td>
			</tr>
			<tr>
				<td colspan="2">${message }</td>
			</tr>
		</table>
	</form>
</body>
</html>
```




<br><br><hr>

### 회원 정보 입력과 중복 체크를 위한 DAO 메소드 구현

**MemberDAO.java**
```java
	// 중복확인 메소드
	public int comfirmID(String userid) {
		int result = -1;
		
		// 중복확인하러 온 아이디가 db에 존재하니? 물음.
		String sql = "select userid from member where userid = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,userid);
			rs = pstmt.executeQuery();
			
			// 값이 있으면 1 없으면 next가 없으므로 false -1
			if(rs.next()) {
				result = 1;
			}else {
				result = -1;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}		
		return result;
	}

	// join.jsp -> join.do 를 통해 날라온 정보를 DAO로 DB에 넣는다.
	public int insertMember(MemberVO mVo) {
		int result = -1;
		String sql = "insert into member values(?, ?, ?, ?, ?, ?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mVo.getName());
			pstmt.setString(2, mVo.getUserid());
			pstmt.setString(3, mVo.getPwd());
			pstmt.setString(4, mVo.getEmail());
			pstmt.setString(5, mVo.getPhone());
			pstmt.setInt(6, mVo.getAdmin());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
```


<br><br><hr>

### 아이디 중복 처리 서블릿 

 아이디 중복 처리도 비슷한 구조이다. 아이디 중복 체크를 위한 서블릿이 컨트롤러로 존재하며 DAO 객체를 통해 DB에 접근하여 정보를 비교하고 다시 리턴해준다. 다만 idCheck는 단순히 DAO에서 확인 절차만 받으면 되므로 doGet 내부에서 한번에 처리된다.    

**idCheckServlet.java**    
```java
package com.saeyan.cotroller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saeyan.dao.MemberDAO;


@WebServlet("/idCheck.do")
public class IdCheckServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 중복확인 위한 id값 param 받음
		String userid = request.getParameter("userid");
		
		// MemberDAO를 통해서 객체 구현 결과값 받음.
		MemberDAO mDao = MemberDAO.getInstance();
		int result = mDao.comfirmID(userid);
		
		// request에 값 저장.
		request.setAttribute("userid", userid);
		request.setAttribute("result", result);
		
		// 같이 보내버림.
		RequestDispatcher dispatcher = request.getRequestDispatcher("member/idcheck.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
```


<br><br><hr>

### 아이디 중복 처리 및 유효성 검사

**member.js**
```js
// 중복체크
function idCheck() {
	if (document.frm.userid.value == "") {
		alert('아이디를 입력하여 주십시오.');
		document.formm.userid.focus();
		return;
	}
	// url ? 아이디 값 get 방식으로 보내서 창 open  url 주소로,
	var url = "idCheck.do?userid=" + document.frm.userid.value;
	window.open(url, "_blank_1",
					"toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=450, height=200");
}

// 중복체크 성공
function idok(userid) {
	// 부모창(opener) userid 인풋값에 값을 넣어줌.
	opener.frm.userid.value = document.frm.userid.value;
	// 히든 인풋에 값을 넣어줌으로써 최종 회원가입시 중복 처리 했는지 확인하기 위한 용임.
	opener.frm.reid.value = document.frm.userid.value;
	self.close();
}

// 회원가입을 위한 유효성 검사
function joinCheck() {
	if (document.frm.name.value.length == 0) {
		alert("이름을 써주세요.");
		frm.name.focus();
		return false;
	}
	if (document.frm.userid.value.length == 0) {
		alert("아이디를 써주세요");
		frm.userid.focus();
		return false;
	}
	if (document.frm.userid.value.length < 4) {
		alert("아이디는 4글자이상이어야 합니다.");
		frm.userid.focus();
		return false;
	}
	if (document.frm.pwd.value == "") {
		alert("암호는 반드시 입력해야 합니다.");
		frm.pwd.focus();
		return false;
	}
	if (document.frm.pwd.value != document.frm.pwd_check.value) {
		alert("암호가 일치하지 않습니다.");
		frm.pwd.focus();
		return false;
	}
	if (document.frm.reid.value.length == 0) {
		alert("중복 체크를 하지 않았습니다.");
		frm.userid.focus();
		return false;
	}
	return true;
}
```



<br><br><hr>

## 교재 505p : 로그아웃 기능

 로그아웃 자체는 간단하다. 로그아웃 버튼을 누르면 logout.do로 이동하여 session을 invalidate 해버리면 된다.

**LogoutServlet.java**
```java
package com.saeyan.cotroller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/logout.do")
public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		session.invalidate();
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("member/login.jsp");
		dispatcher.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
```



<br><br><hr>

## 교재 507p : 회원 정보 수정

회원 정보 수정도 구조는 회원 가입과 똑같다.



<br><br><hr>

### 회원 정보 수정을 위한 서블릿

 회원 정보 수정 버튼을 클릭하면 이 서블릿으로 이동한다. 이후 userid 값을 받아 mDao로 조회를 보내고 받은 mVo 객체를 함께 회원 정보 수정 jsp로 forwarding 해준다.

**MemberUpdateServlet.java**
```java
package com.saeyan.cotroller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saeyan.dao.MemberDAO;
import com.saeyan.dto.MemberVO;

@WebServlet("/memberUpdate.do")
public class MemberUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userid = request.getParameter("userid");
		MemberDAO mDao = MemberDAO.getInstance();
		
		MemberVO mVo = mDao.getMember(userid);
		request.setAttribute("mVo", mVo);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("member/memberUpdate.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 한글 깨짐 방지
		request.setCharacterEncoding("UTF-8");
		// 폼에서 입력한 회원 정보 얻어오기
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("pwd");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String admin = request.getParameter("admin");
		
		// 회원 정보를 저장할 객체 생성
		MemberVO mVo = new MemberVO();
		mVo.setUserid(userid);
		mVo.setPwd(pwd);
		mVo.setEmail(email);
		mVo.setPhone(phone);
		mVo.setAdmin(Integer.parseInt(admin));
		
		MemberDAO mDao = MemberDAO.getInstance();
		mDao.updateMember(mVo);
		
		// 수정하면 제어권 풀어줘야 하므로 리다이렉트로 보냄.
		response.sendRedirect("login.do");
	}

}

```



<br><br><hr>

### 회원 정보 수정을 위한 폼

**memberUpdate.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="script/member.js"></script>
</head>
<body>
<h2>회원 수정</h2>
<form action="memberUpdate.do" method="post" name="frm">
			<table>
			<tr>
				<td>이름</td>
				<td><input type="text" name="name" size="20" value="${mVo.name }"></td>
			</tr>
			<tr>
				<td>아이디</td>
				<td><input type="text" name="userid" size="20"  value="${mVo.userid}" readonly="readonly"></td>
			</tr>
			<tr>
				<td>암 호</td>
				<td><input type="password" name="pwd" size="20">*</td>
			</tr>
			<tr height="30">
				<td width="80">암호 확인</td>
				<td><input type="password" name="pwd_check" size="20">*</td>
			</tr>
			<tr>
				<td>이메일</td>
				<td><input type="text" name="email" size="20" value="${mVo.email}"></td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td><input type="text" name="phone" size="20" value="${mVo.phone}"></td>
			</tr>
			<tr>
				<td>등급</td>
				<td>
				<c:choose>
					<c:when test="${mVo.admin==0}">
					<input type="radio" name="admin" value="0" checked="checked"> 일반회원 
					<input type="radio" name="admin"	value="1"> 관리자
					</c:when>
					<c:otherwise>
					<input type="radio" name="admin" value="0"> 일반회원 
					<input type="radio" name="admin" value="1" checked="checked"> 관리자
					</c:otherwise>
				</c:choose>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="확인" onclick="return joinCheck()">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="reset" value="취소">
				</td>
			</tr>
		</table>
</form>
</body>
</html>
```





<br><br><hr>

### 회원 정보 수정 DAO 메소드 구현

****
```java
	// 회원 정보 수정을 위한 updateMember 메소드
	public int updateMember(MemberVO mVo) {
		int result = -1;
		String sql = "UPDATE member SET pwd=?, email=?, phone=?, admin=? WHERE userid=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, mVo.getPwd());
			pstmt.setString(2, mVo.getEmail());
			pstmt.setString(3, mVo.getPhone());
			pstmt.setInt(4, mVo.getAdmin());
			pstmt.setString(5, mVo.getUserid());
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return result;
	}
```





<br><br><hr>

## 마지막 세션에 로그인 상태시 main으로 바로 이동

 doGet에 if문 걸어서 session에 id가 있으면 로그인 상태로 인식하여 바로 main.jsp로 보냄.


**LoginServlet.java**
```java
@WebServlet("/login.do")
public class LoginServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String url = "member/login.jsp";
		
		HttpSession session = request.getSession();
		
		// 이미 로그인된 상태면 바로 메인으로 보냄.
		if(session.getAttribute("loginUser") != null) {
			url = "main.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request, response);
	}
```





<br><br><hr>
















