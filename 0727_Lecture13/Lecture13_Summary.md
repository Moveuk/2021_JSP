# Lecture12 JSP, JDBC와 SQL

Key Word : lombok 이용, 회원 관리 시스템 구축, DAO, VO, 로그인 유효성 체크(자바스크립트), userCheck(), getMember()

<hr>

## lombok 라이브러리 배포 : 

1. 다운로드 링크 접속 : https://projectlombok.org/download    

![image](https://user-images.githubusercontent.com/84966961/127077019-c5a2a725-1afb-434d-bbba-65a7f45088ff.png)    

2. 다운로드 후 이클립스 파일위치로 `lombok.jar`를 이동    

![image](https://user-images.githubusercontent.com/84966961/127077488-f1cdf517-2fdf-4c41-aeb1-487dd77b6496.png)    

3. 이동 후 `lombok.jar`파일 더블 클릭   

![image](https://user-images.githubusercontent.com/84966961/127077549-a08abe53-7e60-494a-b055-995c11f1868d.png)

4. 개발환경 툴 뜨는지 확인하고 Install/Update 클릭    

![image](https://user-images.githubusercontent.com/84966961/127077592-4b038e0d-a257-466c-9b9e-a2c1eff10408.png)   
    
**4-1. 만약에 개발환경 툴이 뜨지 않으면 `cmd`창 들어가서 이클립스 폴더 위치에서 `java -jar lombok`치면 자동으로 풀리면서 설치.**    
   
5. 버튼 누르자마자 거의 바로 설치 완료 후 successful 뜸. quit installer 버튼 클릭    

![image](https://user-images.githubusercontent.com/84966961/127077627-13a4f949-8c62-4ef0-ae66-aaaf2dd3511d.png)    

<br>

% 한글 폴더가 있으면 ini 파일에 등록이 안되서 라이브러리 추가가 안됨. 본인은 이클립스를 `C:\Program Files\eclipse` 폴더로 이사함.

<br>

**결과 화면**    
![image](https://user-images.githubusercontent.com/84966961/127081260-d9299f6c-8fcc-4934-b1b5-575e430f8026.png)


<br><br><hr>

# 교재 449p : 데이터베이스를 이용한 회원 관리 시스템 구축하기

<br><hr>

## 교재 450p : 데이터베이스 커넥션 풀 

 데이이터베이스 커넥션 풀(DBCP Database Connection Pool)은 접속 인원이 많은 웹 페이지에서 데이터베이스의 효율성과 속도를 높이기 위해서 사용한다.    

 다음 그림처럼 DB에 연결된 커넥션들을 미리 만들어 커넥션 풀에 넣어놓고 오는 커넥션 요청들을 받아 처리하는 방식이다.   
 
 매번 새로운 커넥션을 만들고 사용 후 지우는 방식보다 더 빠르고 효율적으로 연산이 가능하다.

![image](https://user-images.githubusercontent.com/84966961/127096568-6c57b58d-ab91-4c90-b534-944e2fae2fc3.png)


 커넥션 풀 연결 방법은 두 가지가 있다.
 
 1. 웹 서버 톰캣 server.xml 파일 내부에 context 태그를 추가하여 커넥션 풀 값을 넣어주는 방법.
 2. 프로젝트마다 존재하는 `META-INF` 폴더에 `context.xml` 파일을 작성하여 커넥션 풀에 접근하는 방법.


<br><br><hr>

## 교재 458p : 데이터베이스를 연동한 회원 관리 시스템 

![image](https://user-images.githubusercontent.com/84966961/127097194-d3ffa9ed-1627-4276-bb05-d557e0e52862.png)

기존 사용했던 member 테이블 활용   

![image](https://user-images.githubusercontent.com/84966961/127097506-9424d568-92cd-40cf-86f4-b144a7c8312f.png)    
    
![image](https://user-images.githubusercontent.com/84966961/127097538-be09b17c-5bf2-4aac-84af-c2bbd2b406b6.png)
   



<br><br><hr>

## DAO 사용 전 DB 접속 방법

**former_dbcp.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection" %>
<%@page import="javax.sql.DataSource" %>
<%@page import="javax.naming.InitialContext" %>
<%@page import="javax.naming.Context" %>
<%
	Context initContext = new InitialContext();
	Context envContext = (Context)initContext.lookup("java:/comp/env");
	DataSource ds = (DataSource)envContext.lookup("jdbc/OracleDB");
	Connection conn = ds.getConnection();
	out.print("DBCP 연동 성공");
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

## DAO 사용 후 DB 접속 방법

 싱글턴 패턴을 활용한 DAO 클래스 생성.
 
``` 
// 싱글톤 패턴
// 외부에서 직접 생성이 불가능한 클래스
// 내부에서 한번만 생성된다.

// 싱글톤 패턴 조건
// 1. 생성자는 private해야한다.
// 2. private한 멤버변수가 존재한다.
// 3. public한 메소드가 존재한다.
```

**MemberDAO.java**
```java
package com.saeyan.dao;

import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {

	// static 하게 하여 단일 인스턴스로 만듬.
	private static final MemberDAO MEMBER_DAO = new MemberDAO();
	
	// 기본 생성자는 private하게
	private MemberDAO() {

	}
	
	// 인스턴스를 불러옴. 외부에서 새로 메모리를 잡아먹게 만들 필요가 없음.
	public static MemberDAO getInstance() {
		return MEMBER_DAO;
	}
	
	// 커넥션하는 메소드
	public Connection getConnection() throws Exception {
		Context initContext = new InitialContext();
		DataSource ds = (DataSource) initContext.lookup("java:comp/env/jdbc/OracleDB");
		Connection conn = ds.getConnection();
		
		return conn;
	}
}
```

코드가 깔끔해졌다.   

**dbcp.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.saeyan.dao.MemberDAO" %>
<%@page import="java.sql.Connection" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
// 인스턴스 메모리에서 공유 (getConnection() 불러오기만 하면 되니까 많이 쓸 일이 없음.)
MemberDAO memberDAO = MemberDAO.getInstance();
// 공유한 인스턴스에서 커넥션 불러와서 conn에 저장
Connection conn = memberDAO.getConnection();
out.print("db 연동 성공");
%>	
</body>
</html>
```

**결과 화면**    
![image](https://user-images.githubusercontent.com/84966961/127092593-ae496209-f459-4e8d-b517-ecf12fed84b6.png)    




<br><br><hr>

## 교재 473p : MemberDAO 기능 메소드 구현

다음과 같은 기능을 구현한다.   

 메소드 | 내용
 -|-
 int userCheck(String userid, String pwd) | 사용자 인증시 사용하는 메소드이다.<br> member 테이블에서 아이디와 암호를 비교해서 해당 아이디가 존재하지 않으면 -1을,<br> 아이디만 일치하고 암호가 다르면 0을, 모두 일치하면 1을 리턴한다.
 MemberVO getMember(String userid) | member 테이블에서 아이디로 해당 회원을 찾아 회원 정보를 가져온다.
 int confirmID(String userid) | 회원 가입시 아이디 중복을 확인할 때 사용한다.<br> 해당 아이디가 있으면 1을, 없으면 -1을 리턴한다.
 void insertMember(MemberVO mVo) | 매개 변수로 받은 VO 객체를 member 테이블에 삽입한다.
 void updateMember(MemberVO mVo) | 매개 변수로 받은 VO 객체 내의 아이디로 member 테이블에서 검색해서 VO 객체에 저장된 정보로<br> 회원 정보를 수정한다.




<br><br><hr>

## 교재 473p : 로그인 인증 처리

**login.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>로그인</h2>
	<form action="login.do" method="post">
		<table>
			<tr>
				<td>아이디</td>
				<td>
					<input type="text" name="userid" value="${userid }" />
				</td>
			</tr>
			<tr>
				<td>암호</td>
				<td>
					<input type="password" name="pwd" />
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="로그인">
					<input type="reset" value="취소">
					<input type="button" value="회원가입">
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

### ※ 유효성 체크를 위한 자바스크립트 파일

 로그인 작업을 위해서는 아이디와 암호가 모드 입력되었는지 유효성 파악을 해야한다. 그런데 이 부분은 JSP 공통적으로 사용되는 내용을 포함하기 때문에 하나의 자바스크립트 파일로 분리해놓고 이를 필요할 때마다 사용할 수 있도록 한다.   

**member.js**
```js
function loginCheck() {
	if (document.frm.userid.value.length == 0) {
		alert("아이디를 써주세요");
		frm.userid.focus();
		return false;
	}
	if (document.frm.pwd.value == "") {
		alert("암호는 반드시 입력해야 합니다.");
		frm.pwd.focus();
		return false;
	}
	return true;
}
```

form 태그에 name 속성을 frm으로 지정해주어 js 파일에서 document.frm.userid로 input태그에 접근할 수 있도록 해주었다.

```jsp
	<form action="login.do" method="post" name="frm">
```
**결과 화면**   
![image](https://user-images.githubusercontent.com/84966961/127101446-16273b25-b3b6-46ec-973c-0b93486ebf3a.png)   
![image](https://user-images.githubusercontent.com/84966961/127102981-ab817b29-2bd1-4d20-b9de-3a857f79b920.png)





<br><br><hr>

### 교재 478p : 로그인 입력 폼을 위한 서블릿 클래스

**LoginServlet.java**
```java
package com.saeyan.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/login.do")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		RequestDispatcher dispatcher = request.getRequestDispatcher("member/login.jsp");
		// forward로 보내서 제어권만 보내줌. 주소는 그대로.
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
```

**index.jsp**
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
<a href="login.do"> 로그인 페이지로 이동 </a>
</body>
</html>
```

![image](https://user-images.githubusercontent.com/84966961/127115086-43823ac0-b0cb-4517-8c59-fd9dc19108d4.png)



<br><br><hr>

### ※ 최초 도메인이 이동하는 화면을 설정하는 방법

server > tomcat folder > web.xml 마지막 부분에 있음    

![image](https://user-images.githubusercontent.com/84966961/127104810-8aaed52f-374b-405f-ae7c-e93c11366889.png)   
![image](https://user-images.githubusercontent.com/84966961/127104734-18f1fb6a-fe37-4a99-bc83-a30fe0735118.png)    





<br><br><hr>

### DAO, LoginServlet 기능 구성

**MemberDAO.java**
```java
package com.saeyan.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.saeyan.dto.MemberVO;

public class MemberDAO {

	// static 하게 하여 단일 인스턴스로 만듬.
	private static final MemberDAO MEMBER_DAO = new MemberDAO();
	
	// 기본 생성자는 private하게
	private MemberDAO() {

	}
	
	// 인스턴스를 불러옴. 외부에서 새로 메모리를 잡아먹게 만들 필요가 없음.
	public static MemberDAO getInstance() {
		return MEMBER_DAO;
	}
	
	// 커넥션하는 메소드
	public Connection getConnection() throws Exception {
		Context initContext = new InitialContext();
		DataSource ds = (DataSource) initContext.lookup("java:comp/env/jdbc/OracleDB");
		Connection conn = ds.getConnection();
		
		return conn;
	}
	
	public int userCheck (String userid, String pwd) {
		// 아이디 틀리면 -1
		int result = -1;
		String sql = "select pwd from member where userid=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				if(rs.getString(1) != null && rs.getString(1).equals(pwd)) {
					result = 1;
				} else {
					result = 0;
				}
			} else {
				result = -1;
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
		return result;
	}
	
	public MemberVO getMember(String userid) {
		MemberVO mVo = null;
		String sql = "select * from member where userid = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				mVo = new MemberVO();
				mVo.setName(rs.getString("name"));
				mVo.setUserid(rs.getString("userid"));
				mVo.setPwd(rs.getString("pwd"));
				mVo.setEmail(rs.getString("email"));
				mVo.setPhone(rs.getString("phone"));
				mVo.setAdmin(rs.getInt("admin"));
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
		
		return mVo;
	}
	
}

// 싱글톤 패턴
// 외부에서 직접 생성이 불가능한 클래스
// 내부에서 한번만 생성된다.

// 싱글톤 패턴 조건
// 1. 생성자는 private해야한다.
// 2. private한 멤버변수가 존재한다.
// 3. public한 메소드가 존재한다.
```



**LoginServlet.java**
```java
package com.saeyan.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.saeyan.dao.MemberDAO;
import com.saeyan.dto.MemberVO;

@WebServlet("/login.do")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		RequestDispatcher dispatcher = request.getRequestDispatcher("member/login.jsp");
		// forward로 보내서 제어권만 보내줌. 주소는 그대로.
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
		String url = "member/login.jsp";
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("pwd");
		
		// 객체 생성
		MemberDAO memberDAO = MemberDAO.getInstance();
		// 유저 존재 유무 체킹 메소드 호출
		int result = memberDAO.userCheck(userid, pwd);
		
		if (result == 1) {
			MemberVO mVo = memberDAO.getMember(userid);
			HttpSession session = request.getSession();
			session.setAttribute("loginUser", mVo);
			request.setAttribute("message", "회원 가입에 성공했습니다.");
			url = "main.jsp";
		} else if (result == 0) {
			request.setAttribute("message", "비밀번호가 맞지 않습니다.");
		} else if (result == -1) {
			request.setAttribute("message", "존재하지 않는 회원입니다.");
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request, response);
	}

}

```
<br><hr>

**※ 결과 화면**   
    
 결과를 보기 위해 샘플 데이터 somi / 1234 를 넣었더니 main.jsp 로 이동하는 것을 알 수 있다.   
    
![image](https://user-images.githubusercontent.com/84966961/127116102-35d83fa9-6e7c-4c9a-aac5-0d564edd9961.png)   
![image](https://user-images.githubusercontent.com/84966961/127116122-b2559252-374e-409b-87ac-4c394760c2eb.png)   
![image](https://user-images.githubusercontent.com/84966961/127116263-b1ff8d1d-8f54-434b-ada8-daf9821039f8.png)        
     
 <br><hr>
     
 **※ id가 존재하지 않을 경우**    
![image](https://user-images.githubusercontent.com/84966961/127116443-8da3b33b-cee1-4fdc-97f9-8aa4ae672642.png)
    
<br><hr>
    
 **※ id가 존재하지만 비밀번호가 틀렸을 경우**    
![image](https://user-images.githubusercontent.com/84966961/127116381-75d16322-9492-4b2f-8d8a-2d83e8478215.png)    









 <br><hr>








