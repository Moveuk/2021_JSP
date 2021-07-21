# Lecture09 7장 표현 언어와 JSTL

Key Word : 표현 언어, JSTL

<hr>

## 교재 308p : 표현 언어로 단순화하기 

 표현 언어(EL : Expression Language)는 값(데이터)을 웹 페이지에 표시(표현)하는 데 사용되는 태그이다.   
 
```
  EL(Expression Language)?
  JSP 출력에 대한 부분을 쉽게 하기 위해 개발한 tag(태그)이다.
```

이미 우리는 표현식`<%= %>`을 배웠었다. 표현식은 `out.print()`를 좀 더 가독성 높은 스크립트를 만들어 주기 위해서 적용했던 방법이었다. 하지만 표현식보다 더 사용 방법이 간단하고 문법 체계가 직관적인 방법을 **표현 언어**라고 한다. 표현 언어는 `${ }`를 사용하여 값을 표현한다.

표현식 | 표현 언어
-|-
<%=expr%> | ${expr}

 순수 JSP로만 개발하지 않고 스트럿츠나 스프링과 같은 프레임 워크로 웹 개발을 하는 환경이 대부분이고 그 환경에서 보통 표현 언어를 사용한다.

```jsp
${"Hello"}									<!-- 표현 언어 -->
<%="Hello"%>								<!-- 표현식 -->
<% out.print("Hello"); %>					<!-- 스크립트릿 -->
```

표현 언어가 가장 간단하고 직관적임을 알 수 있다.

<br><br>

#### 표현 언어에서 사용 가능한 데이터 타입

```
정수형 :	${10}
실수형 :	${5.6}
문자열형 :	${"Hello"}
논리형 :	${true}
null :	   ${null}
```

 표현 언어가 자바와는 다른 특징 중 하나는 null은 결과 화면에 공백으로 처리되는 점이다.

<br><br>

#### EL 식 

종류 | 연산자
-|-
산술 | `+`, `-`, `*`, `/` (or `div`), % (or `mod`)
관계형 | `==` (or `eq`), `!=` (or `ne`), `<` (or `lt`), `>` (or `gt`), `<=` (or `le`), `>=` (or `ge`)
조건 | `a ? b : c`
논리 | `&&` (or `and`), `||` (or `or`), `!` (or `not`)
null 검사 | `empty`

 다음은 몇몇 예시이다.
 
```
더하기
${5+2} ${5 div 2}

동등
${3 == 3} ${3 eq 3}

빈 값(null?)
${empty input}
```

<br><br><hr>

### 교재 312p 예제 :표현 언어의 연산자 사용하기

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
\${5+2} : ${5+2} <br>
\${5/2} : ${5/2} <br>
\${5 div 2} : ${5 div 2} <br>
\${5 mod 2} : ${5 mod 2}<br>
\${5 > 2} : ${5 > 2}<br>
\${2 gt 10} : ${2 gt 10}<br>
\${(5 > 2) ? 5 : 2} : ${(5 > 2) ? 5 : 2}<br>
\${(5 > 2) || (2 < 10)} : ${(5 > 2) || (2 < 10)}<br>
<%
String input=null;
%>
\${empty input} : ${empty input}<br>
</body>
</html>
```

$를 붙이게 되면 출력으로 인식하게 되어 앞에 `\`을 덧붙여 표현 언어가 아닌 단순 문자열임을 명시적으로 알려주어야 한다.   
   
   
 String 에 null이 있는 상태로 사용하게 되면 예외가 발생하므로 객체를 사용하기 전에 null이 저장되어 있는지를 물어보고 사용하는 것이 일반적이다. 이럴 때 사용되는 연산자가 empty이다.   

 기존 스크립트릿으로 if문을 작성한다면 가독성과 효율이 떨어지지만 JSTL을 사용하게 되면 다음과 같이 코드가 단순해진다.   
 
 ```jsp
 // 기존 스크립트릿 방식
 <% if(input==null) {%>
     텅 빈 객체 (null) 입니다
 <% }%>

// 표현 언어와 JSTL
 <c:if test=${empty input)>
     텅 빈 객체 (null) 입니다
 </c:if>
```




<br><br>
<hr>
  
## 교재 314p : 표현언어로 요청 파라미터 처리하기

 표현 언어에서는 request.getParameter() 대신 param 객체를 사용한다.
 
 내장 객체 | 설명
 -|-
 param | JSP의 내장 객체인 request의 getParameter()와 동일한 역할인 파라미터 값을 알려준다.
 paramValues | 동일한 이름으로 전달되는 파라미터 값들을 배열 형태로 얻어오는 데 사용하는 request의 getPrameterValues()와 동일한 역할을 한다.

 표현 언어와 JSTL을 활용하면 다음 기존의 코드가 엄청 간단해진다.
 
 ```jsp
 // 기존 스크립트릿 방식
 <% 
	 String seasonArr[] = request.getParameterValues("season");
     out.println("당신이 좋아하는 계절 : ");
	 for (String season : seasonArr) {
	 	out.println(season+" ");
	}
%>

// 표현 언어와 JSTL
 <c:forEach items="${paramValues.season}" var="season">
     #{season}
 </c:forEach>
```

<br><br><hr>

### 교재 317p 예제 : 로그인 폼 만들기 

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
<form action="04_testLogin.jsp" method="get">
	<label for="userid"> 아이디 : </label>
	<input type="text" name="id" id="userid"/><br>

	<label for="userpwd"> 암 &nbsp; 호 : </label>
	<input type="password" name="pwd" id="userpwd" /><br>

	<input type="submit" value="로그인"/>
</form>
</body>
</html>
```

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
	당신이 입력한 정보입니다.(고전적인 방식).			<hr>
	아이디 : 	<%= request.getParameter("id") %>		<br>
	비밀번호 :	<%= request.getParameter("pwd") %> 		<br><br>
	
	당신이 입력한 정보입니다.(EL 방식).					<hr>
	아이디 : 	${param.id}								<br>
	비밀번호 :	${param["pwd"]} 						<br><br>
</body>
</html>
```



<br><br><hr>

#### null 값 출력 차이 

```jsp
자바 코드 : <%= request.getParameter("id") %>
EL 식 : ${param.id}
```

 위의 코드에 String 형태로 넘겨주면 모두 값이 잘나온다. 하지만 null 값을 파라미터로 주게 되면 자바 코드로 만든 식은 `null`을 출력하지만 EL 식은 결과화면에 null이 출력이 안되고 공백이 출력되므로 화면에는 아무 것도 나오지 않는다.   

<br><br><hr>

#### JSTL의 동등 비교 연산자 

 자바에서는 객체의 생성으로 인하여 String 비교시 동등 비교 연산자인 `==`을 사용하면 객체의 값이 같더라도 다른 메모리 힙 영역의 주소를 참조한다면 다른 값이 나오게 된다. 하지만 EL 식에서는 String의 동등 비교도 `==`을 사용하여 비교할 수 있습니다.


![image](https://user-images.githubusercontent.com/84966961/126414608-9f21913f-1f58-4294-b672-38bf250c07ae.png)

```
== 연산자 사용 결과 : <%= request.getParameter("id")=="moveuk" %>			      // 출력 결과 : false
equals() 사용 결과 : <%= request.getParameter("id").equals("moveuk") %> 		// 출력 결과 : true

== 연산자 사용 결과 : ${param.id=="moveuk"}												  // 출력 결과 : true
```


<br><br><hr>

#### 자바 코드에서 null 값에 대한 예외 처리 

 자바에서는 파라미터를 찾지 못해 request.getParameter() 메소드의 리턴값이 null일 경우 equals() 메소드를 적용하면 예외가 발생하므로 미리 비교해서 예외 처리해야하는 불편함이 생긴다. 
 
 ```jsp
 자바코드 <hr>
 <% if(request.getParameteer("id") != null) { %>
 	== 연산자 사용 결과 : <%= request.getParameter("id")=="moveuk" %>			      // 출력 결과 : false
	equals() 사용 결과 : <%= request.getParameter("id").equals("moveuk") %> 		// 출력 결과 : true
 <% } else { 
 	out.print("id를 전달해 주세요.");
 }
 %>
 ```
 
 null이 아닌 경우에만 equals() 메소드를 호출하도록 예외를 처리하였기에 파라미터를 넘겨주지 않아도 동작한다.   
    
 하지만 EL식에서는 파라미터를 찾지 못하면 공백으로 처리되기 때문에 예외가 발생되지 않아 따로 예외 처리를 하지 않아도 된다.


<br><br><hr>

#### 교재 323p 예제 : EL로 형 변환 없이 두 수를 입력받아 합을 구하기

 자바 코드는 형변환을 해야하지만 EL은 `${ }`에 담기만 하면 어떤 형이든 자동으로 처리되기 때문에 간단한 코드 작성이 가능하다.

```jsp
	고전적인 방식 : <%-- 스크립트릿에서의 복잡한 자바 코드 --%>
	<% 
		String str1 = request.getParameter("num1");
		String str2 = request.getParameter("num2");
	
		int num1 = Integer.parseInt(str1);
		int num2 = Integer.parseInt(str2);
	%>
	<%= num1 %> + <%= num2 %> = <%= num1 + num2 %> <hr>
	
	EL 방식 :  <%-- 보다 깔끔하고 간단한 코드 --%>
	${param.num1} + ${param.num2} = ${param.num1+param.num2}
```



<br><br><hr>

## 교재 324p : 표현 언어로 내장 객체 접근하기

 JSP는 웹 애플리케이션을 구현하는 데 필요한 정보를 JSP 내장 객체(request, session등)에 속성 값으로 저장해서 사용했다. 속성에 저장된 값을 표현 언어에서는 다음 표에서와 같은 형태로 접근해서 사용할 수 있다.   

> 범위 (영역 객체)
> 내장 객체 | 설명
> -|-
> pageScope | page 기본 객체에 저장된 속성의 <속성,값> 매핑을 저장한 Map 객체
> requestScope | request 기본 객체에 저장된 속성의 <속성,값> 매핑을 저장한 MAP 객체
> sessionScope | session 기본 객체에 저장된 속성의 <속성,값> 매핑을 저장한 MAP 객체
> applicationScope | application 기본 객체에 저장된 속성의 <속성,값> 매핑을 저장한 MAP 객체


 자바 코드로 내장 객체에 저장된 속성 값에 접근하면 코드가 길어지고 지저분해진다. 그래서 나온 것이 **표현 언어**이다. 앞으로 배울 JSTL과 표현 언어를 사용하게 되면 자바 코드보다 훨씬 간단해진다는 점을 기억해두자.    
 표현 언어(Expression Language)는 표현식(Expression)처럼 연산자와 피연산자의 조합을 `${`와 `}`로 둘러싸서 표현할 수 있지만 `${}`에 기술한 표현은 표현식과는 다른 의미로 해석된다.   

```
			<%=add%>		: 자바의 변수이름
			${add}			: 속성 이름 -> 즉 name을 말함.
```

 표현식에서는 이를 자바의 변수 이름으로 인식하지만 표현 언어에서 사용된 add는 속성 이름으로 인식된다. 다음 표에서 name의 값들을 바로 인식하여 사용할 수 있게 해준다는 말이다.
-> **표현식은 자바의 변수 중에 있는지 찾게 되고 표현 언어에서는 내장 객체 속성 중에서 값이 있는지 찾아온다.**

메소드 | 설명
-|-
setAttribute(name, value) | 주어진 이름(name)에 값(value)을 설정한다.
getAttribute(name) | 주어진 이름(name)에 설정된 값(value)을 얻어낸다.
getAttributeNames() | 현재 객체에 관련된 모든 속성 이름을 얻어낸다.
removeAttribute(name) | 주어진 이름(name)에 설정된 값(value)을 제거한다.




<br><br><hr>

### 교재 326p 예제 : 모델 2방식으로 구현해보기

 모델 2 방식이란 지금까지 JSP에서 모든 데이터 처리를 했던 방식과는 달리 서블릿에서 비즈니스 로직을 구현하고 JSP에서는 그 결과를 사용자에게 어떻게 보여줄 것인지 표현만 하는 방식을 말한다. 즉, 서블릿과 JSP의 역할을 분리하여 웹 프로그래밍을 한다.   

**AdditionServlet.java**
```java
package unit07;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Addition")
public class AdditionServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int num1 = 20;
		int num2 = 10;
		int add = num1 + num2;
		
		request.setAttribute("num1", num1);
		request.setAttribute("num2", num2);
		request.setAttribute("add", add);

		RequestDispatcher dispatcher = request.getRequestDispatcher("07_addition.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}
```

**07_addition.jsp**
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
	고전적인 방식 :
	<%
	int num1 = (Integer) request.getAttribute("num1");
	int num2 = (Integer) request.getAttribute("num2");
	%>
	<%= num1 %> + <%= num2 %> = <%= num1 + num2 %> <hr>
	
	EL 방식 :  <%-- 보다 깔끔하고 간단한 코드 --%>
	${param.num1} + ${param.num2} = ${param.num1+param.num2}
</body>
</html>
```



<br><br><hr>

 예제에서는 가장 자주 사용하는 request 객체에 대해서 속성을 설정해보았다. 다음은 JSP 내장 객체를 표현 언어에서 어떻게 사용하는지 비교해놓은 표이다. 

속성 | JSP 내장 객체 | 서블릿 클래스 | 표현 언어의 내장 객체
-|-|-|-
page 속성 | pageContext | javax.servlet.jsp.JspContext 클래스 | pageScope
request 속성 | request | javax.servlet.ServletRequest 인터페이스 | requestScope
session 속성 | session | javax.servlet.http.HttpSession 인터페이스 | sessionScope
application 속성 | application | javax.servlet.ServletContest 인터페이스 | applicationScope


다음은 기존의 자바 코드를 내장 객체에 저장된 속성 값을 가져오는 방식과 표현 언어의 방식을 비교한 표이다.   

자바 코드 | 표현 언어
-|-
pageContext.getParameter("num1"); | ${pageScope.num1}
request.getParameter("num1"); | ${requestScope.num1}
session.getParameter("num1"); | ${sessionScope.num1}
application.getParameter("num1"); | ${applicationScope.num1}

 하지만 앞선 예제에서는 request 내장 객체에 저장된 값이므로 `${requestScope.num1}`처럼 불러와야 하지만 내장 객체에 대한 선언 없이 `${num1}`처럼 바로 불러왔다. 이처럼 내장 객체를 명시해서 속성을 지정하면 혼동을 막을 수 있지만 생략하고 기술할 수 있다.   
   
 표현 언어에서 내장 객체를 명시하지 않고 `${num1}`과 같이 간단하게 표현하면 속성을 다음과 같은 순서로 자동으로 검색해서 속성 값을 얻어와 출력한다.

> pageScope -> requestScope -> sessionScope -> applicationScope



<br><br><hr>

### 같은 속성 값을 명시적으로 선언하여 받아오기

 만약 4개의 내장 객체에 모두 같은 속성 값을 가진 값이 있다면 어떻게 될까. 앞서 말한 것처럼 가장 협소한 크기의 pageScope 부터 차근차근 찾아 가기 때문에 pageScope의 값이 출력되게 될 것이다. 다음 예제를 통해 확인해보자

**08_scope.jsp**
```jsp
<% 
	pageContext.setAttribute("name", "page man");
	request.setAttribute("name", "request man");
	session.setAttribute("name", "session man");
	application.setAttribute("name", "application man");
%>

name : ${name} <br>
page 속성 : ${pageScope.name} <br>
request 속성 : ${request.name} <br>
session 속성 : ${session.name} <br>
application 속성 : ${application.name} <br>
```

**결과 화면**   
![image](https://user-images.githubusercontent.com/84966961/126420688-bb964f03-15c1-4f70-a93c-6fa08808973d.png)




<br><br><hr>

### 표현 언어로 자바 빈 객체 접근하기

1. 먼저 자바 빈 객체를 다음과 같이 만든다.

**MemberBean.java**
```java
package javabeans;

public class MemberBean {
	private String name;
	private String userid;
	
	public MemberBean(String name, String userid) {
		super();
		this.name = name;
		this.userid = userid;
	}
	public MemberBean() {
		super();
	}
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
	
	@Override
	public String toString() {

		return "MemberBean [name=" + name + ", userid=" + userid + "]";
	}
}

```

2. 다음은 자바 빈 객체를 생성하기 위한 서블릿 클래스를 생성한다.

**MemberServlet.java**
```java
package unit09;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javabeans.MemberBean;


@WebServlet("/Member")
public class MemberServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemberBean member = new MemberBean("전수빈", "pinksubin");
		
		request.setAttribute("member", member);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("09_el.jsp");
		dispatcher.forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
```

3. 이번에는 자바 빈의 프로퍼티를 출력하는 JSP 페이지를 작성한다.

**09_el.jsp**
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
이름 : ${member.name}<br>
아이디 : ${member["userid"]}
</body>
</html>
```




**결과 화면**   
![image](https://user-images.githubusercontent.com/84966961/126422901-d83c8fe0-2de9-4b9d-b07e-14e79521019e.png)




<br><br><hr>

## JSTL(JSP Standard Tag Library)

 JSTL은 JSP Standard Tag Library의 약어로 JSP에서 사용 가능한 표준 태그 라이브러리이다. JSTL에서 제공하는 태그를 사용하면 JSP 코드가 깔끔하고 가독성이 좋게 된다.


<br><br><hr>

### JSTL 라이브러리를 사용하는 이유

 다음은 JSTL이 등장하게 된 배경을 설명하기 위한 예시이다. JSP에서 조건에 따라 서로 다른 HTML의 태그가 수행될 수 있도록 하기 위해서 스크립트릿에서 제어문을 사용한 예이다.   

```
<%
if (request.getParameter("color").equals("1")){
%>
	<span style="color:red;">빨강</span>
<%
} else if (request.getParameter("color").equals("2")){
%>
	<span style="color:green;">초록</span>
<%
if (request.getParameter("color").equals("3")){
%>
	<span style="color:blue;">파랑</span>
<%
}
%>
```

 HTML 코드와 스크립트릿을 함께 사용하게 되면 위의 코드처럼 복잡하고 가독성이 떨어진다. 이러한 문제점을 해결하기 위해서 JSTL이 등장하게 되었다. JSTL 은 다양한 태그를 제공함으로써 다음 예에서 살펴볼 수 있듯이 코드를 깔끔하게 하고 가독성을 좋게 한다.

```
<c:if test="${param.color==1}">
	<span style="color:red;">빨강</span>
</c:if>
<c:if test="${param.color==2}">
	<span style="color:green;">초록</span>
</c:if>
<c:if test="${param.color==3}">
	<span style="color:blue;">파랑</span>
</c:if>
```

 위 코드는 param으로 넘겨진 값이 1이면 빨강 2면 초록 3이면 파랑을 출력하는 예제이다. 이전 자바 코드보다 깔끔해진 것을 알 수 있다.



<br><br><hr>

### JSTL 라이브러리

 JSTL은 개개인이 쉽게 코딩하기 위하여 자신만의 태그를 추가할 수 있는 데 이를 `커스텀 태그`라고 한다. 작성한 커스텀 태그들이 개별적으로 쓰여 사용되다 보니 일관성이 없어서 이를 표준화 한것이 `JSTL(JSP Standard Tag Library)`이다. 하지만 이 라이브러리는 우리가 보통 프로그래밍을 할 때 사용하는 라이브러리와는 달리 JSP 페이지 안에서 사용할 수 있는 커스텀 태그를 제공한다.   
   
 JSTL에서 제공해주는 기능은 다음과 같다.   

 - 간단한 프로그램 로직의 구현(자바의 변수선언, if문, for문 등에 해당하는 로직)
 - 다른 JSP 페이지 호출(<c:redirext>, <c:import>)
 - 날짜, 시간, 숫자의 포맷
 - JSP 페이지 하나를 가지고 여러 가지 언어의 웹 페이지 생성
 - 데이터베이스로의 입력, 수정, 삭제, 조회
 - XML 문서의 처리
 - 문자열을 처리하는 함수 호출

 JSTL 라이브러리는 위 기능을 크게 core, format, xml, sql, functions 5가지 커스텀 태그로 나누어서 제공해준다.

**커스텀 태그**
커스텀 태그 | 설명
-|-
기본 기능(core) | 일반 프로그램이 언어에서 제공하는 것과 유사한 변수 선언, 실행 흐름의 제어 기능을 제공하고, 다른 JSP 페이지로 제어를 이동하는 기능도 제공한다.
형식화(format) | 숫자, 날짜, 시간을 포매팅하는 기능과 국제화, 다국어 지원 기능을 제공한다.
데이터베이스(sql) | 데이터베이스의 데이터를 입력/수정/삭제/조회하는 기능을 제공한다.
XML 처리(xml) | XML 문서를 처리할 때 필요한 기능을 제공한다.
함수 처리(functions) | 문자열을 처리하는 함수를 제공한다.

<br>

 JSTL 역시 커스텀 태그이기 때문에 이를 사용하기 위해서는 추가적으로 라이브러리가 필요하다. 자바 웹 어플리케이션에서는 추가적인 라이브러리가 jar 파일 형태로 제공되고 이를 `WEB-INF/lib` 폴더 내에 복사해 두고 사용한다.    
 커스텀 태그 라이브러리인 JSTL 역시 jar 파일을 압축하여 배포한다. `jatl.jar`, `standard.jar` 이 두 파일을 구한 후에 JSTL을 설치해야 한다.
 
 <br>
 
 Jar 파일 이름 | 이름 | 설명
 -|-|-
 jstl.jar | JSRL API 클래스 | JSTL API 클래스
 standard.jar | JSTL 구현 클래스 | Standard Taglib JSTL 구현 클래스



<br><br><hr>

#### JSTL 다운로드 받아 설치하기

1. `http://jakarta.apache.org/` 접속 `taglibs` 클릭

![image](https://user-images.githubusercontent.com/84966961/126426013-e31cd306-0fc9-4ef1-bbea-e171a0617462.png)

2. `Apache Standard Taglib` 클릭

![image](https://user-images.githubusercontent.com/84966961/126426089-5061d879-e26a-4976-8831-e1a7de303c8f.png)

3. Standard 1.1 download 클릭

![image](https://user-images.githubusercontent.com/84966961/126426314-dda4f550-3d47-4c66-886c-3262c5f89d83.png)

4. `binaries/` 클릭

![image](https://user-images.githubusercontent.com/84966961/126426414-2c976630-978a-4e5e-bac5-2211793d338f.png)

5. `jakarta-taglibs-standard-1.1.2.zip` 클릭

![image](https://user-images.githubusercontent.com/84966961/126426455-faf5763c-49c3-4d50-9be7-36d54f6ddbc0.png)

6. 다운받은 파일(`jatl.jar`, `standard.jar`)을 압축해제 하여 `WEB-INF/lib` 폴더에 복사하여 라이브러리를 배포한다.

![image](https://user-images.githubusercontent.com/84966961/126426703-39588178-865a-42c6-8649-4d78d740b002.png)

![image](https://user-images.githubusercontent.com/84966961/126426676-7751b832-ce53-4663-9cf7-0ba7406d305b.png)



<br><br><hr>

### JSTL 태그 사용 방법

 태그 라이브러리를 사용하려면 JSP 페이지에 taglib 지시자를 추가하여 URI 식별자와 접두사를 연결해야 한다.   
    
 다음은 JSTL이 제공해 주는 기능 중 기본 기능인 core를 사용하기 위한 taglib 지시자이다. taglib 지시자는 `<%@`으로 시작해서 `%>`로 끝나며 uri와 prefix 속성을 사용하여 URI 식별자와 접두사를 지정한다.   
    
 자바의 import 처럼 하는 방식이다.

```
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prifix="c"%>
```
   
`"http://java.sun.com/jsp/jstl/core"` : 사용할 태그 라이브러리 식별자   
`"c"` : 태그에서 사용할 접두사   
   
다음은 JSTL의 기능 분류예 따른 태그 라이브러리의 URI 식별자와 접두사인 prefix를 정리한 표이다.   

기능 | prefix | 기본 URI
-|-|-
기본 기능 | c | `http://java.sun.com/jsp/jstl/core`
형식화 | fmt | `http://java.sun.com/jstl/fmt`
데이터베이스 작업 | sql | `http://java.sun.com/jstl/sql`
XML 처리  | x | `http://java.sun.com/jstl/xml`
함수 처리 | fn | `http://java.sun.com/jsp/jstl/fn`

 기본 기능 이외에는 자주 사용하지 않는다.    




<br><br><hr>

#### 교재 346p : `<c:out>` 태그로 간단한 메시지를 출력하는 JSP 페이지

**10_jstl.jsp**
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
<c:out value="Hello World!"/>
</body>
</html>
```




<br><br><hr>

## 교재 346p : JSTL core 태그

 다음은 가장 자주 사용되는 core 태그들을 정리해놓은 표이다.   

태그 | 설명
-|-
<c:set> | 변수에 값을 설정한다.
<c:remove> | 변수에 설정된 값을 제거한다.
<c:if> | 조건에 따라 처리를 달리할 때 사용한다.
<c:choose> | 여러 조건에 따라 처리를 달리할 때 사용한다.
<c:forEach> | 반복 처리를 위해서 사용한다.
<c:forTokens> | 구분자로 분리된 각각의 토큰을 처리할 때 사용한다.
<c:import> | 외부의 자원을 url을 지정하여 가져다 사용한다.
<c:redirect> | 지정한 경로로 이동한다.
<c:url> | url을 재작성한다.
<c:out> | 데이터를 출력할 때 사용하는 태그로 표현식인 `<%= %>`를 대체할 수 있다.
<c:catch> | 예외 처리에 사용한다.





<br><br><hr>

### 교재 348p : JSP와 JSTL의 차이점

 JSP에서는 다음과 같이 제공되는 특정 내장 객체(영역 객체) 범위 내에서 사용 가능한 속성을 저장하여 사용한다.   
 
```
				pageContext.setAttribute("msg", "Hellp");	// (변수 이름, 저장할 값)
```

하지만 JSTL의 `<c:set>`, `<c:remove>` 태그를 사용하면 보다 간편하게 내장 객체에 속성 값을 저장하고 사용할 수 있다.



<br><br><hr>

### 교재 348p : `<c:set>`과 `<c:remove>` 태그

 `<c:set>` 태그는 해당 범위(scope) 내에 속성을 생성하고 속성 값을 지정하는데 사용한다. 위의 코드와 같은 기능을 한다.

```
				// 기본형식
				<c:set var="변수 이름" value="저장할 값" [scope="{page|request|session|application}"]/>
				
				// 예시
				<c:set var="msg" value="Hello" scope="page"/>
```

 `<c:set>` 태그는 var와 value 속성을 설정 해주어야 하며 이미 var에 지정한 변수에 값이 존재한다면 새롭게 할당되고 존재하지 않는다면 변수가 새롭게 생성된 후에 지정한 값을 초기화 한다. value 속성에는 변수에 저장할 값을 지정한다. []으로 둘러싼 scope는 생략 가능한 부분이다. scope를 명시적으로 지정하지 않으면 page 영역에 변수가 저장된다.


**`<c:set>` 태그 속성 목록**
속성 | 설명
-|-
var | 변수 이름을 String 형으로 지정한다.
value | 변수에 저장할 값을 지정한다.
scope | 변수가 효력을 발휘할 영역으로 생략될 경우 기본 값은 page이다.


<br><br>

**`<c:set>` 몸체에 값 지정하기**

```
				<c:set var="변수 이름" [scope="{page|request|session|application}"]>
				
				
				
				</c:set>
```


<br><br><hr>

#### 교재 350p : `<jsp:setProperty>`보다 나은 `<c:set>` 태그

 자바 빈 객체의 필드에 값을 저장하기 위해서 액션태그 `<jsp:setProperty>`를 사용하여 프로퍼티를 사용했다. 프로퍼티란 앞서 언급한 바 있다시피 **자바 빈에서 setter, getter가 쌍으로 존재하는 필드**를 말하며 필드는 private로 선언되어 있어 필드에 값을 저장하거나 얻어오기 위해서는 setter와 getter를 사용해야 한다.    
     
 이와 마찬가지로 JSTL 에서도 액션 태그와 마찬가지로 자바 빈의 필드 값을 저장하기 위해서 프로퍼티를 사용한다.
 
 ```
		<c:set target="자바 빈 객체" property="프로퍼티 이름" value="저장할 값"/>
```

사용 방법은 액션 태그와 비슷하며 `<c:set>` 또한, 몸체에 value 값을 넣어 직접 기술할 수도 있다.

 ```
		<c:set target="자바 빈 객체" property="프로퍼티 이름" value="저장할 값">
		저장할 값
		</c:set>
```

이외에도 value 속성 내부에서 산술 연산이나 비교 연산도 가능하다.

```
		// 연산 예시
		<c:set var="add" value="${10 + 5}">			// 
		
		<c:set var="flag" value="${10 > 5}">		// 비교 연산
```

<br><br>

**11_jstlCore.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:set var="msg" value="Hello"></c:set>
\${msg} = ${msg}<br>
<c:set var="age">
30
</c:set>
\${age} = ${age}<hr>
<c:set var="member" value="<%= new javabeans.MemberBean() %>"></c:set>
<c:set target="${member}" property="name" value="전수빈" ></c:set>
<c:set target="${member}" property="userid">pinksubin</c:set>
\${member} = ${member}<hr>
<c:set var="add" value="${10 + 5}"></c:set>
\${add} = ${add}<br>
<c:set var="flag" value="${10 > 5}"></c:set>
\${flag} = ${flag}<br>

</body>
</html>
```
**결과 화면**   
![image](https://user-images.githubusercontent.com/84966961/126435968-69d0e907-b681-46c8-86e5-2cfbbfdc563e.png)

두번째 값은 오버라이드된 toString() 메서드를 통해 정리되어 표현되게 된다.


<br><br><hr>

#### 교재 354p : `<c:remove>` 태그

 `<c:remove>` 태그는 해당 scope에 있는 변수를 제거하는 역할을 한다.


```
				// 기본형식
				<c:remove var="변수 이름" [scope="{page|request|session|application}"]/>
				
				// 예시
				<c:remove var="age"/>
```

 디폴트 범위인 page에서 age 변수를 찾아 제거하였다.




<br><br><hr>

### 교재 355p : 흐름을 제어하는 태그

 흐름을 제어하는 태그를 설명하기 위해서 TSJL 라이브러리를 사용하는 이유를 설명하면서 살펴보았던 예를 다시 살펴보자.   
    
**Java 코드와 **
```
<%
if (request.getParameter("color").equals("1")){
%>
	<span style="color:red;">빨강</span>
<%
} else if (request.getParameter("color").equals("2")){
%>
	<span style="color:green;">초록</span>
<%
if (request.getParameter("color").equals("3")){
%>
	<span style="color:blue;">파랑</span>
<%
}
%>
```
**JTSL**
```
<c:if test="${param.color==1}">
	<span style="color:red;">빨강</span>
</c:if>
<c:if test="${param.color==2}">
	<span style="color:green;">초록</span>
</c:if>
<c:if test="${param.color==3}">
	<span style="color:blue;">파랑</span>
</c:if>
```

위의 코드처럼 깔끔하게 흐름을 제어할 수 있도록 제공하는 태그가 `<c:if>`이다. JSTL의 흐름을 제어하는 태그는 이런 불편함을 없애기 위해서 나온 것으로 if, choose, forEach, forTokens 등이 제공된다.


<br><br><hr>

### 교재 355p : `<c:if>`

 `<c:if>` 태그는 자바의 if~else 문과는 달리 선택은 할 수 없고 오직 if만 사용 가능하다.

```
 <c:if test="조건식">
 조건이 참일 경우 실행할 문장
 </c:if>
```



<br><br><hr>

#### 교재 356p 예제 : 색상 선택하기

**12_colorSelectForm.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="12_colorSelect.jsp">
		<label for="color">색상을 선택하세요.</label>
		<br />
		<select name="color" id="color">
			<option value="1">빨강</option>
			<option value="2">초록</option>
			<option value="3">파랑</option>
		</select>
		<input type="submit" value="전송">
	</form>
</body>
</html>
```

**12_colorSelect.jsp**
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
<c:if test="${param.color == 1}">
	<span style="color: red;">빨강</span>
</c:if>
<c:if test="${param.color == 2}">
	<span style="color: green;">초록</span>
</c:if>
<c:if test="${param.color == 3}">
	<span style="color: blue;">파랑</span>
</c:if>
</body>
</html>
```

**결과 화면**   
![image](https://user-images.githubusercontent.com/84966961/126435748-5db776b7-fd09-4784-94e4-048d20061d67.png)   
    
![image](https://user-images.githubusercontent.com/84966961/126435760-d7f70683-b7ff-496c-aa39-fde5bdbee85d.png)    
   

<br><br><hr>

### 교재 358p : `<c:choose>`

 `<c:choose>`는 `<c:if>`를 사용할 때 else를 사용하지 못하는 아쉬움을 해소할 수 있는 태그이다.

 `<c:choose>`는 `<c:when>`과 `<c:otherwise>`와 함께 사용하여 조건에 만족하지 않는 경우에 대해서도 다음과 같이 간단하게 처리할 수 있다.

```
				<c:choose>
				<c:when test="${param.userType == 'admin'}">
					${param.id}(관리자)
				</c:when>
				<c:otherwise>				// <c:otherwise>는 위에 제시한 <c:when>에 만족하지 않을 때 실행
					${param.id}(회원)
				</c:otherwise>
				</c:choose>
```

<br>

 `<c:choose>` 태그는 자바의 switch 문처럼 다양한 조건을 제시해서 여러 경우에 대해서도 간단하게 처리할 수 있다. 다음은  `<c:choose>` 태그의 기본형이다.


```
				<c:choose>
				<c:when test="조건1"> 몸체1	</c:when>	<!-- 조건1에 만족할 때 -->
				<c:when test="조건2"> 몸체2	</c:when>	<!-- 조건2에 만족할 때 -->
				<c:otherwise> 몸체3 </c:otherwise>     <!-- 조건에 만족하지 않을 때 -->
				</c:choose>
```

 `<c:choose>` 태그 내부에는 여러 개의  `<c:when>` 태그를 가질 수 있으며 순서대로 test 조건을 검사하여 결과가 참이면 태그의 몸체 부분을 실행한다.  `<c:when>` 태그 중 만족하는 태그가 없으면 `<c:otherwise>`의 몸체부분을 실행한다. 경우에 따라서는 `<c:otherwise>` 태그는 생략할 수 있다.



<br><br><hr>

#### 교재 359p 예제 : 과일 선택하기

**13_fruitSelectForm.jsp**
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
<body>
	<form action="13_fruitSelect.jsp">
		<label for="fruit">과일을 선택하세요.</label>
		<br />
		<select name="fruit" id="fruit">
			<option value="1">사과</option>
			<option value="2">메론</option>
			<option value="3">바나나</option>
		</select>
		<input type="submit" value="전송">
	</form>
</body>
</html>
```

**13_fruitSelect.jsp**
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
<c:if test="${param.fruit == 1}">
	<span style="color: red;">사과</span>
</c:if>
<c:if test="${param.fruit == 2}">
	<span style="color: green;">메론</span>
</c:if>
<c:if test="${param.fruit == 3}">
	<span style="color: blue;">바나나</span>
</c:if>
</body>
</html>
```




<br><br><hr>

### 교재 360p : `<c:forEach>`

 `<c:forEach>`는 배열(Array)이나 컬렉션(Collection) 또는 맵(Map) 등과 같은 집합체에 저장되어 있는 값들을 순차적으로 처리할 때 사용할 수 있는 태그이다. 기본 형식은 다음과 같다.

 ```
		<c:forEach [var="변수 이름"] items="배열과 같은 집합체" >
			몸체
		</c:forEach>
```

 items 속성에 배열과 같은 집합체를 지정하면 이곳에 저장된 각각의 항목에 대해서 몸체 부분을 반복한다. 이때 var 속성에 변수를 지정하면 items 속성에 저장한 집합체에 저장된 항목들이 순차적으로 var 속성에 지정한 변수에 저장된다. 이 변수는 반복되는 몸체 내부에서 사용할 수 있다.   
   
-> 마치 향포문 처럼 사용할 수 있다.



<br><br><hr>

#### 교재 361p 예제 : 영화 제목을 저장할 배열을 `<c:forEach>`태그를 사용하여 출력하기

**14_movieList.jsp**
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
<% 
String[] movieList ={"타이타닉","시네마 천국","혹성 탈출","킹콩"};
pageContext.setAttribute("movieList", movieList);
%>
<c:forEach var="movie" items="${movieList}">
	${movie}<br>
</c:forEach>
</body>
</html>
```

<br><br><hr>

 `<c:forEach>` 태그에 사용할 수 있는 속성 중에는 varStatus 속성이 있다. varStatus 속성은 배열이나 컬렉션과 같은 지밥체에서 ㅏㅇ목의 인덱스 값을 사용해야 할 경우가 생기는데 이때 사용하게 된다. varStatus 속성은 인덱스(index)는 물론 반복 횟수(count) 등과 같은 반복 상태에 관련된 정보를 프로퍼티로 알려준다.
 
 프로퍼티 | 설명
 -|-
 index | items에 지정환 집합체의 현재 반복 중인 항목의 index를 알려준다. 0부터의 순서가 부여된다.
 count | 루핑을 돌 때 현재 몇 번째를 반복 중인지 알려준다. 1부터의 순서가 부여된다.



<br><br><hr>

#### 교재 361p 예제 : 영화 제목을 저장할 배열을 `<c:forEach>`태그를 사용하여 출력하기



**15_movieList.jsp**
```jsp
	<%
		String[] movieList = { "타이타닉", "시네마 천국", "혹성 탈출", "킹콩" };
		pageContext.setAttribute("movieList", movieList);
	%>
	<table border="1" style="width: 100%; text-align: center;">
		<tr>
			<th>index</th>
			<th>count</th>
			<th>title</th>
		</tr>
		<c:forEach var="movie" items="${movieList}" varStatus="status">
			<tr>
				<td>${status.index}</td>
				<td>${status.count}</td>
				<td>${movie}</td>
			</tr>
		</c:forEach>
	</table>
```


<br><br><hr>

 index와 count 이외에도 다음과 괕은 프로퍼티들이 있다.



 프로퍼티 | 설명
 -|-
 first | 현재 루프가 처음인지 여부를 알려준다. 첫 번째일 경우에는 true를 아니면 false를 리턴한다.
 last | 현재 루프가 마지막인지 여부를 알려준다. 마지막일 경우에는 ture를 아니면 false를 리턴한다.


<br><br><hr>

#### 교재 364p 예제 : first, last 프로퍼티 사용하기

**16_movieList.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String[] movieList = { "타이타닉", "시네마 천국", "혹성 탈출", "킹콩" };
		pageContext.setAttribute("movieList", movieList);
	%>
	<ul>
		<c:forEach var="movie" items="${movieList}" varStatus="status">
			<c:choose>
				<c:when test="${status.first }">
					<li style="font-weight: bold; color: red;">${movie}</li>
				</c:when>
				<c:otherwise>
					<li>${movie}</li>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</ul>
	<c:forEach var="movie" items="${movieList}" varStatus="status">
${movie} <c:if test="${not status.last}">, </c:if>
	</c:forEach>
</body>
</html>
```
**결과 화면**   
![image](https://user-images.githubusercontent.com/84966961/126443086-98f3226f-3047-4582-9abe-72d0749d94f8.png)


<br><br><hr>

`<c:forEach>` 태그는 여러 가지로 활용이 가능하다. 객체를 받아와서 그 객체의 길이만큼 반복할 수도 있지만, begin, end 속성에 시작 번호와 끝 번호를 지정하고 step 속성을 이용해서 증가 구간을 정하여 원하는 만큼 반복 수행할 수 있다. 마치 자바의 for문과 같이 지정한 횟수만큼 반복하는 용도로 사용할 수 있다.

 ```
		<c:forEach [var="변수 이름"] begin="시작 값" end="끝 값" [step="증가치"] >
			몸체
		</c:forEach>
```

속성 | 설명
-|-
begin | 반복에 사용될 것 중 첫 번째 항목의 index
end | 반복에 사용될 것 중 마지막 항목의 index


<br><br><hr>

#### 교재 367p 예제 : begin, end 속성 사용하기

**17_movieList.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:forEach var="cnt" begin="1" end="10" varStatus="status">
${cnt} <c:if test="${not status.last }">, </c:if>
	</c:forEach>
	<br>
	<br>
	<table border="1" style="width: 100%; text-align: center;">
		<tr>
			<th>index</th>
			<th>count</th>
			<th>cnt</th>
		</tr>
		<c:forEach var="cnt" begin="7" end="10" varStatus="status">
			<tr>
				<td>${status.index}</td>
				<td>${status.count}</td>
				<td>${cnt}</td>
			</tr>
		</c:forEach>
	</table>
	<br>
	<br>
	<table border="1" style="width: 100%; text-align: center;">
		<tr>
			<th>index</th>
			<th>count</th>
			<th>cnt</th>
		</tr>
		<c:forEach var="cnt" begin="1" end="10" varStatus="status" step="2">
			<tr>
				<td>${status.index}</td>
				<td>${status.count}</td>
				<td>${cnt}</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>
```

**결과 화면**    
![image](https://user-images.githubusercontent.com/84966961/126444224-5a26dd58-0924-4217-a789-62c9f6e95a70.png)


<br><br><hr>

#### 교재 369p 예제 : 관심 분야 다중 선택하기

 이번에는 동일한 이름의 체크 박스가 여러 개 있는 HTML 문서에서 여러 개의 항목을 선택하여 전송된 정보를 얻어오도록 하자. 이를 위해서는 표현 언어에서는 paramValues를 사용한다. paramValues는 지정한 이름을 가진 파라미터의 모든 값을 배열 형태로 얻어오기 때문에 동일한 이름으로 여러 번 값이 전송되어도 이를 처리할 수 잇다.   
 배열로 얻어진 값은 JSTL의 `<c:forEach>` 태그를 사용하면 쉽게 화면에 출력할 수 있다.
 
**17_checkbox.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>악세사리</h2>
	관심항목을 선택하세요.
	<hr>
	<form method="get" action="17_paramValues.jsp">
		<input type="checkbox" name="item" value="신발"> 신발 <input
			type="checkbox" name="item" value="가방"> 가방 <input
			type="checkbox" name="item" value="벨트"> 벨트<br> <input
			type="checkbox" name="item" value="모자"> 모자 <input
			type="checkbox" name="item" value="시계"> 시계 <input
			type="checkbox" name="item" value="쥬얼리"> 쥬얼리<br> <input
			type="submit" value="전송">
	</form>
</body>
</html>
```
**결과 화면**   
![image](https://user-images.githubusercontent.com/84966961/126445020-d129b300-6980-4e03-88b8-ac8d3f0b328a.png)

**17_paramValues.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	당신이 선택한 항목입니다.
	<hr>
	<c:forEach var="item" items="${paramValues.item}" varStatus="status">
${item} <c:if test="${not status.last}">, </c:if>
	</c:forEach>
</body>
</html>
```
**결과 화면**   
![image](https://user-images.githubusercontent.com/84966961/126445099-164fbfb8-2fca-497e-ad8a-a39963b486f1.png)

결과 화면의 주소값을 보면 같은 이름으로 된 파라미터로 여러 개의 값이 넘어가는 것을 볼 수 있다.




<br><br><hr>

### 교재 370p : `<c:forTokens>`

 `<c:forTokens>` 태그는 java.util.StringTokenizer와 같이 문자열을 구분자로 분리해서 하나씩 추출할 수 있다. 형식은 다음과 같다.
 
 ```
 <c:forTokens var="토큰을 저장할 변수" item="토큰으로 나눌 문자열" delims="구분자">
 몸체
 </c:forTokens>
 ```

<br><br><hr>

#### 교재 371p 예제 : `<c:forTokens>` 콤마(,)와 닷(.)을 구분자로 사용하여 문자열로부터 토큰 추출하기

**18_forTokens.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:forTokens var="city" items="서울.인천,대구.부산" delims=",">
${city} <br>
	</c:forTokens>
	<hr>
	<c:forTokens var="city" items="서울.인천,대구.부산" delims=",.">
${city} <br>
	</c:forTokens>
</body>
</html>
```
**결과 화면**    
![image](https://user-images.githubusercontent.com/84966961/126445641-bf752c56-ec8e-47c4-b05c-7e78bad1db3b.png)



<br><br><hr>

### 교재 371p : `<c:import>`, `<c:redirect>`, `<c:cut>` 태그 사용하기 


<br><br><hr>

### `<c:import>` 태그

`<c:import>` 태그는 4장의 `<jsp:include>` 태그와 일맥 상통 하는 부분이 많다. 하지만 차이점 부분에서는 `<jsp:include>` 태그는 단수니 페이지를 포함시키지만 `<c:import>` 태그는 다른 페이지의 내용을 변수에 저장할 수 있다.

```
 <c:import url="URL" [var="변수 이름"] [scope="영역"] [charEncodin="charEncoding"]>
 </c:import>
```

 `<c:import>`는 url 속성에 지정된 서버에 접속해서 데이터를 읽어 와서 var 속성에 지정한 변수에 지정한다. scope에는 변수가 효력을 발휘할 수 있는 영역을 설정한다. var 속성을 생략하면 현재 위치에 URL로부터 읽어온 결과를 출력한다.


****
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:import url="http://localhost:8181/webstudy07/ExpressionLang/02_expression_language/02_el.jsp" var="data"></c:import>
${data}

</body>
</html>
```
**결과 화면**   
![image](https://user-images.githubusercontent.com/84966961/126446515-b7c29cda-0c12-4b3a-9730-c3f0591238f1.png)


`02_el.jsp`에 들어가서 싹다 data에 긁어 넣은 다음 `${data}`를 통해 출력해줌.


<br><br><hr>

### `<c:url>` 태그

 `<c:url>` 태그는 이후에 여러 번 반복되어 사용할 주소가 있다면 변수에 저장하기 위해서 사용한다.
 
 ```jsp
  <c:url value="URL" [var="변수 이름"] [scope="영역"]>
  </c:url>
```

**20_jstlUrl.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:url value="../images/pic.jpg" var="data"></c:url>
		<h3>${data}</h3>
		<img src="${data}" width='150' height='150'>
</body>
</html>
```
**결과 화면**   
![image](https://user-images.githubusercontent.com/84966961/126447095-bed21280-9df6-409d-a2f0-3a2d6d84b251.png)

`../`으로 이전 폴더로 빠져나가 찾아왔다.


<br><br><hr>

### `<c:redirect>` 태그

 `<c:redirect>` 태그는 response.sendRedirect() 메소드와 동일한 기능을 제공한다. 코드를 보다 간경하게 기술하여 지정한 페이지로 이동시키기 위해 사용한다.
 
 ```
  <c:redirect url="URL" [context="경로명"]>
```

**21_jstlUrl.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:redirect url="../20_url/20_jstlUrl.jsp"></c:redirect>
</body>
</html>
```
**결과 화면**   
![image](https://user-images.githubusercontent.com/84966961/126447496-e67b2012-9985-41d4-8f9f-cb9e7d7580aa.png)

주소값도 21에서 20으로 이동한 것을 알 수 있다.


<br><br><hr>

### `<c:out>`과 `<c:catch>` 태그 사용하기

 `<c:out>` 태그와 함께 예외 처리를 위한 `<c:catch>` 태그의 사용 방법과 역할도 함께 살펴보자.


<br><br><hr>

### `<c:out>`

 `<c:out>` 태그는 value 속성에 지정한 문자열 혹은 변수의 내용을 출력할 때 사용하는 태그로서 JSP의 표현식 `<%= %>`이나 표현 언어와 동일한 역할을 한다. 주로 출력을 위해서는 `${ }`를 사용하지만 JSTL에서도 출력을 위한 태그가 제공되기에 이를 사용할 수도 있다. `${ }`보다 자주 사용되지는 않는다.

```
 <c:out value="value" [default="기본값"]>
```

속성 | 설명
-|-
value | 출력할 값을 지정한다.
default | 지정한 값이 없을 경우 사용할 값을 지정한다.


```
 // 예시
 <c:out value="${age}" [default="10"]>
 
 <c:out value="${age}">
 	10
 </c:out>
```

 위의 두 코드는 같은 코드이다.



<br><br><hr>

### `<c:catch>`

 자바 코드에서는 예외 처리를 위해서 try ~ catch로 기술한다면 이를 JSTL에서는 `<c:catch>`를 사용한다. `<c:catch>` 몸체 부분에 예외가 발생할 가능성이 있는 코드를 기술하여 예외가 발생하면 이를 잡아내는 역할을 한다.
 
 ```
 <c:catch var="변수 이름"> 
	예외가 발생할 수 있는 코드
 </c:catch>
```

 var 속성을 지정해서 변수를 선언하면 그 변수에 예외의 내용이 들어가게 된다. 다음의 예는 0으로 나눌 경우 예외가 발생하게 되므로 이를 예외 처리를 위한 `<c:catch>` 태그에 기술한다. 예외 메세지는 var에 지정한 errmsg 변수에 저장된다.


 ```
 <c:catch var="errmsg"> 
 	예외 발생 전
	<%= 1/0 %>
	예외 발생 후
 </c:catch>
```

예제


<br><br>

**22_jstl.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:set var="age" value="30" scope="page"></c:set>
나이:<c:out value="${age}">10</c:out>
		<br>
		<c:remove var="age" scope="page"></c:remove>
나이:<c:out value="${age}">10</c:out>
			<br>
			<c:catch var="errmsg">
예외 발생 전<br>
				<%=1 / 0%><br>
예외 발생 후<br>
			</c:catch>
			<c:out value="${errmsg}">></c:out>
</body>
</html>
```
**결과 화면**    
![image](https://user-images.githubusercontent.com/84966961/126449489-3497aa68-03b0-4401-b75d-b9ce7721ee87.png)    

-> `<c:catch>` 태그 자체는 자바로 치면 try문이며 catch문에 들어가는 내용이 var 속성에 담겨 출력되는 것이다.    








<br><br><hr>





