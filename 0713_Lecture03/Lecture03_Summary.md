# Lecture03 웹 서버와 세션
Key Word : 서버, 세션

<hr>
 
## 세션 (교재 242p 세션 개념 설명)
   
 세션 객체를 이용하여 도메인을 통해 실제 서버에 접속하여 정보를 처리할 수 있다.



<br><br>
<hr>
 
### 세션 객체 저장

**세션**
```java
package unit12;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/SetNameServlet")
public class SetNameServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		HttpSession session = request.getSession();
		session.setAttribute("name", "오정원");
		out.println("<h1>이름 저장 성공</h1>");
		
		
	}

}
```

**결과 화면**    
![image](https://user-images.githubusercontent.com/84966961/125394523-c27db900-e3e4-11eb-8cee-ba4a80ed43ae.png)



<br><br>
<hr>
 
### 세션 객체 불러오기



**세션 불러오기**    
```java
@WebServlet("/SetNameServlet")
public class GetNameServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		HttpSession session = request.getSession();
		String name = (String) session.getAttribute("name");
		out.println("<h1>이름 불러오기 성공</h1>");
	}
}
```



<br><br>
<hr>
 
### 세션 객체 불러오기


 로그인 전에는 `로그인 해주세요` 라는 글이 보이지만 로그인 후 에는 웹서버로부터 reponse를 통해 세션으로부터 id 값을 받았기 때문에 표시되는 모습이 바뀌게 된다.             
    
![image](https://user-images.githubusercontent.com/84966961/125405571-d8927600-e3f2-11eb-9c3e-075c63b34fc5.png)      

![image](https://user-images.githubusercontent.com/84966961/125405762-0972ab00-e3f3-11eb-9cc6-815515089d92.png)     




<br><br>
<hr>
 
## 교재 130p : JSP로 시작하는 웹 프로그래밍
  

![image](https://user-images.githubusercontent.com/84966961/125407226-a1bd5f80-e3f4-11eb-9168-67c29062ca11.png)     

![image](https://user-images.githubusercontent.com/84966961/125407353-c1548800-e3f4-11eb-98f5-451d8d055a5b.png)     

![image](https://user-images.githubusercontent.com/84966961/125407390-ca455980-e3f4-11eb-9668-4483d0dfc1a3.png)     





<br><br>
 
### Path Server.xml 확인
 
프로젝트 생성시 context path를 바꿀 수 있다.      
   
![image](https://user-images.githubusercontent.com/84966961/125407720-1a242080-e3f5-11eb-8ebd-0f4899bd692e.png)      
 
   
test.jsp 를 만들어 웹 서버에 등록하기 전까진 server.xml 에는 다음과 같이 프로젝트 webstudy03에 대한 path가 없다.    

![image](https://user-images.githubusercontent.com/84966961/125407984-61aaac80-e3f5-11eb-8596-5a69f6d20def.png)    

하지만 프로젝트가 웹 서버에 올라가 실행되면 다음과 같이 path가 정리가 된다.    

![image](https://user-images.githubusercontent.com/84966961/125408063-75561300-e3f5-11eb-9cd6-90b13250ac09.png)    




<br><br>
 <hr>
 
### 교재 139p : 변수값을 1 증가하여 출력하는 JSP 테스트

실제 html 로 변환될 때는 해당 코드가 존재하지 않는다. 원코드를 보지 않는 이상 구조가 어떻게 돌아가는지 알 방도가 없다.      

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
%>
</body>
</html>
```

**결과 화면**   
![image](https://user-images.githubusercontent.com/84966961/125409957-5fe1e880-e3f7-11eb-9707-1e578fcefd56.png)






<br><br>
 <hr>
 

## 어제 퀴즈 master


**JoinServlet.java**
```java
package join;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/JoinServlet")
public class JoinServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		String name=request.getParameter("name");
		String jumin=request.getParameter("jumin_1")+ "-" + request.getParameter("jumin_2");
		String id=request.getParameter("id");
		String pwd=request.getParameter("pwd");
		String email=request.getParameter("email");
		
		if(request.getParameter("email_dns").trim() == ""){
			email += "@" + request.getParameter("emailaddr");
		}else {
			email += "@" + request.getParameter("email_dns");
		}
		
		String zip = request.getParameter("zip");
		String addr = request.getParameter("addr1") + request.getParameter("addr2");
		String phone = request.getParameter("phone");
		//String job = request.getParameter("job");
		String[] jobs = request.getParameterValues("job");
		String sms = request.getParameter("chk_mail");
		String[] intersts = request.getParameterValues("interest");
		
		out.print("<html><head><title></title></head>");
		out.print("<body>");
		
		out.println("이름 : <b>");
		out.print(name);
		
		out.println("<br>주민번호 : <b>");
		out.print(jumin);
		
		out.println("<br>아이디 : <b>");
		out.print(id);
		
		out.println("<br>비밀번호 : <b>");
		out.print(pwd);
		
		out.println("</b><br>이 메 일 : <b>");
		out.print(email);
		
		out.println("<br>우편번호 : <b>");
		out.print(zip);
		
		out.println("<br>주소 : <b>");
		out.print(addr);
		
		out.println("<br>핸드폰 번호 : <b>");
		out.print(phone);
		
		out.println("<br>직업 : <b>");
		//out.print(job);
		if(jobs == null) {
			out.print("선택항목없음");
		}else {
			for(String job : jobs) {
				out.print(job + " ");
			}
		}
		
		out.println("<br>메일수신 / SMS: <b>");
		out.print(sms);
		
		out.println("<br>관심분야 : <b>");
		if(intersts == null) {
			out.print("선택항목없음");
		}else {
			for(String interest : intersts) {
				out.print(interest + " ");
			}
		}
		
		out.print("<br><a href = 'javascript:history.go(-1)'>돌아가기</a>");
		out.print("</body>");
		out.print("</html>");
		out.close();
		
		
		
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		doGet(request, response);
	}

}
```

**join.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style type="text/css">
		label {
			width:160px;
			display:inline-block;
			float:left
		}
		
		#button{
			text-align : center;
		}
	</style>
	
	<script type="text/javascript" src="joinChk.js"></script>
</head>
<body>
	<form name="frm" id="reg_frm" action="JoinServlet">
		<label for="name">이름</label><span style="color:red;">*</span>
		<input type="text" id="name" name="name" value="성윤정"><br>
		
		<label>주민번호</label><span style="color:red;">*</span>
		<input type="text" name="jumin_1" value="890719"> -
		<input type="text" name="jumin_2" value="2012123"><br>
		
		<label for="id">아이디</label><span style="color:red;">*</span>
		<input type="text" id="id" name="id" value="pinksung"><br>
		
		<label for="pwd">비밀번호</label><span style="color:red;">*</span>
		<input type="password" id="pwd" name="pwd" value="1234"><br>
		
		<label for="pwd_re">비밀번호확인</label><span style="color:red;">*</span>
		<input type="password" id="pwd_re" name="pwd_re" value="1234"><br>
		
		<label for="email">이메일</label>&nbsp;
		<input type="text" name="email" value="pinksung"> @
		<input type="text" name="email_dns" value="">
		<select name="emailaddr">
			<option value="">직접입력</option>
			<option value="daum.net">daum.net</option>
			<option value="gmail.com">gmail.com</option>
			<option value="naver.com" selected>naver.com</option>		
		</select><br>
		
		<label for="zip">우편번호</label>&nbsp;
		<input type="text" id="zip" name="zip" value="321-231"><br>
		
		<label for="addr1">주소</label>&nbsp;
		<input type="text" id="addr1" name="addr1" value="서울시 영등포구 여의도동">
		<input type="text" id="addr2" name="addr2" value="자이아파트 101동101호"><br>
		
		<label for="phone">핸드폰번호</label>&nbsp;
		<input type="tel" id="phone" name="phone" value="010-123-1234"><br>
		
		<label for="job">직업</label>&nbsp;
		<select id="job" name="job" size="3" multiple>
			<option value="학생">학생</option>
			<option value="언론">언론</option>
			<option value="공무원" selected>공무원</option>
			<option value="서비스업">서비스업</option>
		</select><br>
		
		<label for="chk_mail">메일/SMS 정보수신</label>&nbsp;
		<input type="radio" id="chk_mail" name="chk_mail" value="yes" checked>수신
		<input type="radio" id="chk_mail" name="chk_mail" value="no">수신거부<br>
		
		
		<label for="interest">관심분야</label>&nbsp;
		<input type="checkbox" id="interest" name="interest" value="생두">생두
		<input type="checkbox" id="interest" name="interest" value="원두" checked>원두
		<input type="checkbox" id="interest" name="interest" value="로스팅">로스팅
		<input type="checkbox" id="interest" name="interest" value="핸드드립" checked>핸드드립
		<input type="checkbox" id="interest" name="interest" value="에스프레스" checked>에스프레스
		<input type="checkbox" id="interest" name="interest" value="창업">창업
		
		<br><br>
		
		<div id="button">
			<input type="submit" value="회원가입" onclick="return check()">
			<input type="reset" value="취소">
		</div>
		
		
	</form>
</body>
</html>
```



























