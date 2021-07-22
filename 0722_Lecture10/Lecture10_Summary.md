# Lecture10 7장 표현 언어와 JSTL

Key Word : JSTL fmt, formatNumber, formatDate, locale, requestEncoding, EL-JTSL 로그인폼, javabean 회원가입폼, SQL, Oracle, DriverManager, JNDI Datasource, InitialContext(), DataSource, init.lookup, Statement, createStatement, prepareStatement

<hr>

## 교재 378p : JSTL fmt 

 JSTL fmt는 JSTL 국제화 지역화 태그로 JSP 페이지에서 다양한 언어를 지원 받을 수 있도록 할 수 있고, 날짜와 숫자 형식을 다루는 데 사용됩니다. fmt 태그는 다음과 같은 종류가 있다.
 
![image](https://user-images.githubusercontent.com/84966961/126575724-fe21fe14-8858-471e-9e8e-f2a5e9db5146.png)

 JSTL fmt 라이브러리를 사용하기 위해서는 JSTL core 처럼 taglib 지시자를 추가하면 된다.

```jsp
 <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
```

<br><br><hr>

### 교재 379p : 숫자 날짜 형식 지정 관련 태그

 보통 블로그의 게시판 처럼 날짜를 "2021.07.22" 와 같은 형태로 출력하고자 할 경우 포맷팅 관련 태그가 사용된다.



<br><br><hr>

### 교재 379p : `<fmt:formatNumber>`

 수치 데이터는 통화량인지 퍼센트인지에 따라 표현하는 형식이 달라야 한다.
 
 ```
    숫자(number) : 1,234,567.89
	퍼센트(percent) : 50%
	통화(currency) : \10,000
```

다음은 표시를 위한 예시이다.

```
	<fmt:formatNumber value="수치 데이터"
			[type="{number|currency|percent}"]
			[pattern="패턴"]
			[currencySymbol="화폐 단위"]
			[groupingUsed="{true|false}"]
			[var="변수 이름"]
			[scope="{page|request|session|application}"]>
```

 다음은 `<fmt:formatNumber>` 태그의 속성을 정리한 표이다.

 속성 | 표현식 | 타입 | 설명 
 -|-|-|-
 value | true | String<br> 또는 Number | 형식화할 수치 데이터
 type | true | String | 숫자(numver), 통화(currency), 퍼센트(percent) 중 어느 형식으로 표시할 지 지정
 pattern | true | String | 사용자가 지정한 형식 패턴
 currencySymbol | true | String | 통화 기호, 통화 형식(type="currency")일 때만 적용
 groupingUsed | true | boolean | 콤마와 같이 단위를 구분할 때 사용하는 기호를 표시할지의 여부를 결정한다. true면 10,000과 같이 구분 기호가 사용되며 false면 10000로 출력된다. 기본값은 true이다.
 var | false | String | 형식 출력 결과 문자열을 담는 scope에 해당하는 변수 이름
 scope | false | String | var 속성에  변수가 효력을 발휘할 수 있는 영역 지정

<br><br>

**`<fmt:formatNumber>` 태그 예시**

```
<fmt:formatNumber value="1234567.89"/>							// 1,234,567.89 세자리 단위 출력
```


<br><br>

**`<fmt:formatNumber>` groupingUsed 속성 예시**

```
<fmt:formatNumber value="1234567.89" groupingUsed="false"/>		// 1234567.89 세자리 단위 출력 없앰
```

<br><br>

**`<fmt:formatNumber>` type="percent" 속성 예시**

```
<fmt:formatNumber value="0.5" type="percent" />					// 50% 출력
```


<br><br>

**`<fmt:formatNumber>` type="currency" 속성 예시**

```
<fmt:formatNumber value="10000" type="currency"/>				// \10,000 출력
```



<br><br>

**`<fmt:formatNumber>` currencySymbol 속성 예시**

```
<fmt:formatNumber value="10000" type="currency" currencySymbol="$"/>		// $10,000 출력
```


<br><br>

**`<fmt:formatNumber>` pattern 속성 예시**

```
<fmt:formatNumber value="1234567.8912345" pattern="#,#00.0#"/>		// 1,234,567.89  소수점 둘째자리까지 표시하는 패턴 지정.
```


<br><br>

**`<fmt:formatNumber>` pattern 속성 예시**

```
<fmt:formatNumber value="1234567.8" pattern="#,#00.0#"/>			// 1,234,567.8  소수점 둘째자리까지이지만 데이터 부족하면 공백처리
```



<br><br>

**`<fmt:formatNumber>` pattern 속성 예시**

```
<fmt:formatNumber value="1234567.8" pattern=".000"/>			// 1234567.889  3자리마다 `,`없이 소수점 이하 3자리까지 
```




<br><br><hr>

### 교재 379p : `<fmt:formatDate>`

 날짜와 시각의 형식을 표현하는 태그이다. 주로 블로그 게시판의 작성 날짜를 출력할 때 작성한다.

```
	<fmt:formatNumber value="수치 데이터"
			[type="{time|date|both}"]
			[dateStyle="{default|short|medium|long|full}"]
			[timeStyle="{default|short|medium|long|full}"]
			[pattern="customPattern"]
			[timeZone="timeZone"]
			[var="변수 이름"]
			[scope="{page|request|session|application}"]>
```

 다음은 `<fmt:formatDate>` 태그의 속성을 정리한 표이다.

 속성 | 표현식 | 타입 | 설명 
 -|-|-|-
 value | true | java.util.Date | 형식화할 Date와 time
 type | true | String | 형식화할 데이터가 시간(time), 날짜(date), 모두(both) 셋 중 하나를 지정.
 dateStyle | true | String | 미리 정의된 날짜 형식으로 default, short, medium, long, full 다섯 중에 하나를 지정.
 timeStyle | true | String | 미리 정의된 시간 형식으로 short, medium, long, full 넷중에 하나를 지정.
 pattern | true | boolean | 사용자 지정 형식 스타일
 timeZone | true | boolean | 형식화 시간에 나타날 타임존 
 var | false | String | 형식 출력 결과 문자열을 담는 scope에 해당하는 변수 이름
 scope | false | String | var 속성에 정한 변수가 효력을 발휘할 수 있는 영역 지정



`<fmt:formatDate>` 태그를 사용하기 위해서는 `<c:set>` 태그를 사용하여 java.util.Date 객체를 생성 해야 한다.

```
	<c:set var="now" value="<%=new java.util.Date()%>"/>		// 현재 시간 날짜 포함한 시간 출력
```

위의 날짜 객체 now를 출력하면 다음과 같아진다.

```
			${now}
			
			Thu Sep 26 04:02:09 KST 2021    // 출력결과
			
```


<br><br>

**`<fmt:formatDate>` type 속성 예시**

```
	<fmt:formatDate value="${now}"/>						// 2021. 7. 22  - yyyy. MM. dd 형태로 출력 
```




<br><br>

**`<fmt:formatDate>` type="time" 속성 예시**

```
	<fmt:formatDate value="${now}" type="time" />			// 오전 10:43:26  - 오전 hh:mm:ss 형태로 출력 
```



<br><br>

**`<fmt:formatDate>` type="both" 속성 예시**

```
	<fmt:formatDate value="${now}" type="both" />			// 2021. 7. 22 오전 10:43:26  - yyyy. MM. dd 오전 hh:mm:ss 형태로 출력 
```




<br><br>

**`<fmt:formatDate>` pattern 속성 예시**

```
	<fmt:formatDate value="${now}" pattern="yyyy년 MM월 dd일 hh시 mm분 ss초" />			// 2021년 7월 22일 10시 43분 26초  - yyyy년 MM월 dd일 hh시 mm분 ss초 형태로 출력 
```



<br><br><hr>

### 교재 386p : `<fmt:setTimeZone>`, `<fmt:timeZone>`

 `<fmt:setTimeZone>` 태그는 특정 지역의 타임존을 설정하는 태그이다. 다음과 같은 형식을 가진다.

```
	<fmt:setTimeZone value="timeZone"
			[var="변수 이름"]
			[scope="{page|request|session|application}"]>
```

 타임존을 부분 적용하는 `<fmt:timeZone>` 태그는 다음과 같은 형식이다.

```
	<fmt:timeZone value="timeZone">
		몸체		
	</fmt:timeZone>
```





<br><br><hr>

### 교재 388p : 로케일 지정을 위한 태그

<br><br>

### 교재 388p : `<fmt:setLacale>`

 각 나라마다 사용하는 화폐의 종류나 날짜를 표현하는 방식이 다르다. 다음은 한국과 미국의 차이이다.
 
 차이점 | 한국 | 미국
-|-|-
통화(currency) | W 10,000 | $10,000.00
날짜 | 2021. 7. 22 | Jul 22, 2021

<br><br>

사용방법

```
	<fmt:setLocale value="locale">			// locale 예시 : "ko_kr", "ja_JP", "en_US", ... 등
```	


<br><br>

### 교재 388p : `<fmt:requestEncoding>`

`<fmt:requestEncoding>` 태그는 post 방식으로 넘어오는 페이지에서 한글 데이터가 깨지지 않도록 하는 역할을 한다. 즉, request.setCharacterEncoding() 메소드와 같은 역할을 한다.

```
	<% request.setCharacterEncoding("UTF-8"); %>
	<fmt:requestEncoding value="UTF-8">
```

 둘 다 같은 기능이다. 본인이라면 굳이 taglib 추가 안하는 자바 코드로 할듯 싶다.
 
 post로 왔을 때 깨지는 현상을 막는다는 점도 기억하자.



<br><br><hr>

### 교재 397p : mission

**loginForm.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="testLogin.jsp">
		<table>
			<tr>
				<td>아이디 :</td>
				<td><input type="text" name="id" size="20" value="moveuk"/></td>
			</tr>
			<tr>
				<td>암 &nbsp; 호 :</td>
				<td><input type="password" name="pwd" size="20" value="1234"/></td>
			</tr>
			<tr>
				<td colspan="2"><input type="radio" name="check" value="사용자"/>사용자<input type="radio" name="check" value="관리자"/>관리자</td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="로그인"/></td>
			</tr>
		</table>
	</form>
</body>
</html>
```

**testLogin.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:if test="${param.id == 'moveuk' && param.pwd == 1234}">
		<div>
			<c:if test="${param.check == '사용자'}">
			${param.id} 님 ${param.check}로 로그인하셨습니다.
			</c:if>
			<c:if test="${param.check == '관리자'}">
			${param.id} 님 ${param.check}로 로그인하셨습니다.
			</c:if>
		</div>
	</c:if>
</body>
</html>
```

choose when otherwise를 사용해도 된다.



<br><br><hr>

### 교재 : mission2

 JTSL 만을 이용해서 회원가입 폼을 만들어보자.
 
 자바 빈도 함께 이용할 것.


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
	<form action="joinAction.jsp" method="post">
		<table>
			<tr>
				<td>이름 </td>
				<td><input type="text" name="name" size="20" value="이동욱"/></td>
			</tr>
			<tr>
				<td>아이디 </td>
				<td><input type="text" name="id" size="20" value="moveuk"/></td>
			</tr>
			<tr>
				<td>암 &nbsp; 호 </td>
				<td><input type="password" name="pwd" size="20" value="1234"/></td>
			</tr>
			<tr>
				<td>이메일 </td>
				<td><input type="email" name="email" size="20" value="v_donguk@naver.com"/></td>
			</tr>
			<tr>
				<td>전화번호 </td>
				<td><input type="tel" name="tel" size="13" value="010-1000-1000"/></td>
			</tr>
			<tr>
				<td>등급 </td>
				<td><input type="radio" name="check" value="관리자" checked/>관리자<input type="radio" name="check" value="일반회원"/>일반회원</td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="전송"/><input type="reset" value="취소"/></td>
			</tr>
		</table>
	</form>
</body>
</html>
```

**JoinBean.java**
```java
package javabeans;

public class JoinBean {
	private String name = "";
	private String id = "";
	private String pwd = "";
	private String email = "";
	private String tel = "";
	private String level = "";
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public JoinBean() {
		super();
	}
	public JoinBean(String name, String id, String pwd, String email, String tel, String level) {
		super();
		this.name = name;
		this.id = id;
		this.pwd = pwd;
		this.email = email;
		this.tel = tel;
		this.level = level;
	}
	@Override
	public String toString() {
		return "<h1>회원의 정보 입력 폼</h1>name : " + name + "<br> id : " + id + "<br> pwd : " + pwd + "<br> email : " + email + "<br> tel : " + tel
				+ "<br> level : " + level + "";
	}
}
```

**joinAction.jsp**
```jsp

<%@page import="javabeans.JoinBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:set var="member" value="<%=new JoinBean()%>" />
	<c:set target="${member }" property="name" value="${param.name }" />
	<c:set target="${member }" property="id" value="${param.id }" />
	<c:set target="${member }" property="pwd" value="${param.pwd }" />
	<c:set target="${member }" property="email" value="${param.email }" />
	<c:set target="${member }" property="tel" value="${param.tel }" />
	<c:set target="${member }" property="level" value="${param.check }" />

	${member }
</body>
</html>
```
**결과 화면**    
![image](https://user-images.githubusercontent.com/84966961/126583287-55fb415e-a4c1-49fe-8a8d-6b4dce80ec0b.png)   
![image](https://user-images.githubusercontent.com/84966961/126583300-53c3dae3-8a41-4548-9fab-0521f777af80.png)




<br><br><hr>

# 교재 400p : 8장 데이터베이스와 JDBC 

<br>

## 교재 410p : SQL
   
 1. SQLDeveloper 를 실행하여 Scoot 계정에서 사용할 Table 생성

```sql
create table member(
    name varchar2(10),
    userid varchar2(10),
    pwd varchar2(10),
    email varchar2(20),
    phone char(13),
    admin number(1) default 0,
    primary key (userid)
);
```
<br><br>

 2. 회원 정보 입력

```sql
insert into member values('이소미', 'somi', '1234', 'gmd@naver.com', '010-2362-5157', 0);
insert into member values('하상오', 'sang12', '1234', 'ha12@naver.com', '010-5629-8888', 1);
insert into member values('김윤승', 'light', '1234', 'youn1004@naver.com', '010-9999-8282', 0);

commit;
```
<br><br>

 3. select 로 회원 확인

```
select * from member;
```

![image](https://user-images.githubusercontent.com/84966961/126592407-d3980e2b-856a-4820-ae48-b8c46252305b.png)


<br><br>

 4. 교재 416p : update

```
update member
set phone = '010-8765-4321'
where userid = 'somi';
```

![image](https://user-images.githubusercontent.com/84966961/126592446-4f892646-dd16-4b45-8561-49bbdbaaceb5.png)


 5. delete

 ```
delete member
where userid='somi';
```

![image](https://user-images.githubusercontent.com/84966961/126592480-3b50d66a-f4a3-4a01-a64e-9a917cd9c4a8.png)

 6. Rollback
-> 데이터가 다시 모두 돌아옴.

![image](https://user-images.githubusercontent.com/84966961/126592521-4cd37b52-e89c-4177-bb3a-5b298334293a.png)



<br><br><hr>

## JDBS를 이용한 데이터 조작하기
   



<br><br><hr>

## Example
   
 JDBC 연결하여 데이터를 조작해보자.
 
 1. DB 
   
```
create table student(
    num number,
    name varchar2(10),
    Primary key(num)
);

insert into student
values (1, '홍길동');

insert into student
values (2, '홍길동');

insert into student
values (3, '고길동');

insert into student
values (4, '김철수');

insert into student
values (5, '김길동');

insert into student
values (6, '김기문');

update student
set name = '김길동'
where num = 2;

select * from student;
```

**결과 화면**    
    
![image](https://user-images.githubusercontent.com/84966961/126593324-2cc7a4bb-41ea-4b7b-9e92-54af3f867064.png)




 2. 오라클 api 배포    
   
주소 : `C:\oraclexe\app\oracle\product\11.2.0\server\jdbc\lib`   
   
![image](https://user-images.githubusercontent.com/84966961/126593685-6ac2d4a6-a9f9-45b7-9f22-446d222555d6.png)   
   
![image](https://user-images.githubusercontent.com/84966961/126593697-a0248d1e-15d8-4477-9cf3-cfaeeccb4520.png)   
   

 3. 교재 438p 참고 : DB 연결

<br>

**JDBC API 사용 어플리케이션의 기본 구성**    
![image](https://user-images.githubusercontent.com/84966961/126594877-8b9ba7aa-25c2-4f80-8e77-823f85ebafe1.png)    
- JDBC 드라이버 : 각 DBMS에 알맞는 클라이언트    
<br><br>

**JDBC 프로그래밍 흐름**
<br>
 1. JDBC 드라이버 로드
	->`Class.forName("oracle.jdbc.driver.OracleDriver");` : Class의 존재 유무 확인
 2. DB 연결
 3. DB에 데이터를 읽거나 쓰기 (SQL문)
 4. DB 연결 종료.

   <br><br>
JDBC 드라이버   
- DBMS와 통신을 담당하는 자바 클래스   
- DMBS 별로 알맞은 JDBC 드라이버 필요 (jar)   
- 로딩코드 : Class.forName(“JDBC드라이버 이름”);   
• MySQL : com.mysql.jdbc.Driver   
• 오라클 : oracle.jdbc.driver.OracleDriver   
• MSSQL : com.microsoft.sqlserver.jdbc.SQLServerDriver   
   <br><br>
JDBC URL   
- DBMS와의 연결을 위한 식별 값   
- JDBC 드라이버에 따라 형식이 다름   
- 구성 : jdbc:[DBMS]:[데이터베이스식별자]   
• MySQL : jdbc:mysql://HOST[:PORT]/DBNAME[?param=value&param1=value2&..]   
• Oracle: jdbc:oracle:thin:@HOST:PORT:SID  
• MS SQL : jdbc:sqlserver://HOST[:PORT];databaseName=DB  



### DataBase Connection Pool

 1. connection pool 이용할 때 사용하는 톰캣 api

![image](https://user-images.githubusercontent.com/84966961/126596654-9a93c6e4-be10-4310-848e-ad6cb5968362.png)


 2. connection pool 속성 설정을 위한 xml 파일 생성

![image](https://user-images.githubusercontent.com/84966961/126598224-8df419c5-57f1-4032-9d69-e299497a366e.png)


```
<?xml version="1.0" encoding="UTF-8"?>
<Context>
	<Resource name="jdbc/oracleDB" 												// 우리가 지정한 이름?
			auth="Container"
            type="javax.sql.DataSource" 										// 타입?
            username="scott" 
            password="tiger" 
            driverClassName="oracle.jdbc.OracleDriver"							// 쓰는 데이터베이스마다 다름.
            factory="org.apache.tomcat.dbcp.dbcp2.BasicDataSourceFactory"		// 커넥션 풀을 사용하기 위한 속성 추가
            url="jdbc:oracle:thin:@127.0.0.1:1521:XE"							// 데이터 베이스 url 값
            maxActive="500" 													// 사용 가능한 커넥션을 500개까지 만들겠다.
            maxIdle="100"/>														// 커넥션 풀에 아이들 상태로 최대 100개까지 여분을 두겠다
</Context>
```

 3. dbcpPool 연결 테스트

```

<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
	Connection conn = null;

	try {
		// javax.naming.Context 네이밍을 사용하여 pool 접근? 라이브러리 추가해줘야함.
		Context init = new InitialContext();
		// xml 파일에 name으로 지정한 값을 lookup으로 호출해줘야함.
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/oracleDB");
		conn = ds.getConnection();
		
		
		out.print("연결 성공");
	} catch (Exception e) {
		out.print("연결 실패");
		e.printStackTrace();
	}
%>
</body>
</html>
```

<br><br>

 4. 데이터 넣기 : statement 활용

**statement.jsp** 
```jsp

<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
Connection conn = null;
String sql = "insert into student (num,name) values (7,'홍길동')";
Statement stmt = null;

try {
	Context init = new InitialContext();
	DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/oracleDB");
	conn = ds.getConnection();
	
	stmt = conn.createStatement();
	
	int result = stmt.executeUpdate(sql); 	// insert delete update - 처리 횟수 리턴
	// executeQuery() 			// select
	if (result != 0) {
		out.print("<h3>레코드 삽입 성공</h3>");
	}
	
	
} catch (Exception e) {
	out.print("<h3>레코드 삽입 실패</h3>");
	e.printStackTrace();
} finally {
	try {
		stmt.close();
		conn.close();
	} catch(Exception e) {
		e.printStackTrace();
	}
}
%>
</body>
</html>
```

**결과 화면**     
첫 번째 삽입시 :   
![image](https://user-images.githubusercontent.com/84966961/126602865-4374d90c-4520-4bb8-b0d4-044a314eaab6.png)

두 번째 삽입시 : 오류 primary key로 설정한 num 이 같기 때문.    
![image](https://user-images.githubusercontent.com/84966961/126602890-87d7c2df-3c61-4fa8-b145-1fc83a692039.png)

![image](https://user-images.githubusercontent.com/84966961/126602933-22b0e2e0-f1cf-429d-96d6-264212ac5433.png)

쿼리 결과 : 잘 들어간 것을 확인할 수 있음.     
![image](https://user-images.githubusercontent.com/84966961/126602992-c62c57ba-692d-4b5c-8b47-191291ecba3e.png)


<br><br>

 5. 데이터 넣기 : preparedStatement 활용

 와일드카드(?)를 사용할 수 있게 되어 쿼리문 하나로 유연하게 여러번 사용할 수 있다.
 
 단, executeUpdate 전 값을 정해주어야 한다.

```

<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
Connection conn = null;
String sql = "insert into student (num,name) values (7,'홍길동')";
Statement stmt = null;

try {
   Context init = new InitialContext();
   DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/oracleDB");
   conn = ds.getConnection();
   
   stmt = conn.createStatement();
   
   int result = stmt.executeUpdate(sql);    // insert delete update - 처리 횟수 리턴
   // executeQuery()          // select
   if (result != 0) {
      out.print("<h3>레코드 삽입 성공</h3>");
   }
   
   
} catch (Exception e) {
   out.print("<h3>레코드 삽입 실패</h3>");
   e.printStackTrace();
} finally {
   try {
      stmt.close();
      conn.close();
   } catch(Exception e) {
      e.printStackTrace();
   }
}
%>
</body>
</html>
```
**결과 화면**   
![image](https://user-images.githubusercontent.com/84966961/126606545-5e0f7fb8-d3a3-4228-95b4-4b0980e4788a.png)   
   
sql db 조회   
![image](https://user-images.githubusercontent.com/84966961/126606594-a968c988-90dd-4044-8664-8ab5dd76ad0d.png)   
   

<br><br><hr>



