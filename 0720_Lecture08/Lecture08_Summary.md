# Lecture08 Test 07 & 자바 빈 mission

Key Word : 세션(session), 로그인, 자바 빈, 액션 태그

<hr>

## Test : 세션과 쿠키 구현 

![image](https://user-images.githubusercontent.com/84966961/126283231-55db6458-9ce5-4420-8b8d-0d082caa9ba1.png)

주요 기능
  - 세션에 이름 값이 없으면 다른 페이지가 보이도록 설정
```jsp
<%
String cookie = request.getHeader("Cookie");
String username = "";

if(cookie!=null){
	Cookie cookies[]=request.getCookies();
	
	for(int i=0;i<cookies.length;i++){
		if(cookies[i].getName().equals("username")){
			username=URLDecoder.decode(cookies[i].getValue(),"UTF-8");
		}
	}
	out.print(username);
%>
	님 안녕하세요!<br>
	저희 홈페이지에 방문해 주셔서 감사합니다.<br>
	즐거운 시간되세요...<br>
	<form method="post" action="logout.jsp">
		<input type="submit" value="로그아웃">
	</form>
<%} else { %>
	<h2>로그인에 실패했습니다.</h2>
	<p><a href="loginForm.jsp">돌아가기</a>
<%} %>
```

<br>

  - 쿠키에서 값 불러오기
```jsp
<%
	String idcheck = "";
	String userid = "";
	String cookie = request.getHeader("Cookie");
	
	if(cookie!=null){
		Cookie cookies[]=request.getCookies();
		
		for(int i=0;i<cookies.length;i++){
			if(cookies[i].getName().equals("idcheck")){
				idcheck=cookies[i].getValue();
			}
			
			if(cookies[i].getName().equals("userid")){
				userid=cookies[i].getValue();
			}
		}
	}
%>
```

<br>
    
  - null이면 checked가 안보이도록 삼항 연산자 활용
```jsp
	<input type="text" name="id" id="userid" value="<%=idcheck!=""? userid : ""%>"><br>
	<input type="checkbox" name="idcheck"  <%=idcheck!=""?"checked" : ""%>>아이디 저장
```

<br>
    
  - 아이디 & 비밀번호 체크 필요 정보 쿠키 발송
```jsp
<%
	String id="pinksung";
	String pwd="1234";
	String name="성윤정";
	
	String idcheck = request.getParameter("idcheck");

	if(id.equals(request.getParameter("id"))&&
		pwd.equals(request.getParameter("pwd"))){
		
		Cookie n = new Cookie("username",URLEncoder.encode(name,"UTF-8"));
		n.setMaxAge(365*24*60*60);
		response.addCookie(n);
		
		Cookie c = new Cookie("userid",URLEncoder.encode(id,"UTF-8"));
		c.setMaxAge(365*24*60*60);
		response.addCookie(c);
		
		Cookie s = new Cookie("idcheck",idcheck);
		s.setMaxAge(365*24*60*60);
		response.addCookie(s);
%>
```

  - 로그아웃시 쿠키 없애기
-> 나는 쿠키로 하지 않고 세션으로 했기 때문에 쿠키로 name을 죽일 필요가 없었음.
```jsp
<body>
<%
	Cookie cookie = new Cookie("username","");
	cookie.setMaxAge(0);
	response.addCookie(cookie);
%>
<script>
	alert("로그 아웃 되었습니다.");
	location.href="loginForm.jsp";
</script>
```

**내 코드**
이름도 세션으로 넣었음.
```jsp
<script>
<% 
session.invalidate();
%>
alert("로그아웃되었습니다.");
location.href="loginForm.jsp";
</script>
```

<br><br>
<hr>

## 교재 304p ~ 306p : mission 

 3가지 문제 모두 비슷하므로 마지막 문제만 넣어보았다.

**MovieBean.java**
```java
package javabeans;

public class MovieBean {
	String title = "";
	int price = 0;
	String director = "";
	String actor = "";
	String synopsis = "";
	String genre = "";
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getDirector() {
		return director;
	}
	public void setDirector(String director) {
		this.director = director;
	}
	public String getActor() {
		return actor;
	}
	public void setActor(String actor) {
		this.actor = actor;
	}
	public String getSynopsis() {
		return synopsis;
	}
	public void setSynopsis(String synopsis) {
		this.synopsis = synopsis;
	}
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
}

```

**movieWriteForm.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="content">
		<h3>게시판 글쓰기</h3>
		<form action="movieWrite.jsp" method="post">
			<table border="1">
				<tr>
					<td>작성자</td>
					<td>
						<input type="text" name="title" value="설국열차" size="20" />
					</td>
				</tr>
				<tr>
					<td>가격</td>
					<td>
						<input type="text" name="price" value="7000" size="20" />
						원
					</td>
				</tr>
				<tr>
					<td>감독</td>
					<td>
						<input type="text" name="director" value="봉준호" size="20" />
					</td>
				</tr>
				<tr>
					<td>배우</td>
					<td>
						<input type="text" name="actor" value="송강호" size="20" />
					</td>
				</tr>
				<tr>
					<td>시놉시스</td>
					<td>
						<textarea name="synopsis" rows="30" cols="100">기상 이변으로 모든 것이 꽁꽁 얼어 붙은 지구. 살아남은 사람들을 태운 기차 한 대가 끝없이 궤도를 달리고 있다. 춥고 배고픈 사람들이 바글대는 빈민굴 같은 맨 뒤쪽의 꼬리칸, 그리고 선택된 사람들이 술과 마약까지 즐기며 호화로운 객실을 뒹굴고 있는 앞쪽칸, 열차 안의 세상은 결코 평등하지 않다.</textarea>
					</td>
				</tr>
				<tr>
					<td>장르</td>
					<td>
						<select name="genre" >
							<option value="로맨스">로맨스</option>
							<option value="스릴러">스릴러</option>
							<option value="미스터리">미스터리</option>
							<option value="액션">액션</option>
							<option value="코메디">코메디</option>
							<option value="애니메이션">애니메이션</option>
						</select>
					</td>
				</tr>
			</table>
			<div>
				<input type="submit" value="등록">
				<input type="reset" value="다시 작성" />
			</div>
		</form>
	</div>

</body>
</html>
```

**movieWrite.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="movie" class="javabeans.MovieBean"></jsp:useBean>
<jsp:setProperty property="*" name="movie" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>입력 완료된 정보</h2>
			<table>
				<tr>
					<td>작성자</td>
					<td>
						<jsp:getProperty property="title" name="movie"/>
					</td>
				</tr>
				<tr>
					<td>가격</td>
					<td>
						<jsp:getProperty property="price" name="movie"/>${"원"}
					</td>
				</tr>
				<tr>
					<td>감독</td>
					<td>
						<jsp:getProperty property="director" name="movie"/>
					</td>
				</tr>
				<tr>
					<td>배우</td>
					<td>
						<jsp:getProperty property="actor" name="movie"/>
					</td>
				</tr>
				<tr>
					<td>시놉시스</td>
					<td>
						<textarea rows="30" cols="100"><jsp:getProperty property="synopsis" name="movie"/></textarea>
					</td>
				</tr>
				<tr>
					<td>장르</td>
					<td>
						<jsp:getProperty property="genre" name="movie"/>
					</td>
				</tr>
			</table>
</body>
</html>
```



<br><br>
<hr>


