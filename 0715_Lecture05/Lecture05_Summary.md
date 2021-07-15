# Lecture05 4장 JSP 내장 객체와 액션 태그

Key Word : JSP, 내장 객체, 영역 객체, page, request, session, application, 액션 태그, forward, param, include

<hr>


## 복습

다음 그림을 만들어 보자

![image](https://user-images.githubusercontent.com/84966961/125708743-765f73a8-42e5-4de4-9ad8-0825a77a23f6.png)    


**05_requestTest1_Form.jsp**
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
	<h1>Request 예제입니다.</h1>
	<form method="post" action="05_requestTest1.jsp">
		<table border="1">
			<tr>
				<td>이름</td>
				<td><input type="text" name="name" value="홍길동"></td>
			</tr>
			<tr>
				<td>성별</td>
				<td><input type="radio" name="gender" value="남자" checked="checked">남자<input type="radio" name="gender" value="여자">여자</td>
			</tr>
			<tr>
				<td>취미</td>
				<td>독서<input type="checkbox" name="hobby" value="독서" checked>게임<input type="checkbox" name="hobby" value="게임">TV시청<input type="checkbox" name="hobby" value="TV시청" checked>축구<input type="checkbox" name="hobby" value="축구">기타<input type="checkbox" name="hobby" value="기타"></td>
			</tr>
			<tr>
				<td colspan="2"><button type="submit">전송</button></td>
			</tr>
		</table>
	</form>
</body>
</html>
```

**05_requestTest1.jsp**
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
	<h1>Request 예제입니다.</h1>
	<table border="1">
	<% request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	String[] hobbies = request.getParameterValues("hobby");%>
	<tr>
		<td>이름</td>
		<td><%= name %></td>
	</tr>
	<tr>
		<td>성별</td>
		<td><%= gender %></td>
	</tr>
	<tr>
		<td>취미</td>
		<td><% for (String hobby : hobbies) { out.print(hobby+" "); } %></td>
	</tr>
	</table>
	
</body>
</html>
```

**결과 화면**    
![image](https://user-images.githubusercontent.com/84966961/125712444-cfc4feae-257a-44c1-8661-476b53cf6cfc.png) ![image](https://user-images.githubusercontent.com/84966961/125712512-6856cdce-c092-4ab8-9f28-b8355dc60da0.png)



<br><br>
<hr>

## JSP 내장 객체 : 이어서..

**데이터 전송 방식**
데이터 전송 방식 | 특징
---|---
① post | 데이터를 보여주지 않음
② get | 데이터를 파라미터로 주소창에 보여줌.

**페이지 이동 방식**
페이지 이동 방식 | 특징
---|---
① response.sendRedirect(URL) | 제어권을 안넘긴다.(주소값 변경이 있다.)
② request.getRequestDispatcher(URL).forward(request, response) | 제어권을 넘긴다.(주소값 변경이 없다.)

**구조**
![image](https://user-images.githubusercontent.com/84966961/125717627-cbd528a4-c7eb-4c5e-8e22-94801bf608b2.png)

   
 리다이렉트는 제어권을 안넘기기 때문에 저장되어있던 객체가 사라지고 포워드는 리퀘스트 객체에 대한 제어권을 주기 때문에 링크가 유지되어 객체(데이터)가 사라지지 않는다.





#### 교재 199p : forward 방식 - 성년만 입장 가능한 사이트 만들기


**06_redirectForm.jsp**
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
	입장하려면 나이를 입력하세요. <br>
	<form action="06_redirectTest.jsp">
		<input type="text" name="age">
		<input type="submit" value="입장">
	</form>

</body>
</html>
```

**06_redirectTest.jsp**
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
	int age = Integer.parseInt(request.getParameter("age"));
	if (age <= 19) {
	%>
<script> 
alert("19세 미만 입장 불가");
location.href = "06_redirectForm.jsp"
</script>
<% } else {
	request.setAttribute("name","홍길동");
	response.sendRedirect("06_redirectResult.jsp");
	}
%>

	
</body>
</html>
```

**06_redirectResult.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	String age = request.getParameter("age");
	String name = (String) request.getAttribute("name");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>redirect 방식으로 이동된 페이지</h1>
나이 : <%= age %>
이름 : <%= name %>
</body>
</html>
```

**06_forwardForm.jsp**
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
	입장하려면 나이를 입력하세요. <br>
	<form action="06_forwardTest.jsp">
		<input type="text" name="age">
		<input type="submit" value="입장">
	</form>

</body>
</html>
```

**06_forwardTest.jsp**
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
	int age = Integer.parseInt(request.getParameter("age"));
	if (age <= 19) {
	%>
<script> 
alert("19세 미만 입장 불가");
history.back();
</script>
<% } else {
	request.setAttribute("name","홍길동");
	request.getRequestDispatcher("06_forwardResult.jsp").forward(request, response);
	}
%>

	
</body>
</html>
```

**06_forwardResult.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	String age = request.getParameter("age");
	String name = (String) request.getAttribute("name");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>redirect 방식으로 이동된 페이지</h1>
나이 : <%= age %>
이름 : <%= name %>
</body>
</html>
```


**setAttribute, getAttribute**

-> Attribute를 사용하면 key-value 형태로 데이터를 저장하고 타입이 Object이기 때문에 다시 getAttribute로 받아올 때 알맞은 타입으로 캐스팅해줘야 한다.





### application 내장 객체

 application 내장 객체는 하나의 웹 애플리케이션을 관리하고 웹 애플리케이션 안에서의 자원을 공유한다. 하나의 웹 애플리케이션이란 하나의 웹 프로젝트를 의미한다. 지금까지 만든 모든 프로젝트를 의미하는 것이다.    
   
 지금까지는 이번 페이지에서 사용한 정보(자원)를 다음 페이지에서까지 사용하도록 하기 위해서 속성을 새로 생성해서 request 객체에 저장하여 사용했다.   
 
 ```
 				request.setAttribute("name","request man");
 ```

 application 객체도 정보(자원)를 속성에 저장할 수 있다.


 ```
 				application.setAttribute("name","application man");
 ```

 application 객체에 저장된 내용은 **하나의 프로젝트 내의 모든 JSP 페이지에서 공통적으로 사용**할 수 있게 된다.

<br>

메소드 | 설명
---|---
getServerInfo() | 컨테이너의 이름가 버전을 반환한다.
getContextPath() | 웹 애플리케이션의 URL 경로 중 컨텍스트 패스명을 반환한다.
getRealPath() | JSP의 실제 경로를 반환한다.
getMimeType(filename) | 지정된 파일의 MIME 타입을 반환한다.
log(message) | 지정된 message의 로그를 저장한다.




<br><br><hr>

## 교재 204p : 내장 객체의 영역

![image](https://user-images.githubusercontent.com/84966961/125731532-9723e161-e13c-44fa-8ef9-b67892006322.png)

### Page, Session, Request, Applicaion 의 차이점

![image](https://user-images.githubusercontent.com/84966961/125724518-8d5c5eb1-5094-49dd-a570-973887540664.png)   
![image](https://user-images.githubusercontent.com/84966961/125725082-8f532895-5aeb-4ed8-b7f6-434e80a00a91.png)
   
이 네 가지는 공통적으로 데이터 저장을 가지는데 이 들을 구분할 수 있는 큰 차이점은 바로 `유효 범위`이다.   



내장 객체(영역 객체) | 유효 범위 특징
---|---
Page | 현재 페이지 <br> 
**Request** | 제어권을 받은 페이지 <br> 보통 **2~3 page**을 사용하고 객체를 정리하게 된다.
**Session** | 브라우저 <br> 브라우저가 사라지면 정보 객체가 소멸한다. ex) login
Application | 웹 프로그램(서버) <br> 웹 서버가 사라질 때까지 소멸하지 않음. ex) 서버 개설 후 방문수 체크 등.. 

 **bold** : 웹 페이지에서 주로 사용하는 영역 객체


### 데이터를 읽고 쓰는 메소드 : setAttribute, getAttribute, removeAttribute

 앞의 네 영역 객체에서 공통적으로 데이터를 읽고 쓸 때는 setAttribute, getAttribute를 삭제할 때는 removeAttribute를 사용한다. 


<br><br><hr>


### 예제 : Application과 Session

![image](https://user-images.githubusercontent.com/84966961/125738301-fca56cb7-58c5-4d93-a164-b50751be2eb2.png)

**07_attrtest1_form.jsp**
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
<form action="07_attributeTest.jsp" method="post">
	<table>
		<tr>
			<td colspan="2">Application영역 저장</td>
		</tr>
		<tr>
			<td>이름</td>
			<td><input name="name"></td>
		</tr>
		<tr>
			<td>아이디</td>
			<td><input name="id"></td>
		</tr>
		<tr>
			<td colspan="2"><input type="submit" value="전송"></td>
		</tr>
	</table>
</form>
</body>
</html>
```

**07_attributeTest.jsp**
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
	// request 는 값을 받아올때 보낸 곳과 같이 인코딩을 해줘야함.
	request.setCharacterEncoding("UTF-8"); 
	String name = request.getParameter("name");
	String id = request.getParameter("id");
	
	if (!(name==null || id==null)) {
		application.setAttribute("name", name);
		application.setAttribute("id", id);
	}
	%>
	
	<h3><%= name %>님 반갑습니다. 아이디는 <%= id %>입니다.</h3>
	
	<form action="07_attributeTest2.jsp" method="post">
	<table>
		<tr>
			<td colspan="2">Session 영역에 저장</td>
		</tr>
		<tr>
			<td>Email주소</td>
			<td><input name="email"></td>
		</tr>
		<tr>
			<td>집주소</td>
			<td><input name="addr"></td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td><input name="tel"></td>
		</tr>
		<tr>
			<td colspan="2"><input type="submit" value="전송"></td>
		</tr>
	</table>
</form>
	
</body>
</html>
```

**07_attributeTest2.jsp**
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
	// request 는 값을 받아올때 보낸 곳과 같이 인코딩을 해줘야함.
	request.setCharacterEncoding("UTF-8"); 
	String email = request.getParameter("email");
	String addr = request.getParameter("addr");
	String tel = request.getParameter("tel");
	
	session.setAttribute("email", email);
	session.setAttribute("addr", addr);
	session.setAttribute("tel", tel);
	
	String name = (String) application.getAttribute("name");
	%>
	
	<h3><%= name %>님의 정보가 모두 저장 되었습니다.</h3>
	<a href = "07_attributeTest3.jsp">확인하러 가기</a>
</body>
</html>
```

**07_attributeTest3.jsp**
```jsp
<%@page import="java.util.Enumeration"%>
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
	request.setCharacterEncoding("UTF-8"); 
	String name = (String) application.getAttribute("name");
	String id = (String) application.getAttribute("id");
	String email = (String) session.getAttribute("email");
	String addr = (String) session.getAttribute("addr");
	String tel = (String) session.getAttribute("tel");
	%>
	
	<b>Application 방식 불러오기<br></b>
	<%= name %><br>
	<%= id %><br>
	<br>
	<b>Session 방식 불러오기<br></b>
	<%= email %><br>
	<%= addr %><br>
	<%= tel %><br>
	<br><br>
	<b><%= "enumeration을 통해 출력한 값들" %></b>
	<table border="1">
		<% 
		Enumeration e = session.getAttributeNames();
		while(e.hasMoreElements()) {
			String attributeName = (String) e.nextElement();
			String attributeValue = (String) session.getAttribute(attributeName);
		%>

		<tr>
			<td> <%= attributeName %></td>
			<td> <%= attributeValue %></td>
		</tr>
		<%
		}%>
	</table>
	<br><br>
			<% 
			Enumeration e2 = session.getAttributeNames();
		while(e2.hasMoreElements()) {
			String attributeName = (String) e2.nextElement();
			String attributeValue = (String) session.getAttribute(attributeName);
			out.print(attributeValue);}
		%>
	
</body>
</html>
```

   
**결과 화면**
![image](https://user-images.githubusercontent.com/84966961/125738696-e68d7395-c8c4-4637-a4fc-44bba1d0095f.png)
![image](https://user-images.githubusercontent.com/84966961/125738736-eebd8eca-f7bb-47d9-8c9b-7791b629b993.png)
![image](https://user-images.githubusercontent.com/84966961/125738750-72a23510-9de0-4626-8367-ccc614b80e9f.png)
![image](https://user-images.githubusercontent.com/84966961/125738773-7cc7f2a9-c9d7-449e-829c-daeef4192eb3.png)






<br><br><hr>

#### Applicaion과 Session의 유효 범위

Application에 set한 데이터들은 웹 서버인 Tomcat이 꺼지기 전까지 존재하므로 웹 서버를 껐다 키고 페이지를 새로고침 하게 되면 다음과 같이 null 값이 나오게 된다.   

![image](https://user-images.githubusercontent.com/84966961/125738603-de4c3532-4dc5-4292-ae50-ad9329209b93.png)



<br><br><hr>


### 예제 : Page와 Request의 forward

<br>

**제어권 넘기는 두 가지 방법**   
 1. forward로 넘겨야 제어권을 줄 수 있음. (requestDispatcher)   
 2. <jsp:forward page="request5Result.jsp"   


**07_attributeTest4.jsp**
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
pageContext.setAttribute("pageScop", "pageValue");
request.setAttribute("requestScope", "requestValue");
%>
	pageScope = <%= pageContext.getAttribute("pageScope") %>
	<br>
	requestScope = <%= request.getAttribute("requestScope") %>
	
</body>
</html>
```

**07_attributeTest5.jsp**
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
pageContext.setAttribute("pageScop", "pageValue");
request.setAttribute("requestScope", "requestValue");
%>
	pageScope = <%= pageContext.getAttribute("pageScope") %>
	<br>
	requestScope = <%= request.getAttribute("requestScope") %>
	<jsp:forward page="request5Result.jsp"></jsp:forward>
	<% 
	// 제어권 넘기는 두 가지 방법
	// 1. forward로 넘겨야 제어권을 줄 수 있음. (requestDispatcher)
	// 2. <jsp:forward page="request5Result.jsp"
	%>
</body>
</html>
```

**07_request5Result.jsp**
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
	pageScope = <%= pageContext.getAttribute("pageScope") %>
	<br>
	requestScope = <%= request.getAttribute("requestScope") %>
</body>
</html>
```

**결과 화면**    
07_attributeTest4
![image](https://user-images.githubusercontent.com/84966961/125741173-91eb2010-4788-4bd6-975a-45962f8fa5ab.png)
07_attributeTest5 -> 07_request5Result
![image](https://user-images.githubusercontent.com/84966961/125741208-ac915e95-e5b8-4889-ab3d-367b40acd7b2.png)



test4 에서 page에 데이터를 저장하고 바로 불러올 수 있는 반면 test5에서 forward를 통해 다른 페이지로 넘어가게 되면 page 데이터는 얻지 못하고 request 데이터만 남아있는 것을 알 수 있다.





<br><br><hr>

## 교재 212p : 액션 태그

태그의 종류 | 설명
---|---
`<jsp:forward>` | 다른 사이트로 이동할 때 사용<br> 페이지의 흐름을 제어할 때 사용 
`<jsp:include>` | 정적 혹은 동적인 자원을 현재 페이지의 내용에 포함시킨다<br> 페이지를 모듈화할 때 사용
`<jsp:param>` | `<jsp:forward>`, `<jsp:include>`, `<jsp:pulgin>`과 같이 사용되어 파라미터를 추가할 때 사용
`<jsp:useBean>` | 빈(Bean)을 생성하고 사용하기 위한 환경을 정의하는 액션 태그
`<jsp:setProperty>` | 액션은 빈에서 속성 값을 할당
`<jsp:getProperty>` | 액션은 빈에서 속성 값을 얻어올 때 사용


### 교재 213p : `<jsp:forward>` 액션 태그

`<jsp:forward>` 태그는 현재 JSP 페이지에서 URL로 지정한 특정 페이지로 넘어갈 때 사용하는 태그이다.

```jsp
<jsp:forward page="relativeURLspec"/>
```

 포워드 방식으로 페이지를 이동하는 것으로 기존의 request 연결을 유지하면서 서버상의 url로 request 정보를 전달한다. 서블릿 상에서 다음코드와 동일한 동작을 한다.
 
 ```java
 RequestDispatcher dispatchr = getServletContext().getResquestDispatcher("url");
 dispatcher.forward(request, response);
 ```
 
<br><br>

 #### 예제
 
 red.jsp와 yellow.jsp 를 통해 forward 액션 태그에 대해 알아보자.   

**08_red.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body bgcolor="red">
이 파일은 red.jsp입니다. <br>
브라우저에 배경색이 빨간색으로 나타날까요? <br>
노란색으로 나타날까요? <hr>
forward 액션 태그가 실행되면 이 페이지의 내용은 출력되지 않습니다.  <br>
<jsp:forward page="08_yellow.jsp"></jsp:forward>
</body>
</html>
```


**08_yellow.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body bgcolor="yellow">
<h3> [forward 액션 태그에 대한 예쩨]</h3>
<hr>
이 파일은 yellow.jsp 입니다.
<br>
<hr>
브라우저에 나타나는 URL과 전혀 상관없는 파일입니다.

</body>
</html>
```

**결과 화면**    
![image](https://user-images.githubusercontent.com/84966961/125745316-5014f4c6-c148-4006-8aed-f899f9837a0e.png)




### 교재 216p : `<jsp:param>` 액션 태그

`<jsp:forward>` 액션 태그로 이동하는 페이지에 정보를 추가하고 싶을 경우가 있다. 이럴 경우 사용하는 액션 태그가 `<jsp:param>`이다.    

```jsp
<jsp:forward page="이동할 페이지 경로">
    <jsp:param name="파라미터" value="파라미터값" />
</jsp:forward>
```


<br><br>

 #### 예제 : parameter 활용
 
 

**09_actionTagForm.jsp**
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
<form action="09_actionTagTest.jsp">
	<table>
		<tr>
			<td>아이디 : </td>
			<td><input type="text" name="id" value="Moveuk" size="30"></td>
		</tr>
		<tr>
			<td>암 &nbsp; 호 : </td>
			<td><input type="password" name="pwd" value="password" size="30"></td>
		</tr>
		<tr>
			<td colspan="2"><input type="radio" name="loginCheck" value="user" checked="checked">사용자 <input type="radio" name="loginCheck" value="관리자"> 관리자 </td>
		</tr>
		<tr>
			<td colspan="2"><input type="submit" value="로그인"></td>
		</tr>
	</table>
</form>
</body>
</html>
```


**09_actionTagTest.jsp**
```jsp
<%@page import="java.net.URLEncoder"%>
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
	String userID = request.getParameter("id");
	String userPWD = request.getParameter("pwd");
	String loginCheck = request.getParameter("loginCheck");
	
	if (loginCheck.equals("user")) {
	%>
	<jsp:forward page="09_userMain.jsp">
		<jsp:param value='<%=URLEncoder.encode("전고객","UTF-8")%>' name="userName"/>
	</jsp:forward>
	<% } else { %>
	<jsp:forward page="09_managerMain.jsp">
		<jsp:param value='<%=URLEncoder.encode("성관리","UTF-8")%>' name="userName"/>
	</jsp:forward>
	<% } %>
</body>
</html>
```

**09_userMain.jsp**
```jsp
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body bgcolor="pink">
	<h3>사용자로 로그인 성공 </h3>
	<%=URLDecoder.decode(request.getParameter("userName"), "UTF-8")%>
	(<%=request.getParameter("userID") %>)님 환영 합니다.
</body>
</html>
```


**09_managerMain.jsp**
```jsp
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body bgcolor="yellow">
	<h3>관리자로 로그인 성공 </h3>
	<%=URLDecoder.decode(request.getParameter("userName"), "UTF-8")%>
	(<%= request.getParameter("userID") %>)님 환영 합니다.
</body>
</html>
```


**결과 화면**    
![image](https://user-images.githubusercontent.com/84966961/125748529-2a51dd57-eb75-488b-9703-85ad8d275757.png)     
![image](https://user-images.githubusercontent.com/84966961/125748453-610bd202-1859-4cae-8ef6-558691668e8b.png)   
![image](https://user-images.githubusercontent.com/84966961/125748499-5596bbf6-7214-4410-a434-cfaa6fbb71b8.png)   






### 교재 216p : `<jsp:include>` 액션 태그

 웹사이트를 구축하다보면 페이지 상단의 로고나 메인 메뉴, 페이지 하단의 저작권 표시 등은 모든 페이지에서 공통적으로 사용된다.   
 
 이런 공통된 내용까지 하나의 JSP 페이지에 기술하고 다른 페이지에서 이 내용이 필요할 때 코드를 복사 붙여넣기 하는 것보다는 페이지 상단에 보여야 할 로고나 메인 메뉴는 header.jsp에 페이지, 하단에 보여야 할 저작권에 표시 등은 footer.jsp로 나누어 두고 본문에 해당되는 내용을 기술하는 페이지에서 이들 header.jsp와 footer.jsp를 동적으로 포함하는 것이 좋다. 이렇게 현재 페이지에 다른 페이지의 내용을 동적으로 포함시키고자 할 경우 사용하는 액션 태그가 `<jsp:include>` 태그 이다.
 
 
 
```

                  페이지 상단
                
        <jsp:include page='header.jsp'/>
        
                  ....
                  
                  
                  ....
                  
                  
                  ....
                  
                 

        <jsp:include page='footer.jsp'/>


                  페이지 하단

```

 다음은 `<jsp:include>` 태그의 형식이다.
 
```jsp
 <jsp:include page="urlSpec" flush="true" 또는 "false"/>
```

 flush 속성은 출력 버퍼에 저장되어 있는 데이터를 내준다는 의미로 사용된다.   


<br><br>

### 교재 216p : `<jsp:include>` 액션 태그와 `<% include file='url' %>` 지시자의 차이

`<% include file='url' %>` 지시자는 지정된 페이지가 현재 페이지에 포함되어서 하나로 합쳐진 상태에서 컴파일 하여 실행되는 구조이다. 포함되는 페이지를 독립적인 형태가 아니고 페이지의 일부분으로 구성할 수 있다. 즉, **변수를 서로 공유해서 사용**할 수 있다.   
   
![image](https://user-images.githubusercontent.com/84966961/125750271-7915e234-2114-4a82-8622-0bd261def1d4.png)      
   
<br>
   
 하지만 `<jsp:include>` 액션 태그는 컴파일할 때 합쳐지지 않고 제어권이 지정한 페이지로 넘어갔다가 다시 되돌아온다. 서로 독립적으로 컴파일되고 실행할 때 독립적으로 실행되는 두 페이지가 서로 연락을 취하여 하나의 페이지인 것처럼 동작하기 때문에 **변수를 서로 공유해서 사용할 수 없다.** 그러므로 포함될 페이지가 독립적인 하나의 페이지여야만 한다.   
   
![image](https://user-images.githubusercontent.com/84966961/125750618-c80d082a-9b5a-49db-a74b-7e1128a5dedc.png)   
   



<br><br>

 #### 예제 : `<jsp:include>` 액션 태그를 사용한 모듈화

| 지시자와 액션 태그 | 정적 vs 동적 | 차이점 |
|---|---|---|
| `<% include file='url' %>` 지시자 |  정적 페이지 | 새로고침해야지 데이터가 변한다. |
| `<jsp:include>` 액션 태그 | 동적 페이지 | 페이지 서비스 중 내부 데이터가 변한다. |
 
 
 
 






  <br><br> 
 


