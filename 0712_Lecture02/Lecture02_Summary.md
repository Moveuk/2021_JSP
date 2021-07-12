# Lecture02 JSP와 서블릿
Key Word : JSP, 자바 서블릿(Java Servlet), form 태그, 한글 깨짐 방지(get, post), server, 회원가입 속성, checkbox 태그, select 태그, multiple

<hr>
 
### 유효성 검사
   
1. 지난 수업 ParamServlet.java 에서 나이 데이터값을 String으로 받았었다. 이를 int형으로 받아보려고 한다.  
   
![image](https://user-images.githubusercontent.com/84966961/125215306-1a89c200-e2f6-11eb-886e-e0e6150e24ce.png)   
   
오류 500 : 코드의 문법적 오류가 생겼을 경우   
   
![image](https://user-images.githubusercontent.com/84966961/125215085-46f10e80-e2f5-11eb-8aba-bc3f96971175.png)   
   
int를 파싱해서 받아 문법오류를 없앰   
   
![image](https://user-images.githubusercontent.com/84966961/125221360-1912c680-e303-11eb-94ee-4de7d81f6b9a.png)      


<br>


2. javascript 파일을 만들어 기능을 추가한다. jsp의 폼 태그에 name 속성을 추가해준다. 이 후 javascript 파일에서 name 속성을 사용할 기능을 작성한다.   

  
**param05.jsp**
```jsp
	<form method="get" action="ParamServlet" name="frm">
```

**param.js**
```jsp
function check() {
	// input 값이 null 인지 체크
	if (document.frm.id.value == "") {
		alert("아이디를 입력하세요");
		document.frm.id.focus()
		return false;
	} else if (document.frm.age.value == "") {
		alert("나이를 입력하세요");
		document.frm.id.focus();
		return false;
	} else if (isNaN(documetn.frm.age.value)) {
	// 나이에 숫자가 들어있는지 확인
	// is Not A Number : 숫자인지 아닌지
		alert("숫자로 입력하세요.");
		document.frm.id.focus();
		return false;
	} else {
		true;
	}
}
```

3. 이후 jsp 파일에서 submit 시 onclick 기능으로 함수를 호출해준다. `onclick="return check();`

**param05.jsp**
```jsp
<body>
	<form method="get" action="ParamServlet" name="frm">
		아이디 : <input type="text" name="id"><br>
		나 이 : <input type="text" name="age"><br>
		<input type="submit" name="전송" onclick="return check();"><br>
	</form>
</body>
```

**실행 결과**

![image](https://user-images.githubusercontent.com/84966961/125219960-d354fe80-e300-11eb-9248-3e7953e84b82.png)   
   
![image](https://user-images.githubusercontent.com/84966961/125219971-d94adf80-e300-11eb-9315-75d342e1450a.png)   
   
<br><br>

**오류 방지**   
   
 jsp, js java servlet 파일의 설치 위치를 잘 확인하자. 잘못된 프로젝트나 폴더에 생성하여 상대 경로 차이로 인한 파일 불러오기가 안될 수 있다.
 
 
<br><br>
<hr>
 
## get 방식과 post 방식에 대한 utf 코드 처리 방식(한글 깨짐 방지)
   
### get 방식 utf 코드 처리 방식
   
   
 사용 환경에 따라 get이나 post 방식에 의한 한글이 깨지는 경우가 생긴다. 그런 경우를 위해서 `server > server.xml` 에 Connector 태그에 `URIEncoding="UTF-8"` 속성을 넣어준다.
 
 
 
**server.xml**
```jsp
    <Connector URIEncoding="UTF-8" connectionTimeout="20000" port="8181" protocol="HTTP/1.1" redirectPort="8443"/>
```

![image](https://user-images.githubusercontent.com/84966961/125221027-8d009f00-e302-11eb-86f2-1a829d753858.png)


**info06.jsp**
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
	<h3> get 방식에서 한글 깨짐</h3> <br>
	<form method="get" action="InfoServlet">
		이름 : <input type="text" name = "name" > <br>
		주소 : <input type="text" name = "addr" > <br>
		<input type="submit" value= "전송">
	</form>
</body>
</html>
```

**InfoServlet.java**
```java
@WebServlet("/InfoServlet")
public class InfoServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		String name = request.getParameter("name");
		String addr = request.getParameter("addr");

		// 화면 출력.
		out.print("<html><head><titie></title></head>");
		out.print("<body>");
		out.print("당신이 입력한 정보입니다.<br>");
		out.print("<br>이   름 : " + name);
		out.print("<br>주   소 : " + addr);
		out.print("<br><a href= 'javascript:history.go(-1)'>돌아가기</a>");		
		out.print("</body></html>");
		
		out.close();
	}

}
```
   
**결과 화면**   
![image](https://user-images.githubusercontent.com/84966961/125220767-2d09f880-e302-11eb-8c83-02b3d04555f8.png)   
   
기존에는 깨지는 한글이 잘 나오는 것을 볼 수 있다.   


 
<br><br>
<hr>
 
### post 방식 utf 코드 처리 방식
      
 get 방식의 Servlet 코드를 그대로 복사하여 붙이고, jsp 파일의 폼태그를 `method="post"` 로 바꿔주어 실행하면 다음과 같이 한글이 깨지게 된다.
 
![image](https://user-images.githubusercontent.com/84966961/125222489-0d280400-e305-11eb-97ef-9dc62cbcc128.png)
 
 
 post 방식은 반드시 doPost 코드 내부에 `request.setCharacterEncoding("UTF-8");` 를 넣어주어야 한글 깨짐없이 잘 작동한다.
 

**InfoServlet.java**
```java
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		String name = request.getParameter("name");
		String addr = request.getParameter("addr");

		// 화면 출력.
		out.print("<html><head><titie></title></head>");
		out.print("<body>");
		out.print("당신이 입력한 정보입니다.<br>");
		out.print("<br>이   름 : " + name);
		out.print("<br>주   소 : " + addr);
		out.print("<br><a href= 'javascript:history.go(-1)'>돌아가기</a>");		
		out.print("</body></html>");
		
		out.close();
		
	}
```
   
<br>

코드를 설정해주면 다음과 같이 잘 작동한다.

<br>

**결과 화면**   
    
![image](https://user-images.githubusercontent.com/84966961/125222768-9d664900-e305-11eb-96e0-7b40894c17af.png)   

 <br><br>
 
 만약 기능이 똑같다면 다음과 같이 post 내부에서 get을 불러서 사용할 수도 있다. 위의 코드와 같은 코드이다.

 ```java
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		
		doGet(request, response);
		// 똑같다면 post 내부에서 get을 불러서 사용할 수 있다.
	}
```
 
<br><br>
<hr>
 
## Radio 타입 데이터 입력 처리

 HTML의 태그중 radio 타입의 체크 박스 형식 input을 사용하여 받은 데이터를 처리하는 방식을 알아보자.   
   
**radio08.jsp**
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
	<form method="get" action="RadioServlet">
		<label for = "gender">성별 : </label> <br>
		<!-- radio는 name 속성이 같아야 한다. -->
		<input type="radio" id="gender" name = "gender" value="남자" checked > 남자 <br>
		<input type="radio" id="gender" name = "gender" value="여자"> 여자 <br>
		<br><br>
		<label for = "chk_mail">메일정보 수신 여부 : </label> <br>
		<!-- label 의 for와 input의 id가 같아야 연동이 된다. -->		
		<input type="radio" id="chk_mail" name = "chk_mail" value="yes" checked > 수신 <br>
		<input type="radio" id="chk_mail" name = "chk_mail" value="no" > 거부 <br>
		<br><br>
		<label for="content">간단한 가입 인사 부탁드립니다.</label> <br>
		<textarea id="content" name="content" rows="3" cols="35"></textarea>
		<br><br>
		<input type="submit" value="전송" >
	</form>
</body>
</html>
```

**RadioServlet.java**
```jsp
@WebServlet("/RadioServlet")
public class RadioServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		String gender = request.getParameter("gender");
		String chk_mail = request.getParameter("chk_mail");
		String content = request.getParameter("content");

		// 화면 출력.
		out.print("<html><head><titie></title></head>");
		out.print("<body>");
		out.print("당신이 입력한 정보입니다.<br><hr>");
		out.print("<br>성   별 : <b>" + gender);
		out.print("</b><br>메일정보 수신 여부 : <b>" + chk_mail);
		out.print("</b><br>가입 인사 : <br><pre><b>" + content);
		out.print("</b></pre><br><a href= 'javascript:history.go(-1)'>돌아가기</a>");		
		out.print("</body></html>");
		
		out.close();
	}

}
```
   
**결과 화면**   
![image](https://user-images.githubusercontent.com/84966961/125227069-25038600-e30d-11eb-9c6d-4a81e980e2b4.png)   
   
![image](https://user-images.githubusercontent.com/84966961/125227173-58deab80-e30d-11eb-814d-21b7dc6074e1.png)   


 
<br><br>
<hr>
 
## Checkbox 타입 데이터 입력 처리

**checkbox09.jsp**
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
	<form method="get" action="CheckboxServlet">
	<!-- item에 0~아이템 갯수 까지 다양하게 넘어감으로 배열로 넘어감. -->
		<input type="checkbox" name="item" value="신발"> 신발 <br>
		<input type="checkbox" name="item" value="가방"> 가방 <br>
		<input type="checkbox" name="item" value="벨트"> 벨트  <br><br>
		<input type="checkbox" name="item" value="모자"> 모자 <br>
		<input type="checkbox" name="item" value="시계"> 시계 <br>
		<input type="checkbox" name="item" value="쥬얼리"> 쥬얼리 <br>

		<br><br>
		<input type="submit" value="전송">
	</form>
</body>
</html>
```

**CheckboxServlet.java**
```java
@WebServlet("/CheckboxServlet")
public class CheckboxServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		// item 이 0~ 아이템 갯수 만큼 배열 값으로 넘어온다.
		String items[] = request.getParameterValues("item");

		// 화면 출력.
		out.print("<html><head><titie></title></head>");
		out.print("<body>");
		out.print("당신이 입력한 정보입니다.<br><hr><br>");
		if (items == null) {
			out.print("선택항목이 없습니다.");
		} else {
			int cnt = 0;
			for (String item : items) {
//				cnt = Arrays.binarySearch(items, item) + 1;
				cnt = Arrays.asList(items).indexOf(item) + 1;
				out.print("<b>" + cnt + ". " + item + "</b>  ");
			}
		}

		out.print("<br><br>");
		out.print("</b></pre><br><a href= 'javascript:history.go(-1)'>돌아가기</a>");
		out.print("</body></html>");

		out.close();
	}
}
```



 
<br><br>
<hr>
 
### Checkbox 타입 데이터 입력 처리 퀴즈





**CheckboxExample.jsp**
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
	<form method="get" action="CheckboxExServlet">
		<h1> 당신이 좋아하는 강아지를 선택하세요. </h1> <br>
		<input type="checkbox" name="item" value="pu"> 푸들 
		<input type="checkbox" name="item" value="jin"> 진돗개 
		<input type="checkbox" name="item" value="pung"> 풍산개 
		<input type="checkbox" name="item" value="sap"> 삽살개 <br>
		<br><br>
		<input type="submit" value="전송">
	</form>
</body>
</html>
```

**CheckboxServlet.java**
```java
@WebServlet("/CheckboxExServlet")
public class CheckboxExServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		// item 이 0~ 아이템 갯수 만큼 배열 값으로 넘어온다.
		String items[] = request.getParameterValues("item");

		// 화면 출력.
		out.print("<html><head><titie></title><style>body {background-color:black; color:white;}"
				+ " img {border: yellow 2px solid;} </style></head>");
		out.print("<body>");
		out.print("당신이 입력한 정보입니다.<br><hr><br>");
		if (items == null) {
			out.print("선택항목이 없습니다.");
		} else {
			for (String item : items) {
				out.print("<img alt='"+item.toString()+"' src='img/"+item.toString()+".jpg'>");
			}
		}

		out.print("<br><br>");
		out.print("</b></pre><br><a href= 'javascript:history.go(-1)'>돌아가기</a>");
		out.print("</body></html>");

		out.close();
	}

}
```


**결과 화면**   
    
![image](https://user-images.githubusercontent.com/84966961/125238662-8124d500-e322-11eb-825f-00c256019611.png)
   
   

 
<br><br>
<hr>
 
## Select 태그와 multiple 속성
    
**select10.jsp**
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
	<form method="get" action="SelectServlet">
		<label for="job">직업</label> <br> 
		<select id="job" name="job">
			<option value="">선택하세요</option>
			<option value="학생">학생</option>
			<option value="컴퓨터/인터넷">컴퓨터/인터넷</option>
			<option value="언론">언론</option>
			<option value="공무원">공무원</option>
			<option value="군인">군인</option>
			<option value="서비스업">서비스업</option>
			<option value="교육">교육</option>
			<option value="기타">기타</option>
		</select><br> 
		
		<label for="interest">관심분야</label> <br> 
		<select id="interest" name="interest" size="5" multiple="multiple">
			<option value="">선택하세요</option>
			<option value="에스프레소">에스프레소</option>
			<option value="로스팅">로스팅</option>
			<option value="생두">생두</option>
			<option value="원두">원두</option>
			<option value="핸드드립">핸드드립</option>
		</select><br> 
		
		<input type="submit" value="전송">
	</form>
</body>
</html>
```

**SelectServlet.java**
```java
@WebServlet("/SelectServlet")
public class SelectServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		// item 이 0~ 아이템 갯수 만큼 배열 값으로 넘어온다.
		String job = request.getParameter("job");
		String interests[] = request.getParameterValues("interest");
		
		out.print("<html><head><title></title></head>");
		out.print("<body>");
		out.print("<h1>당신의 직업은 : </h1>"+job);
		out.print("<br>");
		out.print("<br>");
		
		if (interests == null) {		
			out.print("관심 분야 없음");
		} else {
			out.print("<h1>당신의 관심 분야는 : </h1>");
			
			for (String interest : interests) {
				out.print(interest+ "  ");
			}			
		}
		out.print("<br>");
		out.print("<br><a href= 'javascript:history.go(-1)'>돌아가기</a>");
		out.print("</body></html>");

		out.close();
	}
		
}
```


**결과 화면**

![image](https://user-images.githubusercontent.com/84966961/125245554-a9fd9800-e32b-11eb-995c-8259098d24d2.png)



 
<br><br>
<hr>
 
## 퀴즈 및 정리
    
 만들어 보기
    
    
![image](https://user-images.githubusercontent.com/84966961/125257473-68271e80-e338-11eb-9e86-1c4a9438875a.png)


**0712quiz.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>Insert title here</title>
        <style>
            .col1 {
                width: 250px;
            }

            .col3 {
                width: 700px;
            }
            
            .required {
                width: auto;
                color: red;
                font-weight: bold;
            }
            .btns {
                text-align: center;
                margin: 0 auto;
            }

            .btn {
                display: inline-block;
            }
        </style>

    </head>

    <body>
        <div class="contents">
            <form action="QuizServlet" name="frm">
                <table>
                    <thead>
                        <colgroup>
                            <col class="col1">
                            <col class="col2">
                            <col class="col3">
                        </colgroup>
                    </thead>
                    <tbody>
                        <tr>
                            <td>이름</td>
                            <td class="required"> * </td>
                            <td><input type="text" id="name" name="name" width="50" value="이동욱" autofocus required></td>
                        </tr>
                        <tr>
                            <td>주민등록번호</td>
                            <td class="required"> * </td>
                            <td><input type="text" id="psno1" name="psno1" width="50" value="920525" required> - <input type="text" id="psno2" width="50" name="psno2" value="1548644" required></td>
                        </tr>
                        <tr>
                            <td>아이디</td>
                            <td class="required"> * </td>
                            <td><input type="text" id="id" name="id" width="50" value="moveuk" required></td>
                        </tr>
                        <tr>
                            <td>비밀번호</td>
                            <td class="required"> * </td>
                            <td><input type="password" id="password" name="password" width="50" value="1234" required></td>
                        </tr>
                        <tr>
                            <td>비밀번호 확인</td>
                            <td class="required"> * </td>
                            <td><input type="password" id="pass_chk" name="pass_chk" width="50" value="1234" required></td>
                        </tr>
                        <tr>
                            <td>이메일</td>
                            <td class="required"></td>
                            <td><input type="text" id="email_id" name="email_id" width="50" value="moveuk"> @ 
                            <input type="text" id="email_domain" name="email_domain" size="20" disabled> 
                            <select name="site"
                                    id="email_select" name="email_select" onchange="fnSelectChange(this)">
                                    <option value="" selected disabled>선택하세요</option>
                                    <option value="naver.com">naver.com</option>
                                    <option value="gmail.com">gmail.com</option>
                                    <option value="hanmail.net">hanmail.net</option>
                                    <option value="hotmail.com">hotmail.com</option>
                                    <option value="korea.com">korea.com</option>
                                    <option value="nate.com">nate.com</option>
                                    <option value="yahoo.com">yahoo.com</option>
                                    <option value="0">직접 입력</option>
                                </select></td>
                        </tr>
                        <tr>
                            <td>우편번호</td>
                            <td class="required"></td>
                            <td><input type="text" id="post" name="post" width="50" value="150-797" placeholder="000-000"></td>
                        </tr>
                        <tr>
                            <td>주소</td>
                            <td class="required"></td>
                            <td><input type="text" id="addr1" name="addr1" width="50" value="서울시 영등포구"> <input type="text" id="addr2" name="addr2" width="50" value="영등포본동"></td>
                        </tr>
                        <tr>
                            <td>핸드폰번호</td>
                            <td class="required"></td>
                            <td><input type="tel" id="mobile" name="mobile" width="50" value="010-1000-1000" placeholder="010-0000-0000"></td>
                        </tr>
                        <tr>
                            <td><label for="job">직업</label></td>
                            <td class="required"></td>
                            <td><select id="job" name="job">
                                    <option value="" selected disabled>선택하세요</option>
                                    <option value="학생">학생</option>
                                    <option value="컴퓨터/인터넷">컴퓨터/인터넷</option>
                                    <option value="언론">언론</option>
                                    <option value="공무원">공무원</option>
                                    <option value="군인">군인</option>
                                    <option value="서비스업">서비스업</option>
                                    <option value="교육">교육</option>
                                    <option value="기타">기타</option>
                                </select>
                            </td>
                        </tr>
                        <tr class="left">
                            <td><label for="chk_mail">메일/SMS 정보 수신</label></td>
                            <td class="required"></td>
                            <td><input type="radio" name="chk_mail" id="chk_mail" value="yes" checked>수신 <input type="radio" name="chk_mail" id="chk_mail" value="no">수신거부</td>
                        </tr>
                        <tr class="left">
                            <td>관심분야</td>
                            <td class="required"></td>
                            <td>
                                <input type="checkbox" name="interest" value="생두" checked> 생두 
                                <input type="checkbox" name="interest" value="원두"> 원두 
                                <input type="checkbox" name="interest" value="로스팅" checked> 로스팅  
                                <input type="checkbox" name="interest" value="핸드드립" checked> 핸드드립 
                                <input type="checkbox" name="interest" value="에스프레소"> 에스프레소 
                                <input type="checkbox" name="interest" value="창업"> 창업 
                            </td>
                        </tr>
                    </tbody>
                </table>
                <div class="btns">
                    <button type="submit" class="btn" onclick="return check()">회원가입</button>
                    <button type="reset" class="btn">취소</button>
                </div>
            </form>
        </div>
    </body>
	<script type="text/javascript" src="quiz.js" charset="utf-8"></script>
    </html>
```

**QuizServlet.java**
```java
@WebServlet("/QuizServlet")
public class QuizServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		String name = request.getParameter("name");
		String psno1 = request.getParameter("psno1");
		String psno2 = request.getParameter("psno2");
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String pass_chk = request.getParameter("pass_chk");
		String email_id = request.getParameter("email_id");
		String email_domain = request.getParameter("email_domain");
		String email_select = request.getParameter("email_select");
		String post = request.getParameter("post");
		String addr1 = request.getParameter("addr1");
		String addr2 = request.getParameter("addr2");
		String mobile = request.getParameter("mobile");
		String job = request.getParameter("job");
		String interests[] = request.getParameterValues("interest");
		
		// 출력
		out.print("<html><head><title></title></head>");
		out.print("<body>");
		out.print("이름 : "+name + "<br>");
		out.print("주민등록번호 : "+ psno1 +" - "+ psno2 +"<br>");
		out.print("아이디 : "+id+"<br>");
		out.print("비밀번호 : "+password+"<br>");
		out.print("이메일 : "+email_id+"@"+email_domain+"<br>");
		out.print("우편번호 : "+post+"<br>");
		out.print("주소 : "+addr1+"  "+ addr2 +"<br>");
		out.print("핸드폰번호 : "+mobile+"<br>");
		out.print("직업 : "+job+"<br>");
		if (interests == null) {		
			out.print("관심 분야 없음");
		} else {
			out.print("관심분야 : ");;
			for (String interest : interests) {
				out.print(interest+ " ");
			}			
		}
		out.print("<br>");
		out.print("<br><a href= 'javascript:history.go(-1)'>돌아가기</a>");
		out.print("</body></html>");

		out.close();
	}

}
```

   
**quiz.js**
```javascript
function check() {
	if (document.frm.name.value == "") {
		alert("이름을 입력하세요");
		document.frm.name.focus()
		return false;
	}
	if (document.frm.psno1.value == "" || document.frm.psno2.value == "") {
		if (document.frm.psno1.value == "") {
			alert("주민등록번호를 입력하세요");
			document.frm.psno1.focus();
		} else {
			alert("주민등록번호를 입력하세요");
			document.frm.psno2.focus();
		}
		return false;
	}
	if (isNaN(document.frm.psno1.value) || isNaN(document.frm.psno2.value)) {
		if (isNaN(document.frm.psno1.value)) {
			alert("숫자로 입력하세요.");
			document.frm.psno1.focus();
		} else {
			alert("숫자로 입력하세요.");
			document.frm.psno2.focus();
		}
		return false;
	}
	if (document.frm.id.value == "") {
		alert("아이디를 입력하세요");
		document.frm.id.focus()
		return false;
	}
	if (document.frm.password.value == "" || document.frm.pass_chk.value == "") {
		if (document.frm.password.value == "") {
			alert("주민등록번호를 입력하세요");
			document.frm.password.focus();
		} else {
			alert("주민등록번호를 입력하세요");
			document.frm.pass_chk.focus();
		}
		return false;
	}
	if (isNaN(document.frm.password.value) || isNaN(document.frm.pass_chk.value)) {
		if (isNaN(document.frm.password.value)) {
			alert("숫자로 입력하세요.");
			document.frm.password.focus();
		} else {
			alert("숫자로 입력하세요.");
			document.frm.pass_chk.focus();
		}
		return false;
	}
}

function fnSelectChange(e) {
  	var value = e.value;
	var email_domain = document.getElementById('email_domain');
	var target = document.getElementById('email_select');
	
	if (value != '0') {
		email_domain.value = value;
	} else {
		email_domain.disabled = false;
	}
	
}
```

**결과 화면**    
![image](https://user-images.githubusercontent.com/84966961/125304936-f2877680-e368-11eb-92e7-3a7a1c2b719f.png)






 
<br><br>
<hr>
 



