# Lecture06 5장 JSP 내장 객체와 액션 태그

Key Word : 쿠키(Cookie), 세션(Session)

<hr>

## 복습

 액션 태그를 이용하여 홈페이지를 구성해보자. 다음은 홈페이지를 구성할 jsp 파일 이름들이다. 다음 최종 화면처럼 구성해보자.

![image](https://user-images.githubusercontent.com/84966961/125874019-bf6ba5df-1a95-4729-be90-bfd2cabfd284.png)

**최종 화면**    
![image](https://user-images.githubusercontent.com/84966961/125874222-374649ee-417e-4e43-99f4-593bfda4ed6f.png)



**top.jsp**
```
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<a href="loginjsp">Login</a>
	<a href="join.jsp">join</a>
```


**left.jsp**
```
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<center><a href="/template.jsp?page=newitem">신상품</a><br><br><a href="/template.jsp?page=bestitem">인기상품</a><br><br></center>
```

**bottom.jsp**
```
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<center>Since 2021</center>
```

**newitem.jsp**
```
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<b>신상품 목록입니다.</b>
```

**bestitem.jsp**
```
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<b>인기 상품입니다.</b>
```

**template**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String pagefile = request.getParameter("page");
	if(pagefile == null) {
		pagefile = "newitem.jsp";
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table width="960px" border="1" align="center">
	<tr>
		<td height="43px" colspan="3" align="left"><jsp:include page="top.jsp"></jsp:include></td>
	</tr>
	<tr>
		<td width="15%" align="right" valign="top"><jsp:include page="left.jsp"></jsp:include></td>
		<td colspan="2" align="center"><jsp:include page='<%=pagefile%>'></jsp:include></td>
	</tr>
	<tr>
		<td width="100%" height="40" colspan="3"><jsp:include page="bottom.jsp"></jsp:include></td>
	</tr>
</table> 
</body>
</html>
```

**결과 화면**    
![image](https://user-images.githubusercontent.com/84966961/125887818-5e95c2c7-b3ac-423e-9467-7216dc9a5734.png)
![image](https://user-images.githubusercontent.com/84966961/125888079-dd50ce44-57aa-412e-b37e-9bfac8872026.png)



**login_master.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");

if(id != null){
	out.print(id + "님 로그인 하셨습니다.");
} else {
%>
 
<form action="./template.jsp?page=loginCheck.jsp" method="post">
	<table>
		<tr>
			<td>아이디 : </td>
			<td><input type="text" name="id" size="20" value="moveuk"></td>
		</tr>
		<tr>
			<td>비밀번호 : </td>
			<td><input type="password" name="pwd" size="20" value="1234"></td>
		</tr>
		<tr>
			<td colspan="2"><input type="submit" value="로그인"></td>
		</tr>
	</table>
</form>

requestDispatcher 방식
<form action="./template.jsp" method="post">
	<table>
		<tr>
			<td>아이디 : </td>
			<td><input type="text" name="id" size="20" value="moveuk"></td>
		</tr>
		<tr>
			<td>비밀번호 : </td>
			<td><input type="hidden" name="page" value="login" ><input type="password" name="pwd" size="20" value="1234"></td>
		</tr>
		<tr>
			<td colspan="2"><input type="submit" value="로그인"></td>
		</tr>
	</table>
</form>
<%}%>
```

**template**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>회원가입</h1>
<form action="./template.jsp?page=joinCheck.jsp" method="post">
	<table>
		<tr>
			<td>아이디 : </td>
			<td><input type="text" name="id" size="20" value="moveuk"></td>
		</tr>
		<tr>
			<td>비밀번호 : </td>
			<td><input type="password" name="pwd" size="20" value="1234"></td>
		</tr>
		<tr>
			<td>이메일 : </td>
			<td><input type="email" name="email" size="20" value="moveuk@naver.com"></td>
		</tr>
		<tr>
			<td>주소 : </td>
			<td><input type="text" name="addr" size="20" value="영등포구"></td>
		</tr>
		<tr>
			<td>전화번호 : </td>
			<td><input type="tel" name="tel" size="20" value="010-1000-1000"></td>
		</tr>
		<tr>
			<td colspan="2"><input type="submit" value="회원가입"></td>
		</tr>
	</table>	
</form>
```

**결과 화면**
![image](https://user-images.githubusercontent.com/84966961/125888093-4171c764-6232-4040-b414-38120cbf1b77.png)
![image](https://user-images.githubusercontent.com/84966961/125888108-60081335-c44a-418f-8683-258ef1a8d188.png)
![image](https://user-images.githubusercontent.com/84966961/125888113-87170074-fe43-4610-8f61-ba5ed7464598.png)
![image](https://user-images.githubusercontent.com/84966961/125888123-7f72dea0-635d-4675-baf7-6bf6e2e70577.png)



<br><br>
<hr>

### 교재 232p : 문제


<br><br>
<hr>

# 교재 233p : 5장 쿠키와 세션

## 쿠키(Cookie)

 인터넷에서 사용 가능한 웹 서비스로는 FTP, HTTP 등이 있다. 이들 서비스는 일정한 규칙을 준수해야 하는데 이를 프로토콜 (표준 인터넷 규약)이라고 한다.   
    
 웹 서비스를 가능하게 하는 프로토콜 중 가장 핵심적인 HTTP 프로토콜은 비 연결 (connectionless) 지향형 통신 프로토콜이다. 즉 쇼핑몰의 장바구니 같은 기능을 할 수 없다는 말이다. 이 통신 방법은 클라이언트가 서버에 정보를 요청하면 웹 서버가 해당 페이지를 클라이언트에게 전송(응답)한 후 연결을 끊는다.   
   
 또 정보를 요청하면 서버는 이전 정보를 기억하지 않고, 새로운 연결을 만든 후 응답한다. 이러한 웹 서버는 이전에 전송한 정보를 전혀 기억하지 못하므로 **무 상태(stateless) 서버**라고 한다. 쇼핑몰의 장바구니 같이 이전 페이지의 정보를 다음 페이지에서도 기억하게 하려면 **비 연결(non connectionless) 지향형 통신 프로토콜인 HTTP**로 웹서비스를 하는 웹페이지에서는 구현하는 데 많은 어려움이 있다.    
   
 이러한 단점을 극복하기 위하여 사용하는 것이 `쿠키`이다. 쿠키는 4KB 이하의 크기로 최대 300개까지의 데이터 정보 배열을 저장할 수 있다. 즉 쿠키의 최대 용량은 4KB X 300개 = 1.2MB가 된다.    
 
<br><br>
<hr>
  
### 쿠키 생성 

1. 쿠키 객체 생성
2. 쿠키에 속성 값 설정
3. response 객체의 addCookie() 메소드를 호출하여 쿠키를 추가 = 클라이언트에 쿠키 저장하도록 명령
    
<br>
 
 쿠키는 클래스 형태로 제공되므로 쿠키 객체를 생선한다. 생성할 때 생성자가 호출된다. 쿠키 생성자는 다음과 같이 두개의 인자를 갖는다. 첫 번째 인자에는 쿠키의 이름을 저장하고 두 번째 인자에는 쿠키의 값을 설정한다.   
   
```java
	// Cookie(java.lang.String name, java.lang.String value);
	Cookie info = new Cookie("testCookie","I am First Cookie!");
```

 Cookie 객체가 생성되었으면 쿠키 관련 메소들을 사용할 수 있다.   


 메소드  |  설명 
 ---|---
void setComment(String)  |   쿠키에 대한 설명을  설정한다
void setDomain(String) |  쿠키의 유효한 도메인을 설정한다.
**void setMaxAge(int)**   |   쿠키의 **유효한 기간을 설정**한다. 
void setPath(String)   |  쿠키의 유효한 디렉토리를 설정한다. 
void setSecure(boolean)   |   쿠키의 보안을 설정한다. 
void setValue(String) |   쿠키의 값을 설정한다. 
void setVersion(int)   |  쿠키의 버전을 설정한다. 
String getComment()   |   쿠키에 대한 설명을 가져온다.
String getDomain() |  쿠키의 유효한 도메인 정보를  가져온다.
int getMaxAge()   |   쿠키의 사용하 수 있는 기간에 대한 정보를 가져온다. 
String getName()  |   쿠키의 이름을 가져온다 
String getPath()   |  쿠키의 유효한 디렉토리 정보를 가져온다. 
boolean getSecure()  |   쿠키의 보안이 어떻게 설정되어 있는지 가져온다. 
String getValue() |   쿠키에 설정된 값을 가져온다. 
int getVersion()  |   쿠키의 버전을 가져온다. 

<br><br>

#### 쿠키의 유효기간 설정 : setMaxAge()


 setMaxAge()에는 초단위로 시간을 설정해야 한다.  다음은 1년간 쿠키가 유효하도록 하는 코드이다.   
    
 주로 우리가 웹페이지에서 자주 볼 수 있는 데 어떤 사이트의 팝업창에서 `일주일 동안 보지 않기`, `하루 동안 보지 않기`와 같은 체크박스 버튼이 있는 것을 볼 수 있다. 이러한 기능을 구현할 때 쿠키의 유효기간을 설정하여 이용하게 된다.    


```
	info.setMaxAge(365*24*60*60);	// 365일
```

 
<br><br>
<hr>
  

### 클라이언트 측 쿠키 생성 및 저장

 response 객체의 addCookie 메소드로 Cookie 클래스로 선언된 객체인 info를 설정하면 클라이언트의 일정 폴더에 info 쿠키의 정보를 기록하게 된다.   

```java
	response.addCookie(info);	// 클라이언트에게 쿠키 전송
```

<br><br>

#### 예제 : 쿠키를 생성하는 JSP

**01_setCookies.jsp**
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
<% 
	// 1. Cookie 객체 생성
	Cookie c = new Cookie("id","moveuk");
	// 2. 유효기간 설정
	c.setMaxAge(365*24*60*60);
	// 3. 클라이언트에 쿠키 전송
	response.addCookie(c);
	// 4. 쿠키를 생성하여 클라이언트에 전송
	response.addCookie(new Cookie("pwd", "test1234"));
	response.addCookie(new Cookie("age", "20"));
%>
<h3> 쿠키 설정 </h3>
</body>
</html>
```

쿠키가 저장되는 곳은 `C:\Users\컴퓨터이름\AppData\Roaming\Microsoft\Windows\Cookies` 내부에 저장된다.   

크롬의 경우에는 브라우저에서 확인할 수 있다. 혹은 `C:\Users\사용자\AppData\Local\Google\Chrome\User Data\Default\Cache`이곳에서 찾을 수 있다.

![image](https://user-images.githubusercontent.com/84966961/125901640-d4419c48-855a-4efa-9678-fe46ac8ea41b.png)

암호화 되어있어 쿠키를 구분할 수가 없다.

![image](https://user-images.githubusercontent.com/84966961/125901812-9aebf122-4f56-4642-af40-6785a5fbac26.png)


 
<br><br>
<hr>
  

### 클라이언트에서 쿠키 불러오기

1. 쿠키 객체를 얻어온다.
2. 쿠키 객체에 설정된 값을 알아낸다.

 클라이언트에 설정된 모든 쿠키를 얻기 위해서는 request 객체의 getCookies() 메소드를 사용하면 된다. 클라이언트에 설정된 쿠키가 여러 개라면 이를 다 제어할 수 있어야 하므로 getCookies 메소드의 리턴값은 배열 형태이다.   

```java
	Cookie[] Cookies = request.getCookies();
```

 향상된 포문을 이용하여 다음과 같이 배열의 값들을 불러내오자.
 
```java
	for (Cookie c : cookies) {
		out.prinln(c.getName()+" : "+c.getValue()+"<br>");
	}
```



<br><br>

#### 예제 : 설정된 모든 쿠키를 얻어와 출력하기


**02_getCookies.jsp**
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
<h3> 클라이언트로부터 얻어온 Cookie </h3>
<%
	Cookie[] cookies = request.getCookies();
	for (Cookie c : cookies) {
		out.print(c.getName()+" : "+c.getValue()+"<br>");
	}
%>
</body>
</html>
```

**결과 화면**    

![image](https://user-images.githubusercontent.com/84966961/125902195-e8ceb549-024e-49d9-ae51-1f45c1fa5895.png)




<br><br>

#### 예제 : id 쿠키 삭제하기


**03_removeCookies.jsp**
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
<%
	Cookie cookie = new Cookie("id", "");
	cookie.setMaxAge(0);	// 쿠키의 유효기간을 만료시킴.
	response.addCookie(cookie);
%>
<h3> id 쿠키가 삭제되었습니다. </h3>
<a href="02_getCookies.jsp">쿠키 삭제를 확인하려면 클릭하세요.</a>
</body>
</html>
```

**결과 화면**    
![image](https://user-images.githubusercontent.com/84966961/125902512-e9c00dd4-e24a-46d8-9aff-1a4fe8a75e1a.png)

![image](https://user-images.githubusercontent.com/84966961/125902540-bae2d27e-d1af-4ef5-a482-91ce855a2906.png)   
   
 id 관련 쿠키가 사라졌다.


<br><br>

#### 예제 : 다국적 언어 사용 홈페이지 구성

쿠키를 활용하여 내부의 데이터 상태를 기억하도록 상태를 남겨둘 수 있다.

**cookieMain.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% 
	String lang = "kor";
	String cookie = request.getHeader("Cookie");
	
	if (cookie != null) {
		Cookie[] cookies = request.getCookies();
		for (Cookie c : cookies) {
			if(c.getName().equals("lang")) {
				lang = c.getValue();				
			}
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
<%
if ( lang.equals("kor")){ %>
	<h2>안녕하세요. 이것은 쿠키 예제입니다.</h2>
<%} else {%>
	<h2>Hello. This is Cookie example.</h2>
<% } %>

	<form action="cookieExample2.jsp" method="post">
		<input type="radio" name="lang" value="kor" <%if(lang.equals("kor")) {%>checked<% } %>>한국어 페이지 보기
		<input type="radio" name="lang" value="eng" <%if(lang.equals("eng")) {%>checked<% } %>>영어 페이지 보기
		<input type="submit" value="설정">
	</form>
</body>
</html>
```

**cookieExample2.jsp**
```jsp
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
```

**결과 화면**    
![image](https://user-images.githubusercontent.com/84966961/125910940-1e72de5f-9876-4c3e-afff-3c424d139b8a.png)    
![image](https://user-images.githubusercontent.com/84966961/125910966-e94fb56d-aec6-493a-ad5d-5fc73b325b25.png)    

