# Lecture07 5장 JSP 내장 객체와 액션 태그

Key Word : 세션(session), 로그인, 자바 빈, 액션 태그

<hr>

  
## 교재 242p : 세션(session) 

 쿠키를 설명할 때 (다른 페이지로 이동하더라도 그 전 페이지의 정보가 유지되어야 하는) 상태 유지를 위한 특별한 기법이 필요하다는 설명을 하였다. 하지만 쿠키는 **클라이언트의 컴퓨터에 정보를 저장**하여 사용하므로 **보안에 문제**가 될 수 있다. 또한 저장할 수 있는 데이터의 양도 1.2MB로 한계가 있다.   
    
 이러한 단점을 극복하기 위해서 나온 상태 유지 방법 중의 하나가 세션이다. 세션은 다음과 같은 장점이 있다.
 
 - JSP(서버)에서만 접근 가능하므로 보안 유지에 강력하다.
 - 저장할 수 있는 데이터에 한계가 없다.   
   
 세션은 서버상에 존재하는 객체로서 브라우저 단위당 한개 씩 존재하게 된다. 세션은 웹 브라우저를 닫기 전까지 페이지를 이동하더라도 사용자의 정보를 잃지 않고 서버에 보관할 수 있도록 하는 객체이다.   
    
 이러한 세션이 활용되는 대표적인 예는 로그인 페이지이다.




<br><br>
<hr>
  
### 교재 244p : 세션(session) 사용하기

 다음은 session에서 자주 사용되는 메소드를 정리한 표이다.

메서드 | 설명
-|-
java.lang.Object getAttribute(String name) | · 세션에서 데이터를 얻습니다. <br> · 없을 경우 null을 반환한다.<br> · 반환 값은 Object 형이므로 반드시 형 변환을 하여 사용해야 한다.
java.util.Enumeration getAttributeNames() | · 세션에 저장되어 있는 모든 데이터의 이름(유니크한 키값)을 얻습니다. <br> · 반환 값이 Enumeration 형으로 얻어준다.
long getCreationTime() | · 세션이 생성된 시간을 반환합니다. <br> ·       시간은 1970년1월1일 이후 흘러간 시간을 의미합니다.  <br> ·       단위는 1/1000초 <br> ·       yyyy년 mm월 dd일 00시 00분 00초부터 <br> 해당 세션이 생성된 순간까지의 경과 시간을 밀리 초로 계산하여 long형으로 리턴함
String getId() | ·       자동 생성된 세션의 고유 ID를 반환합니다. <br> ·       해당 세션의 세션ID 문자열을 리턴합니다. <br> ·       세션 ID는 session 객체 생성시에 웹컨테이너에 의해 자동으로 할당됨
long getLastAccessedTime() | ·       웹 브라우저가 가장 마지막에 섹션에 접근한 시간을 반환합니다. <br> · 즉 세션동안 클라이언트가 마지막으로 서버에 보낸 요청시간을 반환합니다. <br> ·       시간은 1970년1월1일 이후 흘러간 시간을 의미. <br> ·       단위는 1/1000초
int getMaxinactiveInterval() | ·       설정된 세션 유효시간을 반환합니다. <br> ·       가장 최근 요청시점을 기준으로 카운트 됩니다. <br> ·       C:\CodeLab\apache-tomcat-7.0.65\conf\web.xml 참조 <br> ·       클라이언트의 요청이 없을 시 서버가 해당 세션을 유지하도록 <br> 지정된 시간을 초 단위 정수로 리턴합니다.
boolean isNew() | ·       세션이 최초 생성되었는지, 이전에 생성된 세션인지를 구분 합니다. <br> ·       새로운 세션이면 true 를 리턴하고 기존 세션이 유지되고 있으면 false 를 리턴합니다. <br> ·       웹서버가 쿠키기반의 세션을 생성했지만 클라이언트가 쿠키를 사용하지 못하도록 한 경우 <br> 세션은 아직 new상태이고 isNew()메소드는 true를 반환합니다.
removeAttribute(String name) | ·       세션에서 특정 데이터 제거 합니다.
setAttribute(String name, Object value) | ·       세션에 데이터를 저장 합니다.
void setMaxInactiveInterval(int second) | ·       세션 유효시간을 초단위로 설정합니다. <br> ·       클라이언트의 요청이 없더라도 세션을 유지할 시간을 초 단위의 정수값으로 설정합니다. <br> ·       음수로 설정할 경우 세션은 무효화되지 않습니다.
invalidate() | ·       세션을 종료시키고 연결된 객체를 해제합니다. <br> ·       세션의 모든 데이터를 삭제 합니다.(현재 세션을 종료)<br> ·       세션을 없애고 세션에 속해있는 값들을 모두 제거합니다. <br> 세션의 속성값으로 저장된 모든 객체를 반납하여 해당 세션을 종료시킵니다.


**이외의 메소드들**

메서드 | 설명
-|-
String[] getValueNames() | ·       세션에 연결된 모든 객체의 이름을 배열로 반환합니다. <br> ·       deprecated <br> ·       getAttributeNames() 사용으로 대체
HttpSession getSession() | ·       요청한 클라이언트에 지정된 HttpSession 객체 <br> ·        이전에 생성된 HttpSession 객체가 없으면 새로운 객체를 생성
HttpSession getSession(Boolean create) |·       create 가 true 일 경우 getSession() 메서드와 동일한 결과를 리턴 <br> ·        하지만 create 를 false로 지정하면 이전에 생성된 <br> HttpSession 객체가  없을 경우 null 을 리턴 한다.
boolean isRequestedSessionIdValid() | ·       요청에 포함된 클라이언트의 세션 ID가 유효하면 <br> true 를 리턴하고 유효하지 않으면 false를 반환합니다.
String getReqeustedSessionID() | ·       요청한 클라이언트에 지정된 세션의 ID를 문자열로 리턴
setAttribute() | ·       세션에 데이터를 저장 합니다.
removeAttribute() | ·       세션에서 특정 데이터 제거 합니다.
Object getValue(String name) | ·       Deprecated <br> ·       세선에서 지정한 이름으로 연결된 객체를 반환합니다. <br> ·        getAttribute(java.lang.String)로 대체
putValue(String name, Object value) | ·       Deprecated <br> ·       세션에 지정한 name(String)을 이용하여 value(Objet)를 연결합니다. <br> ·       만들 동일한 name으로 value가 이미 연결되어 있다면 새로운 value으로 변경됩니다. <br> ·       name(String)은 연결할 객체의 이름이고, value는 String과 같은 Object유형의 값으로만 설정할 수 있습니다. <br> ·       setAttribute(java.lang.String, java.lang.Object)로 대체
removeValue(String name) | ·       Deprecated <br> ·       세션으로 부터 지정한 name을 가진 객체의 연결을 제거합니다. <br> ·       removeAttribute(java.lang.String)로 대체




<br><br>

 상태유지를 위해서는 세션에 값을 저장한 후 이를 가져와서 사용한다.이를 위해서는 세션에 값을 저장하는 setAttribute()와 세션에 저장된 값을 얻기 위한 getAttribute()가 사용된다.   
 ```
  session.setAttribute(String name, Object value);
  Object getAttribute(String name);
 ```


 
**04_SetSession.jsp**
```java
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
	session.setAttribute("id", "pinksung");
	session.setAttribute("pwd", "test1234");
	session.setAttribute("age", 20);
	%>
	<h3> 세션 설정</h3>
</body>
</html>
```

 
 **05_getSession.jsp**
```java
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>세션 값 얻어오기</h3>
	<%
	String id = (String) session.getAttribute("id");
	String pwd = (String) session.getAttribute("pwd");
	Integer age = (Integer) session.getAttribute("age");
	%>
	id : <%=id%><br>
	pwd : <%=pwd%><br>
	age : <%=age%><br>
</body>
</html>
```

 
 **06_getSessions.jsp**
```java
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
<h3> 세션에 설정된 모든 값 얻어오기 </h3>
<%
	Enumeration names = session.getAttributeNames();
while(names.hasMoreElements()){
	String name = names.nextElement().toString();
	String value = session.getAttribute(name).toString();
	out.println(name + " : "+value+"<br>");
}
%>
</body>
</html>
```

<br><br>

 서블릿에서 세션을 사용하려면 객체를 생성해줘야한다.   
 
 ```java
 protected void doGet(HttpServletRequest Request, HttpServletResponse response) throws ServletException, IOException {
 
   HttpSession session = request.getSession();
   
 }
 ```
 
<br><br>
<hr>

### 교재 251p : 세션 관련 메소드


 
**07_infoSession.jsp**
```java
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3> 세션 정를 얻어오는 메소드를 사용하기 </h3>
<% 
	String id_str = session.getId();
	long lasttime = session.getLastAccessedTime();
	long createdtime = session.getCreationTime();
	long time_used = (lasttime - createdtime) / 60000;
	int inactive = session.getMaxInactiveInterval() / 60;
	boolean b_new = session.isNew();
	%>
 [1] 세션 ID는 [ <%= session.getId() %>] 입니다. <br><hr>
 [2] 당신이 웹 사이트에 머문 시간은 <%= time_used %> 분입니다. <br><hr>
 [3] 세션의 유효 시간은 <%= inactive %> 분입니다. <br><hr>
 [4] 세션이 새로 만들어졌나요? <br>
<%
	if(b_new)
		out.print(" 예! 새로운 세션을 만들었습니다.");
	else 
		out.print(" 아니오! 새로운 세션을 만들지 않았습니다.");
%> 
</body>
</html>
```

**결과 화면**    
![image](https://user-images.githubusercontent.com/84966961/126089172-a9288fa5-7d40-4f02-99a3-a8cac5383b6b.png)


 세션 관련 메소드는 현업에서 다양하게 사용된다.   
    
 먼저, 세션 ID는 서로 다른 세션인지를 구분하기 위해서 사용되는 것으로 세션이 바뀌면 이전에 세션에 저장되었던 정보를 더 이상 사용하지 못하도록 해서 보안 유지를 하는 경우에 사용한다.   
    
 웹사이트에 머문 시간을 알아보는 이유는 온라인 은행 업무와 같이 일정 시간이 지나면 자동으로 로그아웃이 되게 하기 위해서 세션이 생성된 시간과 액세스된 시간을 비교해서 머문 시간을 계산한다.   
     
 한번 생성된 세션 객체는 무한정 사용할 수 있는 것이 아니다. 유효 시간을 지정해 두면 그 시간까지만 사용 가능하다.

<br><br>
<hr>
  
### 교재 255p : 세션 제거하기

 로그인되어 있는 상태에서 브라우저를 닫지 않고 자리를 비운다면 그 사이에 개인 정보가 유출될 수 있다. 그래서 로그아웃 후에 자리를 비워야 한다.   
    
 로그아웃 처리 과정에서 세션이 설정되어야만 사용 가능한 회원 전용 페이지에는 접근하지 못하도록 하기 위해서 세션에 저장된 속성 값을 제거해야 한다.   
    
 이렇게 세션에 저장된 특정 속성 값을 제거하기 위해서 사용하는 메소드가 `removeAttribute()` 메소드이다.    
   
**08_removeAttribute.jsp**
```
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
	session.setAttribute("s_name1", "저는 세션에 저장된 첫 번째 값이에요. ^o^ ");
	session.setAttribute("s_name2", "저는 세션에 저장된 두 번째 값이에요. ^o^ ");
	session.setAttribute("s_name3", "저는 세션에 저장된 세 번째 값이에요. ^o^ ");
	
	out.print(" <h3> >> 세션값을 삭제하기 전 << </h3> ");
	Enumeration names;
	names = session.getAttributeNames();
	while (names.hasMoreElements()) {
		String name = names.nextElement().toString();
		String value = session.getAttribute(name).toString();
		out.println(name +" : " + value + "<br>");
	}
	
	// 이름을 지정하여 세션에 저장된 객체를 제거함.
	session.removeAttribute("s_name2");
	
	out.print(" <h3> >> 세션값을 삭제한 후 << </h3> ");
	names = session.getAttributeNames();
	while (names.hasMoreElements()) {
		String name = names.nextElement().toString();
		String value = session.getAttribute(name).toString();
		out.println(name +" : " + value + "<br>");
	}
%>
</body>
</html>
```

**결과 화면**    
![image](https://user-images.githubusercontent.com/84966961/126091057-57904abe-7c0f-471e-833a-810ddfcaf8f7.png)



 세션의 기본 유효 시간은 30으로 잡혀있다. 하지만 세션이 더 이상 사용되지 않는다면 세션 정보도 더 이상 필요하지 않다. 이 때 설정된 세션의 값들을 모두 사라지도록 하려면 세션 객체의 `invalidate()`를 사용한다. `invalidate()`는 해당 세션을 없애고 세션에 속해있는 값들을 모두 없앤다.   

   
    
**09_invalidate.jsp**   
```
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
	session.setAttribute("s_name1", "저는 세션에 저장된 첫 번째 값이에요. ^o^ ");
	session.setAttribute("s_name2", "저는 세션에 저장된 두 번째 값이에요. ^o^ ");
	session.setAttribute("s_name3", "저는 세션에 저장된 세 번째 값이에요. ^o^ ");
	
	out.print(" <h3> >> 세션값을 삭제하기 전 << </h3> ");
	Enumeration names;
	names = session.getAttributeNames();
	while (names.hasMoreElements()) {
		String name = names.nextElement().toString();
		String value = session.getAttribute(name).toString();
		out.println(name +" : " + value + "<br>");
	}
	
	// 설정된 세션의 값들을 모두 사라지도록 한다.
	session.invalidate();
	
	out.print(" <h3> >> 세션값을 삭제한 후 << </h3> ");
	out.print(" Q : 과연 세션 아이디가 유효할까요? <br>");
	if (request.isRequestedSessionIdValid() == true) 
		out.print(" A : 세션 아이디가 유효합니다.<hr>");
	else
		out.print(" A : 세션 아이디가 유효하지 않습니다.<hr>");
%>
</body>
</html>
```

**결과 화면**    
![image](https://user-images.githubusercontent.com/84966961/126091030-04ad2c81-83ec-4431-8045-60ca988e746a.png)





<br><br>
<hr>
  
### 교재 259p : 세션을 이용한 로그인 처리

![image](https://user-images.githubusercontent.com/84966961/126091575-d730b4ce-cec2-4426-8861-4c118f9547b6.png)

![image](https://user-images.githubusercontent.com/84966961/126093008-e3fd5fd0-abe4-425c-8250-867e784fc734.png)

**10_loginForm.jsp**
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
<form action="10_testLogin.jsp" method="post">
	<label for="userid"> 아이디 : </label>
	<input type="text" name="id" id="userid" value="moveuk"/>
	<br />
	<label for="userpwd"> 암 &nbsp; 호 : </label>
	<input type="password" name="pwd" id="userpwd" value="1234" />
	<br />
	<input type="submit" value="로그인">
</form>
</body>
</html>
```


**10_testLogin.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	String id = "moveuk";
	String pwd = "1234";
	String name = "이동욱";
	
	if(id.equals(request.getParameter("id")) && pwd.equals(request.getParameter("pwd"))) {
		session.setAttribute("loginUser", name);
		response.sendRedirect("10_main.jsp");
	} else {
		response.sendRedirect("10_loginForm.jsp");
	}
%>
```


**10_main.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	if (session.getAttribute("loginUser") == null) {
		response.sendRedirect("10_loginForm.jsp");
	} else {
		out.print(session.getAttribute("loginUser"));
		out.print("님 안녕하세요!<br>");
	%>
	저희 홈페이지에 방문해 주셔서 감사합니다. <br>
	즐거운 시간 되세요....<br>
	<form action="10_logout.jsp" method="post">
		<input type="submit" value="로그아웃">
	</form>
<%}	%>
</body>
</html>
```


**10_logout.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	session.invalidate();
	%>
	<script>
		alert("로그아웃 되었습니다.")
		location.href = "10_loginForm.jsp"
	</script>
</body>
</html>
```




<br><br>
<hr>
  
### 교재 267p : Mission 쿠키로 로그인 

**loginForm.jsp**
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
<form action="testLogin.jsp" method="post">
	<label for="userid"> 아이디 : </label>
	<input type="text" name="id" id="userid" value="moveuk"/>
	<br />
	<label for="userpwd"> 암 &nbsp; 호 : </label>
	<input type="password" name="pwd" id="userpwd" value="1234" />
	<br />
	<input type="submit" value="로그인">
</form>

</body>
</html>
```


**testLogin.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
// 실제로는 DB에서 가져와야하는 값
	String id = "moveuk";
	String pwd = "1234";
	String name = "이동욱";
	
	if(id.equals(request.getParameter("id")) && pwd.equals(request.getParameter("pwd"))) {
		// id, pwd가 같을 때만 쿠키 생성하고 client에 추가
		Cookie cookie = new Cookie("username","이동욱");
		
//--------------------------------------------------------
		// 2. 속성 부여
		
		// 3. 클라이언트에 전송
		response.addCookie(cookie);
		
//--------------------------------------------------------
%>
<h2> 성공적으로 로그인하셨습니다. </h2>
<p> <a href="main.jsp"> 들어가기 </a></p>
<%	} else { %>
<h2> 로그인에 실패했습니다. </h2>
<p> <a href="loginForm.jsp"> 되돌아가기 </a></p>
<%	} %>
```


**main.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	// Cookie에서 name과  value를 얻어와서 비교
	Cookie ck[] = null;
	// 1. 클라이언트로부터 Cookie[]를 얻어옴
	ck = request.getCookies();
	if (ck != null) {
		// 2. 쿠키의 name을 얻어서 "username"인지 비교하여 같으면
		for (Cookie c : ck) {

			if ( c.getName().equals("username")) {
		// 3. 쿠키의 value을 얻어와 출력
				out.print(c.getValue());
			}
		}
	%>
	님 안녕하세요!<br>
	저희 홈페이지에 방문해 주셔서 감사합니다. <br>
	즐거운 시간 되세요....<br>
	<form method="post" action="logout.jsp"><input type="submit" value="로그아웃" /></form>
	<%
	} else {
		 %>
	<h2> 로그인에 실패하셨습니다.</h2>
	<p><a href="loginForm.jsp">되돌아가기</a></p>
<%}	%>
</body>
</html>
```


**logout.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	// 사용자 인증 무효화
	session.invalidate();
	%>
	<script>
		alert("로그아웃 되었습니다.")
		location.href = "loginForm.jsp"
	</script>
</body>
</html>
```

**결과 화면**
![image](https://user-images.githubusercontent.com/84966961/126099375-af60b5fd-1b5d-4fe5-9456-be826addbe4f.png)



<br><br>
<hr>
  
# 6장 자바 빈과 액션 태그

## 교재 272p : 자바 빈과의 첫 데이트

 회원 가입 페이지에서 입력한 정보는 다음 두 가지 방법으로 서버에 전송된다.   
    
 1. 이름, 아이디, 별명, 비밀번호 등을 개별적으로 전송하는 방법.   
 ```
<%
 member.setName(request.getParameter("name"));
 member.setUserid(request.getParameter("userid"));
 member.setNickname(request.getParameter("nickname"));
 member.setPwd(request.getParameter("pwd"));
 member.setEmail(request.getParameter("email"));
 member.setPhone(request.getParameter("phone"));
 %>
```
    
 2. 회원 정보를 하나로 묶어서 전송하는 방법
```
  <jsp : setProperty property="*" name="member"/>
```

 두 번째 방법인 자바 빈과 액션 태그를 이용하여 하나의 묶음으로 전송하는 것이 훨씬 효율적이다.   
    
 자바 빈은 정보의 덩어리로 **데이터 저장소**라고 정의할 수 있다. 한꺼번에 전달할 수 있는 장점을 가진다. 또한 자바 빈은 단순히 데이터를 저장하는 것 뿐만 아니라 **데이터 은닉(Data Hiding)**이란 개념을 사용한다.   




<br><br>
<hr>
  
## 교재 276p : 자바 빈 클래스 만들기

 자바 빈도 역시 클래스이다. 그러므로 자바 빈 역시 클래스를 구성하는 요소인 필드와 메소드로 구성된다. 좀 더 구체적으로 이야기하면 자바 빈은 필드와 getter/setter 메소드를 하나의 쌍으로 갖는 특별한 클래스이다.

구성요소 | 의미
-|-
필드 | (private) 빈이 가진 속성을 의미한다. 멤버변수 형태로 제공된다.
메소드 | (getter/setter) 빈을 외부에서 조작할 수 있도록 하는 방식들을 제공해 준다. 멤버함수 형태로 제공된다.






<br><br>
<hr>
  
### 교재 276p : 자바 빈 클래스

**MemberBean.java**
```java
package javabeans;

public class MeberBean {
	private String name;
	private String userid;
	private String nickname;
	private String pwd;
	private String email;
	private String phone;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
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
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
}
```


<br><br>
<hr>
  
## 교재 286p : 자바 빈 관련 액션 태그

 자바 빈의 의미와 작성 방법을 살펴보았으므로 이제 JSP에서 어떻게 활용하는지를 알아보겠다. JSP에서는 자바 빈을 사용하기 위한 액션 태그를 다음과 같이 3가지 종류로 제공된다.    

액션 태그의 종류 | 설명
-|-
`<jsp:useBean>` | 자바 빈을 생성한다.
`<jsp:getProperty>` | 자바 빈에서 정보를 얻어온다.
`<jsp:setProperty>` | 자바 빈에 정보를 저장한다.



<br><br>
<hr>
  
### 교재 286p : 자바 빈 객체를 생성하는 `<jsp:useBean>` 액션 태그

 `<jsp:useBean>` 액션 태그는 JSP와 자바 빈을 연결하기 위한 자바 빈 객체를 생성한다.   
    
 자바에서 객체를 생성하는 코드와 동일한 동작을 한다고 생각하면 이해가 빠를 것이다.   
 
```jsp
<%@ page import="com.saeyan.javabeans.MemberBean" %>
<%
 MemberBean member = new MemberBean();
%>
```

 import 속성을 갖는 page 지시자 없이 하면 다음 코드와 같이 **풀네임 형식(패키지를 포함한 평태의 클래스 이름을 의미)**으로 적어주어야 한다.

```jsp
<% 
 com.saeyan.javabeans.MemberBean member = new com.saeyan.javabeans.MemberBean();
%>
```

 객체를 생성하면 다음과 같이 MemberBean 클래스의 메소드들을 사용할 수 있다.   
 
```jsp 
//getter
 <%=member.getName()%>
 <%=member.getUserid()%>
//setter
 <%=member.setName("이동욱")%>
 <%=member.setUserid("moveuk")%>
```

JSP에서 자바 빈 객체를 생성하기 위해서는 다음과 같이 `<jsp:useBean>` 액션 태그를 사용한다. 

```jsp
<jsp:useBean 	class="클래스 풀 네임"
		id="빈 이름"
		[scope="범위"]/>
```

 [] 는 생략 가능하며 유효 범위를 위한 속성이다. 즉 값으로는 page,request, session, application 중 하나를 사용해야 한다.
 
```jsp
<jsp:useBean 	class="com.saeyan.javabeans.MemberBean"
		id="member"
		[scope="page"]/>
```

 이 코드는 **①com.saeyan.javabeans.MemberBean 클래스의 자바 빈 객체를 생성**해서 **②이름이 member인 변수에 할당**하고 **③page 객체의 속성 값으로 위 객체를 저장**한다는 의미이다. 다음 코드가 자동으로 생성된다고 생각하면 된다.
 

```jsp
<% 
 com.saeyan.javabeans.MemberBean member = new com.saeyan.javabeans.MemberBean();
 pageContext.setAttribute("memeber", member);
%>
```


<br><br>
<hr>
  
#### 교재 291p : 자바 빈 객체 생성하기(`<jsp:useBean>` 액션 태그)

**01_useBeanDemo.jsp**
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

<jsp:useBean id="member" class="javabeans.MemberBean"></jsp:useBean>

◎ 자바 빈 객체 생성 후 저장된 정보 출력하기 <br /><br />
<% 
member.setName("이동욱");
member.setUserid("moveuk");
%>

이름 : <%= member.getName() %> <br>
아이디 : <%= member.getUserid() %>

</body>
</html>
```






<br><br>
<hr>
  
### 교재 286p : 자바 빈 객체를 생성하는 `<jsp:getProperty>` 액션 태그

 다음은 회원의 이름을 얻기 위해서 getName()을 호출한 예이다.
 
 ```
 <%= memeber.getName()%>
```

 다음은 스크립트릿 getter를 활용하여 호출하는 대신 `<jsp:getProperty>` 액션 태그를 사용한 예이다.
 
 ```jsp
 <jsp:getProperty name="member" property="name"/>
 ```

 JSP 에서는 스크립트릿을 이용하여 자바 코드를 혼용하면 가독성이 떨어지고 코드가 지저분해지기 때문에 액션 태그를 활용하여 작성한다. 다음은 기본 형식이다   

 ```jsp
 <jsp:getProperty name="빈 이름" property="프로퍼티 이름"/>
 ```

 name은 반드시 `<jsp:useBean>`에서 설정한 id와 일치해야 한다. SetAttribute할 때의 Key 값이기 때문이다.





<br><br>
<hr>
  
### 교재 286p : 자바 빈 객체를 생성하는 `<jsp:setProperty>` 액션 태그

 반대로 정보를 설정하기 위해서는 다음과 같이 setter를 사용해야 한다.
 
 ```
 <% memeber.setName("이동욱");%>
```

 `<jsp:getProperty>` 액션 태그는 private한 변수를 지정하는 것이 아니라 setter를 불러 변경하는 것이다.
 
 ```jsp
 <jsp:setProperty name="자바 빈 이름" property="프로퍼티 이름" value="값"/>
 ```
 
<br><br>

#### name

 name은 반드시 `<jsp:useBean>`에서 설정한 id와 일치해야 한다. SetAttribute할 때의 Key 값이기 때문이다.


<br><br>

#### property

 property의 값은 필드의 이름과 같아야 하며 첫글자가 대문자로 바뀌어 setter를 호출하게 된다. 


<br><br>

#### value

 value는 변경할 값을 전달해준다.



<br><br>
<hr>
  
#### 교재 296p : 자바 빈 프로퍼티 값 얻기와 변경하기 (`<jsp:getProperty>`,`<jsp:setProperty>` 액션 태그)

**02_propertyDemo.jsp**
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

<jsp:useBean id="member" class="javabeans.MemberBean"></jsp:useBean>
<hr>
◎ 자바 빈 객체 생성 후 저장된 정보 출력하기 <br /><br />

이름 : <jsp:getProperty property="member" name="name"/> <br>
아이디 : <jsp:getProperty property="member" name="userid"/>
<hr>

◎ 정보 변경한 후 변겅된 정보 출력하기 <br /><br />
<jsp:setProperty property="member" name="name" value="이동욱"/> <br>
<jsp:setProperty property="member" name="userid" value="moveuk"/> <br>
이름 : <jsp:getProperty property="member" name="name"/> <br>
아이디 : <jsp:getProperty property="member" name="userid"/>

</body>
</html>
```


<br><br>
<hr>
  
## 교재 297p : 자바 빈으로 회원 정보 처리하기

자바 빈의 장점은 회원 가입시 입력한 회원 정보를 하나로 묶어서 서버로 전송할 수 있다는 점이다. 회원 가입 폼에서 입력받은 정보를 자바 빈 com.saeyan.javabeans.MemberBean에 저장하고 이를 조회하는 프로그램을 만들어 보자.


**03_addMemberForm.jsp**
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
<h2> 회원의 정보 입력 폼</h2>
<form action="03_addMember.jsp" method="post">
	<table>
		<tr>
			<td> 이름 </td>
			<td><input type="text" name="name" size="20" /></td>
		</tr>
		<tr>
			<td> 아이디 </td>
			<td><input type="text" name="userid" size="20" /></td>
		</tr>
		<tr>
			<td> 별명 </td>
			<td><input type="text" name="nickname" size="20" /></td>
		</tr>
		<tr>
			<td> 비밀번호 </td>
			<td><input type="password" name="pwd" size="20" /></td>
		</tr>
		<tr>
			<td> 이메일 </td>
			<td><input type="text" name="email" size="20" /></td>
		</tr>
		<tr>
			<td> 전화번호 </td>
			<td><input type="text" name="phone" size="11" /></td>
		</tr>
		<tr>
			<td><input type="submit" value="전송" /></td>
			<td><input type="reset" value="취소"/></td>
		</tr>
	</table>
</form>
</body>
</html>
```

**03_addMember.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="member" class="javabeans.MemberBean"></jsp:useBean>
<jsp:setProperty property="*" name="member"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2> 입력 완료된 회원 정보</h2>
	<table>
		<tr>
			<td> 이름 </td>
			<td><jsp:getProperty property="name" name="member"/></td>
		</tr>
		<tr>
			<td> 아이디 </td>
			<td><jsp:getProperty property="userid" name="member"/></td>
		</tr>
		<tr>
			<td> 별명 </td>
			<td><jsp:getProperty property="nickname" name="member"/></td>
		</tr>
		<tr>
			<td> 비밀번호 </td>
			<td><jsp:getProperty property="pwd" name="member"/></td>
		</tr>
		<tr>
			<td> 이메일 </td>
			<td><jsp:getProperty property="email" name="member"/></td>
		</tr>
		<tr>
			<td> 전화번호 </td>
			<td><jsp:getProperty property="phone" name="member"/></td>
		</tr>
	</table>
</body>
</html>
```

**결과 화면**   
![image](https://user-images.githubusercontent.com/84966961/126136993-3bd0dafc-56df-444d-8945-467cc59a291f.png)
![image](https://user-images.githubusercontent.com/84966961/126137013-d2010e43-aa8c-4a57-acfe-f7cba19da0c5.png)

