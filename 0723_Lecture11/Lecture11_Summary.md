# Lecture11 JDBC와 SQL

Key Word : ResultSet, MetaData, transaction,

<hr>

## DB 접근을 위한 기본 구성

```jsp
<%@page import="oracle.net.aso.e"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<% 
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "select * from student";
	
	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		conn = ds.getConnection();
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		try {
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
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

## DB 접근 및 select 이용 데이터 가져오기

```jsp
<%@page import="oracle.net.aso.e"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<% 
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "select * from student";

	try {
  		Context init = new InitialContext();
  		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
  		conn = ds.getConnection();
		
  		pstmt=conn.prepareStatement(sql);
  		rs=pstmt.executeQuery();	// select : 반환 타입이 ResultSet이기 때문에 사용함.
		
		out.println("<h3>num&nbsp;&nbsp;&nbsp;&nbsp;name</h3>");	
  		
		while (rs.next()) { 	// while 조건 next() 칼럼 이동하면서 값이 있는지 확인 있으면 true
			out.println("<h3>"+ rs.getInt(1)+", "+		// 컬럼 번호 1번
			rs.getString(2)+"</h3>");					// 컬럼 번호 2번
		}
		
	} catch (Exception e) {
		out.println("<h3> 데이터 가져오기 실패 </h3>");
		e.printStackTrace();
	} finally {
		try {
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
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

## META 정보 사용하기

```jsp
<%@page import="oracle.net.aso.e"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<% 
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "select * from student";
	ResultSetMetaData rsmd = null;

	try {
  		Context init = new InitialContext();
  		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
  		conn = ds.getConnection();
		
  		pstmt=conn.prepareStatement(sql);
  		rs=pstmt.executeQuery();	// select : 반환 타입이 ResultSet이기 때문에 사용함.
		
		// 테이블 생성시의 META 정보 불러오기
		// META 정보 불러오기 위해 필드에 ResultSetMetaData rsmd = null; 을 초기화.
		rsmd = rs.getMetaData(); // resultSet 내부에 들어있는 META 데이타를 끌어옴.
		
		// getColumnCount() 	: 컬럼의 갯수 확인
		// getColumnName() 		: 컬럼의 이름 확인
		// getColumnTypeName() 	: 컬럼의 타입 확인
		
		out.println("컬럼 갯수 : " + rsmd.getColumnCount()+"<br>");
		for (int i = 1; i <= rsmd.getColumnCount(); i++) {
		out.println(i+"번째 컬럼 이름 : " + rsmd.getColumnName(i)+"&nbsp;&nbsp;&nbsp;");
		out.println(i+"번째 컬럼 타입 : " + rsmd.getColumnCount()+"<br>");
		}
		
	} catch (Exception e) {
		out.println("<h3> 데이터 가져오기 실패 </h3>");
		e.printStackTrace();
	} finally {
		try {
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
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
**결과 화면**   
![image](https://user-images.githubusercontent.com/84966961/126727047-9e2a31b2-d49b-44d4-bfa0-583aff0b0848.png)


<br><br><hr>

## META 정보 사용하여 테이블로 데이터 출력하기

```jsp
<%@page import="oracle.net.aso.e"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<% 
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "select * from student order by num";
	ResultSetMetaData rsmd = null;
	
	try {
  		Context init = new InitialContext();
  		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
  		conn = ds.getConnection();
		
  		pstmt=conn.prepareStatement(sql);
  		rs=pstmt.executeQuery();	// select : 반환 타입이 ResultSet이기 때문에 사용함.
		rsmd = rs.getMetaData();	// 메타 데이타 불러옴
  		
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table border="1" style="border-collapse: collapse; width: 300px; text-align: center;">
	<tr>
	<% 	for (int i = 1; i <= rsmd.getColumnCount(); i++) {
			out.println("<th>"+ rsmd.getColumnName(i)+" ("+rsmd.getColumnTypeName(i)+")</th>");
		} %>
	</tr>
	<% while (rs.next()) { 	// while 조건 next() 칼럼 이동하면서 값이 있는지 확인 있으면 true
		out.println("	<tr><td>"+ rs.getInt(1)+"</td><td>"+rs.getString(2)+"</td></tr>");
	} %>
</table>
<% 	} catch (Exception e) {
	out.println("<h3> 데이터 가져오기 실패 </h3>");
	e.printStackTrace();
} finally {
	try {
		rs.close();
		pstmt.close();
		conn.close();
	} catch (Exception e) {
		e.printStackTrace();
	}
} %>

</body>
</html>
```
**결과 화면**    
order by  **전** ----------------------------------------------------------- order by **후**   
![image](https://user-images.githubusercontent.com/84966961/126727720-cf89a287-eece-4c81-a16a-d7135f355981.png) ![image](https://user-images.githubusercontent.com/84966961/126727754-0990d275-653f-4a1d-a841-e259d789f837.png)





<br><br><hr>

## 로직을 만들어 수동 커밋하기

 다음 예제는 12번의 자료가 없는 상태에서 13번을 넣어도 롤백되도록 처리.

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<% 
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "insert into student (num,name) values (13,'새로운')";
	String sql2 = "select * from student where num = 12";

	try {
  		Context init = new InitialContext();
  		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
  		conn = ds.getConnection();
		
  		// 수동 트랜잭션 처리 방법
  		conn.setAutoCommit(false); // 트랜잭션 처리 후 자동 커밋되는것을 false로 중지함
  		
  		pstmt=conn.prepareStatement(sql);	// insert 쿼리문 실행
  		int cnt = pstmt.executeUpdate();	// update 횟수.
		
		
  		pstmt=conn.prepareStatement(sql2);	// 없는 12번 데이터 출력문 -> 오류
  		rs = pstmt.executeQuery();	// select : 반환 타입이 ResultSet이기 때문에 사용함.

  		// 12번이 없어서 null
		if (!rs.next()) {
			conn.rollback();
			out.println("<h3>번호가 일치하지 않아서 롤백 처리</h3>");
		} else {	// rs에 데이터 있으면 커밋 처리
			conn.commit();
		}
		
  		// 다시 자동 커밋처리
		conn.setAutoCommit(true);
  		
	} catch (Exception e) {
		out.println("<h3> 데이터 가져오기 실패 </h3>");
		e.printStackTrace();
	} finally {
		try {
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
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

**결과 화면**   
![image](https://user-images.githubusercontent.com/84966961/126730472-e2df7f5c-0296-4fbb-86cb-44e3b07aad74.png)




<br><br><hr>

SQL Developer 에서 12번을 추가 후 다시 프로그램 실행

![image](https://user-images.githubusercontent.com/84966961/126730843-5b53528c-94b6-4111-ae05-43468893bfc5.png)    

![image](https://user-images.githubusercontent.com/84966961/126730879-bd8686f4-83bb-4920-a138-ee04e647caa7.png)    
     
 transaction.jsp 실행 후
     
![image](https://user-images.githubusercontent.com/84966961/126730928-beab5bf1-0189-4e2a-b172-9bc25c7a30d6.png)   
   
![image](https://user-images.githubusercontent.com/84966961/126730999-31d3d125-89d0-4dc8-ab64-e40f77f2d1b9.png)    




<br><br><hr>

## quiz

emp, dept 테이블을 사용해서 사번, 이름, 부서번호, 부서명, 근무지역 의 칼럼들을 가지는 테이블을 작성하시오.

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<%
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
ResultSetMetaData rsmd = null;
String sql = "select e.empno, e.ename, e.deptno, d.dname, d.loc from emp e, dept d where e.deptno = d.deptno";

try {
	Context init = new InitialContext();
	DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
	conn = ds.getConnection();

	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	rsmd = pstmt.getMetaData();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table border="1" style="border-collapse: collapse; width:600px;">
		<thead>
			<tr>
				<%
				for (int i = 1; i <= rsmd.getColumnCount(); i++) {
					out.println("<th>" + rsmd.getColumnName(i) + "</th>");
				}
				%>
			</tr>
		</thead>
		<tbody>
			<%
			while (rs.next()) {
				out.println("<tr><td>" +rs.getInt(1)+ "</td><td>" +rs.getString(2)+ "</td><td>" +rs.getInt(3)+ "</td><td>" +rs.getString(4)+ "</td><td>" +rs.getString(5)+ "</td></tr>");
			}	

			} catch (Exception e) {
			e.printStackTrace();
			out.print("데이터 처리 실패");
			} finally {

			}
			%>
		</tbody>
	</table>
</body>
</html>
```

**결과 화면**    
![image](https://user-images.githubusercontent.com/84966961/126732190-86f815a9-44fd-4201-94f1-25ba09f2d0ef.png)



<br><br><hr>

## quiz2 : 들어오는 SQL 문에 맞춰서 자동으로 데이터 출력

select * from emp;

select * from dept;

select * from salgrade;

 이 세가지 중 아무거나 들어와도 적용.

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<%
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
ResultSetMetaData rsmd = null;
String sql = "select * from emp";

try {
	Context init = new InitialContext();
	DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
	conn = ds.getConnection();

	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	rsmd = pstmt.getMetaData();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table border="1" style="border-collapse: collapse; width:600px; padding: 2px">
		<thead>
			<tr>
				<%
				for (int i = 1; i <= rsmd.getColumnCount(); i++) {
					out.println("<th>" + rsmd.getColumnName(i) + "</th>");
				}
				%>
			</tr>
		</thead>
		<tbody>
			<%
			while (rs.next()) {
				out.println("<tr>");
				for (int i = 1; i <= rsmd.getColumnCount(); i++) {
					out.println("<td>" +rs.getString(i)+ "</td>");
				}

				out.println("</tr>");
			}	

			} catch (Exception e) {
			e.printStackTrace();
			out.print("데이터 처리 실패");
			} finally {

			}
			%>
		</tbody>
	</table>
</body>
</html>
```

**결과 화면**   
1. **emp**   
![image](https://user-images.githubusercontent.com/84966961/126735120-77649612-d30a-4a91-87ee-82a4bc0317ed.png)   

2. **dept**   
![image](https://user-images.githubusercontent.com/84966961/126734966-32957bcb-87fd-4c7d-83dd-e7256a4b81d1.png)   

3. **Salgrade**   
![image](https://user-images.githubusercontent.com/84966961/126734942-f09e00c9-4e54-4498-981a-e43d02cfa0d1.png)   



<br><br><hr>

## test 08 : 시험

**joinForm.jsp**
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
<fieldset style="text-align: center; width: max-content;">
<h2>회원 정보 입력</h2>
<form action="joinChk.jsp" method="post" >
<table style="margin: 0 auto;">
<tr>
	<td>아이디:&nbsp;&nbsp;&nbsp;</td>
	<td><input type="text" name="usrid" /></td>
</tr>
<tr>
	<td>비밀번호:&nbsp;&nbsp;&nbsp;</td>
	<td><input type="password" name="usrpwd" /></td>
</tr>
<tr>
	<td>이름:&nbsp;&nbsp;&nbsp;</td>
	<td><input type="text" name="usrName" /></td>
</tr>
<tr>
	<td>성별:&nbsp;&nbsp;&nbsp;</td>
	<td><input type="radio" name="usrGender" value="1" checked/>남 <input type="radio" name="usrGender" value="2"/>여</td>
</tr>
<tr>
	<td>나이:&nbsp;&nbsp;&nbsp;</td>
	<td><input type="text" name="usrAge" /></td>
</tr>
<tr>
	<td>이메일주소:&nbsp;&nbsp;&nbsp;</td>
	<td><input type="email" name="usrEmail" /></td>
</tr>
</table>
<input type="submit" value="가입" /> <input type="reset" value="다시 작성" />
</form>
</fieldset>
</body>
</html>
```

**JoinBean.java**
```java
package javabeans;

public class JoinBean {
	private String usrid = "";
	private String usrpwd = "";
	private String usrName = "";
	private String usrGender = "";
	private String usrAge = "";
	private String usrEmail = "";
	public JoinBean() {
		super();
	}
	public JoinBean(String usrid, String usrpwd, String usrName, String usrGender, String usrEmail, String usrAge) {
		super();
		this.usrid = usrid;
		this.usrpwd = usrpwd;
		this.usrName = usrName;
		this.usrGender = usrGender;
		this.usrEmail = usrEmail;
		this.usrAge = usrAge;
	}
	public String getUsrid() {
		return usrid;
	}
	public void setUsrid(String usrid) {
		this.usrid = usrid;
	}
	public String getUsrpwd() {
		return usrpwd;
	}
	public void setUsrpwd(String usrpwd) {
		this.usrpwd = usrpwd;
	}
	public String getUsrName() {
		return usrName;
	}
	public void setUsrName(String usrName) {
		this.usrName = usrName;
	}
	public String getUsrGender() {
		return usrGender;
	}
	public void setUsrGender(String usrGender) {
		this.usrGender = usrGender;
	}
	public String getUsrAge() {
		return usrAge;
	}
	public void setUsrAge(String usrAge) {
		this.usrAge = usrAge;
	}
	public String getUsrEmail() {
		return usrEmail;
	}
	public void setUsrEmail(String usrEmail) {
		this.usrEmail = usrEmail;
	}
	@Override
	public String toString() {
		return "JoinBean [usrid=" + usrid + ", usrpwd=" + usrpwd + ", usrName=" + usrName + ", usrGender=" + usrGender
				 + ", usrAge=" + usrAge + ", usrEmail=" + usrEmail + "]";
	}
}

```

**joinChk.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="member" class="javabeans.JoinBean"/>
<jsp:setProperty property="*" name="member"/>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table style="margin: 0 auto;">
<tr>
	<td><b>아이디:&nbsp;&nbsp;&nbsp;</b></td>
	<td><jsp:getProperty property="usrid" name="member"/></td>
</tr>
<tr>
	<td><b>비밀번호:&nbsp;&nbsp;&nbsp;</b></td>
	<td><jsp:getProperty property="usrpwd" name="member"/></td>
</tr>
<tr>
	<td><b>이름:&nbsp;&nbsp;&nbsp;</b></td>
	<td><jsp:getProperty property="usrName" name="member"/></td>
</tr>
<tr>
	<td><b>성별:&nbsp;&nbsp;&nbsp;</b></td>
	<td><jsp:getProperty property="usrGender" name="member"/></td>
</tr>
<tr>
	<td><b>나이:&nbsp;&nbsp;&nbsp;</b></td>
	<td><jsp:getProperty property="usrAge" name="member"/></td>
</tr>
<tr>
	<td><b>이메일주소:&nbsp;&nbsp;&nbsp;</b></td>
	<td><jsp:getProperty property="usrEmail" name="member"/></td>
</tr>
</table>
</body>
</html>
```

**결과 화면**   

![image](https://user-images.githubusercontent.com/84966961/126747142-6d31b4ac-90bb-478e-9b4f-0a20cd704a0c.png) ![image](https://user-images.githubusercontent.com/84966961/126747147-d4a28949-07a0-4e0b-a8b1-63bf2ee12a9c.png)







