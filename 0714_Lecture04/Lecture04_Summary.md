# Lecture04 3장 JSP 기본 다루기
Key Word : JSP 기본 태그, 스크립트릿, 주석문, 선언문, 내장 객체, out, request   

<hr>
 
## 교재 145p : JSP 기본태그
   
 HTML이나 자바스크립트에 의해 작성된 페이지들은 그 페이지를 사용하는 사용자와 상관없이 항상 동일한 내용만을 제공해주는 정적 페이지이다. JSP 기본 태그를 이용해서 동적인(매번 정보에 따라 바뀌게 되는) 웹페이지를 작성할 수 있다.   

종류 | 사용 용도 | 형식
---|---|---
스크립트릿(scriptlet) | 자바 코드를 기술함 | <% %>
선언(declaration) | 변수와 메소드를 선언함 | <%! %> 
표현식(expression) | 계산식이나 함수를 호출한 결과를 문자열 형태로 출력함 | <%= %>
주석(Comment) | JSP 페이지에 설명을 넣음 | <%-- --%>
지시자(Directive) | JSP 페이지의 속성을 지정함 | <%@ %>

<br><br>
<hr>
 
### JSP 스크립트 요소

### 스크립트릿

**JSP 스크립트릿**
```java
	<%
		// 자바코드를 작성할 수 있다.
		int num1 = 10;
		int num2 = 20;
		int add = num1 + num2;
	%>
	
	<%= num1 %> + <%= num2 %> = <%= add %>
```

<br><br>
 
#### out이라는 내장 객체
 
 여기서 out은 일반적인 자바 프로그램의 System.out이 아니다. 서블릿에서 요청이 있을 때마다 호출되는 doGet 혹은 doPost 메소드에서 클라이언트에 응답을 하기 위해서 response.getWriter() 메소드로 얻어낸 PrintWriter로 선언한 out 객체와 동일하다. **서블릿에는 객체를 생성한 후 사용하지만 JSP 페이지에서는 out이 내장 객체 형태로 제공**된다.

-> JSP에서는 내장 객체로서 제공해준다. 실제 서블릿으로 변환된 파일로 가보면 PrintWriter 를 선언하여 out을 사용하고 있다.



<br><br>
<hr>
 
 
### 선언문(Declaration)
 
 실제로는 선언문에는 변수나 메소드를 정의하기 위해서 사용한다. 하지만 스크립트릿에는 메소드를 정의할 수 없기 때문에 선언문을 이용해서 메소드를 사용하게 된다.
 
 <br>
 
 **`<% %>`을 이용해서 선언하지 않는 이유**
```
 `<% %>` 내에 기술한 코드는 JSP가 서블릿 코드로 변환되었을 때 _jspService() 메소드 내부에 들어간다.
 (지역 변수로 들어감. but 선언문에 만들어진 것은 전역 변수로 만들어짐.) 
 
 static 변수나 메소드 정의는 메소드 내부에 할 수 없고 클래스 영역에 선언해야 하는데 `<%! %>`안에 기술한 코드들은 클래스 영역에 정의되기 때문이다.
 
 ```
 
 <br><br>
 
 #### 교재 150p : 선언문에 변수 선언과 메소드 정의하기
 
 **myCount.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
	String str = "안녕하세요";
	int a = 5, b= -5;
	
	public int abs(int n) {
		if (n < 0) {
			n = -n;
		}
		return n;
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
	int count = 0;
	out.print("count : ");
	out.println(++count);
	
	out.print(str+"<br>");
	out.print(a+"의 절대값 : "+abs(a)+"<br>");
	out.print(b+"의 절대값 : "+abs(b)+"<br>");
%>
</body>
</html>
```
    
**결과 화면**    
 ![image](https://user-images.githubusercontent.com/84966961/125543556-ea0486c9-b148-441e-b3b5-e389e8c70b86.png)    
 
 
  <br><br> 
 
 선언문의 위치는 중요하지 않다. 아래 코드처럼 html 밖 최 외곽 아랫 부분에 두어도 작성한 메소드가 잘 작성하는 것을 볼 수 있다. jsp를 서블릿으로 변환할 때 문서를 전체 읽고 하기 때문일듯 하다.    
 
 
 **myCount.jsp : 선언문을 뒤로 했을 때**
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
	int count = 0;
	out.print("count : ");
	out.println(++count);
	
	out.print(str+"<br>");
	out.print(a+"의 절대값 : "+abs(a)+"<br>");
	out.print(b+"의 절대값 : "+abs(b)+"<br>");
%>
</body>
</html>

<%!
	String str = "<br>안녕하세요";
	int a = 5, b= -5;
	
	public int abs(int n) {
		if (n < 0) {
			n = -n;
		}
		return n;
	}
%>
```
 
**결과 화면**    

![image](https://user-images.githubusercontent.com/84966961/125543884-de087012-6389-490b-8dc6-9d29ffceac58.png)


 
 <br><br>
 
 #### 교재 152p : 선언문에 선언한 변수와 스크립트릿 변수의 성격파악하기
 
 위에서 설명 했던 것처럼 `<% %>` 스크립트릿 내부에서 선언한 변수는 지역 변수로`<%! %>` 선언문 내부에서 선언한 변수는 멤버변수, 전역변수, 필드로 서블릿 컨테이너가 JSP를 서블릿으로 변환할 때 변경한다.   
 
 **myCount.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
	String str = "안녕하세요";
	int a = 5, b= -5;
	
	public int abs(int n) {
		if (n < 0) {
			n = -n;
		}
		return n;
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
	int count = 0;
	out.print("count : ");
	out.println(++count);
	
	out.print(str+"<br>");
	out.print(a+"의 절대값 : "+abs(a)+"<br>");
	out.print(b+"의 절대값 : "+abs(b)+"<br>");
%>
</body>
</html>
```
 <br><br>
 
 새로 고침할 때마다 `globla_cnt`가 올라가게 된다.    
    
 ![image](https://user-images.githubusercontent.com/84966961/125545690-784adf0d-5dd9-47c9-b00c-8864df3f93f3.png)   
   
 작성 후 run 하여 웹서버에 올리게 되면 그 과정에서 자동으로 서블릿 컨테이너가 우리가 작성한 jsp 파일을 서블릿 파일로 변환시켜 준다.


**변환된 서블릿 java 파일들**
![image](https://user-images.githubusercontent.com/84966961/125544510-a5e260e7-4870-44c0-baa3-10e33da7188f.png)

**count_jsp.java**
```java
public final class count_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {


	int global_cnt = 0;											// 전역 변수

// 중략

// 항상 만들어지는 jspService 메소드 여기서 HTML 코드를 작성한다.
  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException {
	  
// 중략

      out.write('\r');
      out.write('\n');
      out.write("\r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<meta charset=\"UTF-8\">\r\n");
      out.write("<title>Insert title here</title>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");

	int local_cnt = 0;											// jspService 메소드의 지역변수 

	out.print("<br> local_cnt : ");
	out.println(++local_cnt);
	
	out.print("<br> global_cnt : ");
	out.println(++global_cnt);

      out.write("\r\n");
      out.write("</body>\r\n");
      out.write("</html>");
	 
// 중략
```


<br><br>
<hr>
 
 
### 표현식(Expression)
 
 브라우저에 HTML 형태로 결과를 출력하기 위해서 스크립트릿 태그 내에 jsp 내장 객체 중 출력 담당 out의 print 메소드를 사용했다.   
 
 ```jsp
 <%
 	out.print(a);
%>
```
    
 JSP에서 브라우저로 출력하기 위해서 사용하는 또 다른 방법은 **표현식**이다.   
    
 표현식(expression)은 변수의 값이나 계신식 혹은 함수를 호출한 결과를 문자열 형태로 웹 문서를 출력할 때 사용되는 태그이며 `<%= %>` 형태로 구현한다.   
 
 ```jsp
<%=
 	a
%>
 ```

서블릿 컨테이너는 `<%= %>`을 만나면 out.print()로 변환한다.     

 <br>
 
 **`<%= %>` 사용시 주의해야 할 점**
 
 표현식에 기술한 내용은 out.print()의 매개 변수가 되기 때문에 표현식을 사용할 떄 세미콜론(;)을 기술하지 말아야 합니다. 표현식에 세미콜론(;)을 입력했다면 아래와 같이 변환되기 때문이다.   
 
```
	<%= a ; %>   ->   out.print(a ; );
 ```
 
 <br><br>
 
 #### 교재 152p : 표현식(Expression)의 사용 예
    
 기존 예제를 표현식으로 바꾸어 생각해보자.
 
 ```jsp
 <body>
<%= str %>
<%= a %> 의 절대값 : <%= abs(a) %> <br>
<%= b %> 의 절대값 : <%= abs(b) %> <br>
%>
</body>
</html>
```


<br><br>
<hr>
 
 
### 주석문(Comments)
 
 HTML을 작성하다가 설명을 덧붙이기 위한 주석문은 다음과 같다.      
 
 ```html
<!-- 주석문 -->
```
    
 다음은 JSP 주석문이다.   
 
```jsp
<%-- 주석문 --%>
```

 HTML의 주석문과 JSP의 주석문은 실행에 아무런 영향을 주지 않는다는 공통점이 있지만 JSP 컨테이너는 두 주석문을 서로 다르게 인식한다. HTML 주석문은 웹 컨테이너가 그대로 클라이언트에 보낸다. 브라우저는 이 부분을 주석으로 처리한다. 반면 **JSP 주석문은 브라우저에 보내지지 않아 공개되지 않는다.**    
    
 HTML 주석문과 JSP 주석문은 적절하게 사용되어야 한다. 사용자에게 혼동을 줄 수 있기 때문이다.   




<br><br>
 
#### 주석문(Comments) : 한줄 주석(//)
 
```jsp
<%
	// 주석문 
	// 여러줄 주석 처리
	// 여러번 `//` 기술
%>
```



<br><br>
 
#### 주석문(Comments) : 여러줄 주석(/*...*/)
 
```jsp
<%
	/* 	주석문 
	 	여러줄 주석 처리
	 	/*   */로 가두기 
	*/
%>
```


<br><br>
<hr>
 
 
### 지시자(Directive)
   
 JSP 지시자(Directive)는 태그 안에서 @로 시작하며 page, include, taglib 3가지 종류가 있다. 지시자는 클라이언트의 요청에 의해 JSP 페이지가 실행되면서 지시자에 언급된 설정을 JSP 페이지 전체에서 사용 가능하도록 한다. 지시를 내리는 것도 방법이 있고 규칙이 있다.   
 
 지시자가 없다면 HTML 파일과 다를게 없다. 지시자(Directive)는 JSP 페이지에 대한 전체 속성을 지정하며 JSP 문서의 제일 위 부분에 위치한다. 형식은 다음과 같다.   

```jsp
<%@ 지시자 속성 ="값", ... %>
```

 JSP 페이지에서 JSP 컨테이너에 대해 지시할 각종 정보들을 포함하는 문장이다.    

종류 | 사용 용도 
---|---
page | 해당 JSP 페이지 전반적으로 환경을 설정할 내용을 지정한다. 
include | 현재페이지에다른 파일의 내용을 삽입할 때 사용한다.
taglib | 태그 라이브러리에서 태그를 꺼내와 사용할 수 있는 기능을 제공한다.



<br><br>
 
#### 교재 160p : page 지시자
    
 다음은 페이지 지시자의 기본 형식이다.   
 
 ```
 <%@ page 속성="값" ... %>
 ```

<br><br>

**language 속성**

 ```
 <%@ page language="java" ... %>
 ```



<br><br>

**extends 속성**

 서블릿 클래스로 변환되는 과정에서 상속받을 부모 클래스를 지정하는 속성이다. 기본적으로 서블릿 컨테이너에서 알아서 처리하므로 개발자가 특별히 지정한느 경우는 없다.

 ```
 <%@ page extends="javax.servlet.jsp.HttpJspBase" ... %>
 ```


<br><br>

**import 속성**

 import 속성은 자바 프로그램에서 사용하던 import 구문과 동일한 목적으로 하요안다. 자바에서 이미 만들어진 자바 클래스를 가져다 사용할 때 해당 클래스가 소속된 패키지를 명시해주듯이 JSP에서도 마찬가지로 import 속성에 JSP 에서 사용될 클래스의 풀네임으로 기술해 놓으면 클래스명만 기술해서 해당 클래스를 사용할 수 있게 되어 편리하다. 오늘 날짜를 출력하기 위해서 날짜 관련 클래스를 사용하기 위한 예이다.

 ```
 <%@ page import="java.util.Calendar" ... %>
 ```

**06_import.jsp**
```jsp
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Calendar" %>
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
Calendar date = Calendar.getInstance();
SimpleDateFormat today = new SimpleDateFormat("yyyy년 MM월 dd일");
SimpleDateFormat now = new SimpleDateFormat("hh시 mm분 ss초");
%>

오늘은 <b> <%= today.format(date.getTime()) %></b> 입니다. <br>
지금 시각은 <b> <%= now.format(date.getTime()) %></b> 입니다. <br>
</body>
</html>
```

**결과 화면**    
![image](https://user-images.githubusercontent.com/84966961/125549472-75676f91-e4b1-4e56-93de-0ffcdecb03aa.png)
   

----------이 후로는 보통 기본값으로 두고 사용한다.------------------------------------------------------------

<br><br>

**session 속성**

 session 속성은 "true" 또는 "false" 값으로 세션을 사용할지 말지를 결정하는 속성이다. session 속성은 기본적으로 true 값으로 설정되어 있어 JSP 페이지에서는 사용할 수 있습니다. 하지만 세션을 사용하지 않으면 다음과 같이 false 속성을 지정해야 합니다.   
  
```jsp
<%@ page session="false" %>
```

<br>

**세션이란?**
```
 세션은 웹 서버의 서비스를 받는 사용자를 구분할 수 있는 단위이다. 클라이언트들은 브라우저를 실행한 후 하나의 웹사이트에만 머무르지 않고 쉬지 않고 여러 웹사이트들을 이동한다. 그러다가 다시 이전 웹사이트로 돌아갈 경우 이전에 로그인 한 정보라든지 구입한 상품 내역들이 그대로 유지되는 것을 볼 수 있다. 이것은 세션을 사용하기 때문이다. 여러 사이트를 돌아다녀도 사용자가 웹 서버의 세션에 의해 가상적으로 연결되어 있으므로 그에 대한 정보 역시 잃지 않게 되는 것이다.
```



<br><br>

**buffer 속성**
 브라우저에서 동영상 파일을 보기 위해 클릭하면 "buffering..."이란 메세지가 나타나고 조금 있다가 원하는 화면이 제공된다. 얼마간의 시간이 지나고 나면 다시 "buffering..."이란 메시지가 나타나고 얼마간의 시간이 흘러야 동영상 파일을 볼 수 있다.   
     
 웹 서버로부터 동영상 서비스를 받기 위해서는 서버로부터 데이터들이 출력 스트림을 통해서 제공될 때까지 기다려야 한다. 동영상 파일이 지정된 사이즈만큼 출력 버퍼에 보내질 때까지 기다렸다가 꽉 차면 출력 스트림을 통해 클라이언트에 전송된다. 데이터의 사이즈가 크면 블록 단위로 나뉘어서 전송된다. 전송할 데이터의 블록의 크기를 설정하는 것이 바로 버퍼 사이즈를 설정하는 것이다. 출력 스트림을 출력되기 전에 버퍼에 데이터가 찰 때까지 기다렸다가 보내진다.   
   
 buffer 속성의 기본 값은 8KB로 설정되어 있으므로 buffer 속성을 지정하지 않으면 JSP 엔진(JSP&서블릿 컨테이너)은 buffer 사이즈를 8KB로 사용한다.   
   
 여기서 8KB는 전송을 위한 최소 블럭 단위라고 생각하면 된다. 버퍼 용량을 크게 마련해 두었는데 그 용량이 차지 않으면 찰 때까지 전송하지 않고 기다리므로 오히려 용량을 적게 여러번 전송하는 것이 데이터가 전송되지 않고 기다리게 되는 일을 방지 할 수 있다.    





<br><br>

**autoFlush 속성**





<br><br>

**isThreadSafe 속성**

 자바의 스레드를 사용할지 말지 정하는 속성. 보통은 사용하거나 사용하지 않더라도 굳이 속성을 건들일 필요가 없다.    



<br><br>

**info 속성**

 JSP 페이지에 대한 간략한 설명을 기록하는 용도로 사용된다. 주로 JSP 문서를 작성한 프로그래머가 페이지 관리를 손쉽게 하기 위해 설정하는 속성이다. 없더라도 페이지 처리에 문제가 생기기 않는 속성이다.    
 
 

<br><br>

**erroPage 속성**

 JSP 페이지에서 에러가 발생하였을 때 보여줄 에러 페이지를 설정하는 속성이다.



<br><br>

**isErroPage 속성**

 현재의 페이지가 에러 페이지인지 아닌지를 설정하기 위한 속성이다.



<br><br>


**에러 발생 페이지와 에러 페이지 만들기**
    
 먼저 다음과 같은 코드를 작성한 후 errorPage 속성이 있을 때와 없을 때를 비교해보자.
	
**07_divde.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- JSP 페이지에서 에러가 발생하였을 때 보여줄 에러 페이지로 error.jsp를 설정 --%>
<%@ page errorPage="error.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
0으로 나누는 것을 불능 입니다.
<%-- 강제로 예외를 발생시킴 --%>
<%= 2/0 %>
</body>
</html>
```

**error.jsp**
```
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 현재 페이지가 에러 페이지임을 설정 --%>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	다음과 같은 에러가 발생하였습니다.
	<%= exception.getMessage()  %>
</body>
</html>
```

**예외 처리 페이지가 없을 때와 있을 때의 사진**    
    
![image](https://user-images.githubusercontent.com/84966961/125551372-ee280aec-4702-4e38-962f-4ec4f20d37b1.png)

![image](https://user-images.githubusercontent.com/84966961/125551392-a7133f44-801b-45f5-af58-b5a100f3644e.png)






<br><br>

**contentType 속성**

contentType 속성은 JSP 페이지의 MIME 타입을 결정한다. MIME(Multipurpose Interne Mail Extensions)은 서버가 브라우저(클라이언트)에게 "이런 데이터를 보낼 것이다!"라고 헤더에 포함하여 미리 알려주는 역할을 결정한다. MIME 타입을 적정하게 지정하지 않으면 클라이언트의 브라우저에 데이터가 제대로 보이지 않는다.   
   
그렇기 때문에 우리는 다음과 같이 text파일인 html임을 보낼 것과 문자 인코딩 방식이 UTF-8을 기본으로 한다는 것을 알려주는 것이다.   
   
```
<%@  contentType="text/html; charset=UTF-8"%>
```

다만, contentType 속성을 지정하지 않으면 기본적으로 "text/html"로 설정된다. 서블릿을 학습하면서 사용했던 response.setContentType("text/html")로 MIME 타입을 지저아던 것을 JSP 에서는 페이지 지시자를 사용하여 지정한다.   

charset 속성을 지정하지 않으면 기본적으로 "ISO-8859-1"로 설정된다. "ISO-8859-1"은 알파벳을 표현하기 위해 사용되는 8bit로 구성된 charset이다. 그러므로 `UTF-8`로 지정해야 16bit ㅘㄱ장 완성형으로 처리하기 때문에 한글이 깨지지 않는다.   


<br><br><br>
 
#### 교재 169p : include 지시자
    
 include 지시자는 현재 페이지에 다른 HTML 문서나 JSP 페이지의 내용을 삽입할 때 사용한다. include 지시자의 유일한 속성인 file에는 삽입할 파일의 URL을 기술한다.    
 
```jsp
<%@ include file="URL" %>
```
 
 JSP 페이지에 include 지시자를 사용하면 서블릿 컨테이너는 file 속성 다음에 기술한 파일을 JSP 파일 안으로 포함시킨다.   
    
 웹사이트를 구축하다 보면 모든 페이지에서 공통적으로 보여주어야 할 부분이 있다. 예를 들어 로고나 페이지 하단에 보이는 저작권 표시 등이다. 다음은 저작권을 보여주는 내용을 footer.jsp에 저장하고 이를 include 지시자로 포함히키는 예이다.   
 
```jsp
<%@ include file="footer.jsp" %>
```
 
파일 이름 | 설명 
---|---
footer.jsp | 모든 페이지에 공통적으로 사용되는 저작권 관련 내용이 있는 페이지 
08_main.jsp | 메인 페이지
08_sub.jsp | 서브 페이지


<br><br>


**include 지시자 위한 예제**
    
 include 지시자를 사용하게 되면 HTML 파일을 구성할 때 구성 요소들을 조각내어 좀 더 동적인 페이지 구성이 가능하다.    

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<hr>
<div id = "copyright">
All contents Copyright 2014 Nonage Inc. all rights reserved<br>
Contact mail : Nonage@Nonage.com Tel : +82 64 123 4315 Fax + 82 64 1234321
</div>
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
<h3> 프론트 페이지 </h3>
<a href="08_sub.jsp"> 서브 페이지로 이동하기 </a><br>
<%@ include file = "08_footer.jsp" %>
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
<h3> 서브 페이지 </h3>
<a href="08_main.jsp"> 메인 페이지로 이동하기 </a><br>
<%@ include file = "08_footer.jsp" %>
</body>
</html>
```

**결과 화면**    
![image](https://user-images.githubusercontent.com/84966961/125553676-f0069d62-fb37-4941-8b4d-1e34b0aba4c7.png)   
   
![image](https://user-images.githubusercontent.com/84966961/125553704-ceebf705-2ccf-464a-a72c-ebd52eafaefb.png)   


 
<br><br>
<hr>

## Mission03 

문제 조건
```
<%!

// 1. int 형 변수 하나를 정의하고 12345로 초기화 한다.
// 2. reverse() 메소드를 정의한다.
// 3. 반환 타입은 int 형으로 한다.
// 4. 54321로 리턴하는 함수를 만든다.

%>
```

**mission03.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!

// 1. int 형 변수 하나를 정의하고 12345로 초기화 한다.
	int num = 12345;
// 2. reverse() 메소드를 정의한다.
// 3. 반환 타입은 int 형으로 한다.
// 4. 54321로 리턴하는 함수를 만든다.
	int reverse(int n) {
		int result = 0;
		for (int i = 0; n > 0; i++) {
		//while (n != 0) {		
			result = result*10 + (n % 10);
			n /= 10;
		}
	
	return result;
	}

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>초기값을 뒤집어 출력하는 함수 만들기</h2>

	초기값 : <%=num %><br>
	결과값 : <%=reverse(num) %>

</body>
</html>
```

**결과 화면**    
![image](https://user-images.githubusercontent.com/84966961/125565031-10ceea34-6f0d-47af-be3e-ae2f55e6c4d5.png)



 
<br><br>
<hr>

## 교재 177p : Mission

풀어보기


tip

서버 창에서 더블클릭하여 서버를 열고 module 탭을 보면 연결된 프로젝트들을 확인가능하다.

![image](https://user-images.githubusercontent.com/84966961/125567994-fd18cb6e-d2c4-4850-9951-10b6eede6303.png)







<br><br>
<hr>

# 교재 180p : 4장 JSP 내장 객체와 액션 태그

## JSP 내장 객체

 JSP 내장 객체는 JSP 페이지에서 개발자가 객체를 생성하는 과정 없이 바로 사용할 수 있는 객체를 말한다. JSP에서 내장 객체를 바로 사용할 수 있는 이유은 JSP 서블릿 파일로 변환될 때 JSP(서블릿) 컨테이너가 객체를 자동적으로 생성해 주기 때문이다.   
    
 2장에서 서블릿을 학습하면서는 out 객체를 사용하기 위해서 response 객체의 getWriter()를 호출하여 얻어온 후에 사용하였지만 JSP 내장 객체는 JSP 파일 내부에서 out 객체를 선언하지 않고도 out을 사용할 수 있다.
    
 JSP에는 총 9 개의 내장 객체가 제공되며 이들은 4가지 형태로 분류된다.    

내장 객체의 분류 | 내장 객체 | 반환값  | 설명
---|---|---|---
입출력 관련 객체 | request <br> response <br> out | httpServletRequest <br> httpServletResponse <br> JspWriter | 웹 브라우저의 요청 정보를 저장하고 있는 객체 <br>웹 브라우저의 요청에 대한 응답 정보를 저장하는 객체 <br>JSP 페이지의 출력할 내용을 가지고 있는 출력 스트림 객체
서블릿 관련 객체 | page<br>config |  Object<br>ServletConfig | JSP 페이지를 구현한 자바 클래스 객체<br>JSP 페이지에 대한 설정 정보를 담고 있는 객체
외부 환경 정보를 제공하는 객체 | session<br>application<br>pageContext  | HttpSession<br>ServletContext<br>PageContext | 하나의 웹 브라우저 내에서 정보를 유지하기 위한 세션 정보를 저장하고 있는 객체<br>웹 애플리케이션 Context의 정보를 담고 있는 객체<br>JSP 페이지에 대한 정보를 저장하고 있는 객체
예외 관련 객체 | exception | Throwable | JSP 페이지에서 예외가 발생한 경우 사용하는 객체



<br><br><hr>

### out 내장 객체

 out은 서버에서 클라이언트로 열려있는 출력 스트림을 의미한다. out 객체는 JSP의 실행 결과를 클라이언트의 브라우저로 출력할 때 가장 효율적으로 사용할 수 있는 객체이다. 서블릿 컨테이너가 JSP 문서를 변환시켜 생성해 준 서블릿 파일을 살펴 보면 out 객체가 JspWriter로 선언됨을 확인할 수 있다.   

```
				printWriter out = response.getWriter();
```

 위 코드 중 response는 PrintWriter 객체를 리턴하는 메소드이다. 아마도 다음과 같지 않을 까...   
  
```java
 PrintWriter response() {
 ...
 return ...;
 }
```
  
![image](https://user-images.githubusercontent.com/84966961/125570169-bcaaa424-79fa-455c-8318-18621431cc45.png)    

<br><br><hr>

### request 내장 객체

 웹 서비스라 함은 웹 기반으로 클라이언트의 요청을 받아서 어떤 응답을 제공해 주는 서비스를 말한다. 이런 웹 서비스를 위한 클라이언트와 웹 서버사이의 요청과 관련된 정보는 request 객체에 저장되어 관리된다. 그러므로 request 객체를 파악하면 클라이언트에서 서버로 전송되는 데이터를 알 수 있다.    
   
**request 특징**   
1. HTTP 헤더와 HTTP 바디로 구성   
2. 웹 컨테이너가 요청된 HTTP 메세지를 통해 HttpServletRequest 객체를 얻어냄   
3. JSP 페이지에서는 HttpServletRequest 객체를 request 객체명으로 사용   



 다음은 브라우저의 요청이 있을 때 이와 관련된 정보들을 알려주는 메소드이다.   

메소드	|설명
---|---
String getContextPath() : String|	해당 JSP페이지가 속한 웹 애플리케이션의 콘텍스트 경로 리턴.<br> 콘텍스트 경로는 웹 애플리케이션의 루트 경로
String getMethod()|	요청에 사용된 요청 방식(GET, POST 등) 리턴
String getRequestURL()|	요청에 사용된 URL 주소 리턴
String getRequestURI()|	요청에 사용된 URL로부터 URI값 리턴
String getQueryString()| 요청에 사용된 QueryString 리턴
String getSession(flag)| 요청과 관련된 세션 객체를 리턴
String getRequestDispacher(path) | 지정 로컬 URL에 대한 RequestDispacher 객체를 리턴
String getRemoteHost()|	웹 서버로 정보를 요청한 웹 브라우저의 host 이름 리턴
String getRemoteAddr() : String | 웹 서버로 정보를 요청한 웹 브라우저의 ip 주소 리턴
String getRemoteUser()|	요청한 사용자의 이름을 리턴
String getSession()|  세션 객체를 리턴
String getServerName()|	서버의 도메인 이름 리턴
String getProtocol()|	웹 서버로 요청 시 사용 중인 프로토콜 리턴
String getServerPort()|	웹 서버로 요청시 서버의 port 번호 리턴
String getHeader(name)|	웹 서버로 요청 시 HTTP 요청 header 이름인 name에 해당하는 속성값 리턴
Enumeration getHeaderNames()|	HTTP 요청 header에 있는 모든 헤더 이름 리턴


**출력 화면 : 01_requestInfo.jsp**   
![image](https://user-images.githubusercontent.com/84966961/125571768-555193bb-c86e-45f5-83d1-7a45908af6b8.png)


 다음은 요청 파라미터 관련 메소드를 정리한 표이다.

메소드|설명
---|---
String getParameter(name)|	파라미터 변수 name에 저장된 값을 얻어내는 메소드<br> 해당 변수명이 없으면 null 리턴<br>단독값을 입력하는 text, select, radio 등에 사용
String[] getParameterValues(name)|	파라미터 변수 name에 저장된 모든 값을 얻어내는 메소드<br>변수값은 String 배열로 리턴<br>다중값을 입력하는 checkbox 등에 사용
Enumeration getPrameterNames()|	요청에 의해 넘어오는 모든 파라미터 변수를 java.util.Enumeration 타입으로 리턴<br>변수가 가진 객체들을 저장하기 위해 Enumeration 컬렉션 사용


<br><br>


URL & URI

URL(Uniform Resource Locator)   
웹상에서 서비스를 제공하는 각 서버들이 응답 시 전송하는 파일들의 위치를 명시하기 위한 것   
접속해야 할 서비스의 종류, 도메인명, 파일 위치 포함   

URI(Uniform Resource Identifier)   
URL로부터 존재하는 자원을 식별하기 위한 일반적인 식별자를 규정하는 것   
URL에서 HTTP 프로토콜, 호스트명, port 번호를 제외한 부분이 URI   
ex) URL: http://127.0.0.1:8080/study/ch04/requestTest1.jsp   
URI: study/ch04/requestTest1.jsp   




<br><br><hr>

#### request : 설문 조사 폼 만들기

 지금까지 JSP와 서블릿으로 해결했던 form을 이용한 데이터 전달 방식을 jsp 파일을 통해 데이터 처리를 할 수 있다.
 
 **02_researchForm.jsp**
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
	<h2>설문 조사</h2>
	<form action="02_research.jsp" method="post">
		<table>
			<tr>
				<td> 이름 : </td>
				<td>
					<input type="text" name="name" size="20">
				</td>
			</tr>
			<tr>
				<td> 성별 : </td>
				<td>
					<input type="radio" name="gender" value="male" checked="checked"> 남자
					<input type="radio" name="gender" value="female"> 여자
				</td>
			</tr>
			<tr>
				<td> 좋아하는 계절 : </td>
				<td>
					<input type="checkbox" name="season" value="1"> 봄
					<input type="checkbox" name="season" value="2" checked="checked"> 여름
					<input type="checkbox" name="season" value="3"> 가을
					<input type="checkbox" name="season" value="4"> 겨울
				</td>
			</tr>
			<tr>
				<td><input type="submit" value="전송"></td>
				<td><input type="reset" value="취소"></td>
			</tr>
		</table>
	</form>
</body>
</html>
```

**02_research.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
b { font-size: 16pt;}
</style>
</head>
<body>
	<h2>
		<%
		request.setCharacterEncoding("UTF-8");
		
		String name = request.getParameter("name");
		
		String gender = request.getParameter("gender");
		out.println("성별 : ");
		if (gender.equals("male")) {
		out.println("<b>남자</b><br>");			
		} else {
		out.println("<b>여자</b><br>");						
		}
		
		String seasonArr[] = request.getParameterValues("season");
		out.println("당신이 좋아하는 계절은 ");
		for (String season : seasonArr) {
			int n = Integer.parseInt(season);
			switch (n) {
			case 1 : out.println("<b> 봄 </b>");
			break;
			case 2 : out.println("<b> 여름 </b>");
			break;
			case 3 : out.println("<b> 가을 </b>");
			break;
			case 4 : out.println("<b> 겨울 </b>");
			break;
			}
		}
		out.print("입니다.");
		
		%>
		<br>
		<b><a href='javascript:history.go(-1)'>다시</a></b>
	
	</h2>
</body>
</html>
```

**결과 화면**   
![image](https://user-images.githubusercontent.com/84966961/125576160-6c29b4d1-2d99-4d5c-86c2-7e6108c10f0f.png)
![image](https://user-images.githubusercontent.com/84966961/125576174-7219e9a0-151c-406c-93ce-fd70522eb31c.png)



<br><br><hr>

### response 내장 객체

 클라이언트에 대한 응답 처리를 하는 객체인 response 는 실행 결과를 브라우저로 되돌려 줄 때 사용하는 내장 객체이다. JSP에서는 response 객체의 기능 중 리다이렉트 기능을 많이 사용하는데, 리다이렉트는 response 객체의 sendRedirect() 메소드를 사용하여 웹 서버가 브라우저에게 지정한 페이지로 이동하도록 지시한다.   
 
 ```
 				response.sendRedirect("http://www.roadbook.co.kr");
```

 위의 URL로 페이지가 이동하게 된다.    
    
 **로그인 기능** 구현할 때 로그인 성공 실패에 따라 서로 다른 페이지로 이동해야 하기 때문에 리다이렉트 기능을 사용해야 한다.    

<br><br>

 
 웹사이트를 구축하기 위해서 웹 페이지에서 웹 페이지로 이동하도록 하는 것은 필수이다. JSP에서 다른 페이지로 이동하기 위한 방법은 다음과 같다.

**페이지 이동을 위한 기능들**

1. JS : location.href = 'location.jsp'; 
2. JS : history. go, back(-1); 
3. JSP : response sendRedirect 
4. JSP : request forward : request.getRequestDispatcher("loginSuccess.jsp").forward(request, response);


<br><br><hr>


#### 교재 193p : redirect 방식 - 로그인 인증 처리하기

**04_loginForm.jsp**
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
<form action="04_testLogin.jsp" method="post">
	<label for="userid"> 아이디 : </label>
	<input type="text" name="id" id="userid"><br><br>

	<label for="userpwd"> 암 &nbsp; 호 : </label>
	<input type="password" name="pwd" id="userpwd"><br><br>
	
	<input type="submit" value="로그인">
</form>
</body>
</html>
```

**04_testLogin.jsp**
```jsp
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%
	String id="pinksung";
	String pwd="1234";
	String name="성윤정";
	request.setCharacterEncoding("UTF-8");
	if(id.equals(request.getParameter("id")) && pwd.equals(request.getParameter("pwd"))) {
		// redirect 방식
		//response.sendRedirect("04_main.jsp?name="+URLEncoder.encode(name,"UTF-8"));
		// forward 방식
		request.getRequestDispatcher("04_main.jsp?name="+URLEncoder.encode(name,"UTF-8")).forward(request, response);
	} else {
		response.sendRedirect("04_loginForm.jsp");
	}
	%>
```

**04_main.jsp**
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
	<%= request.getParameter("name") %> 님 안녕하세요!
	<br> 저희 홈페이지에 방문해 주셔서 감사합니다.
	<br> 즐거운 시간 되세요...
	<br>
</body>
</html>
```

**실행 결과**
![image](https://user-images.githubusercontent.com/84966961/125582529-a77c48cc-878a-4232-b6f8-3b2e3992589f.png)
![image](https://user-images.githubusercontent.com/84966961/125582551-ac1f3984-2b48-4236-9994-b0cf2b542a13.png)    
**forward 방식을 사용했을 때 주소값**   
![image](https://user-images.githubusercontent.com/84966961/125583004-0cf87246-6666-4731-a938-fd81c0731f11.png)


<br><br>


#### response 리다이렉트와 request 포워드 방식의 차이

 redirect 방식은 웹페이지를 이동할 때 주소창의 주소값을 바꾸면서 이동하고 forward 방식은 주소값을 바꾸지 않는다.


**로그인 화면**   
![image](https://user-images.githubusercontent.com/84966961/125579565-49c12448-ff16-4011-8340-dcad27e942bc.png)   
   
**페이지 호출 방식에 따른 차이점**   

redirect | foward
---|---
![image](https://user-images.githubusercontent.com/84966961/125583306-92e4fe98-1658-43fe-b5a2-1f8821e01961.png) | ![image](https://user-images.githubusercontent.com/84966961/125583162-5f8e0ba2-81cd-41b1-aa2e-967419d42bae.png)
response를 통한 sendRedirect 메소드에 매개 변수로 이동한다. | request를 통한 forward 방식을 이용하면 호출한 페이지에서 매개변수 주소의 내용을 페이지를 구현한다.


**두 방식 모두 출력시**   
   
 response forward만 id가 남아있다.    
![image](https://user-images.githubusercontent.com/84966961/125586945-415bada7-5f5b-4a09-9033-4efde470f77c.png)


<br><br><hr>


