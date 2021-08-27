# Lecture31 Nonage shop continue..

Key Word : 로그인 - 화면 구현, 로그인 기능 구현, 로그아웃

<hr>

## 로그인    

<br>

### 로그인 화면  

 로그인 화면 작성

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>	 
<%@ include file="sub_img.html"%> 
<%@ include file="sub_menu.html" %>

<article>
	<h1>Login</h1>
	<form method="post" action="NonageServlet?command=login">
		<fieldset>
			<legend></legend>
			<label>User ID</label>
			<input type="text" name="id" value="${id }"><br>
			<label>Password</label>
			<input type="text" name="pwd"><br>
		</fieldset>
		<div class="class"></div>
		<div id="button">
			<input type="submit" value="로그인" class="submit">
			<input type="button" value="회원가입" class="cancel"
			 onclick="location='NonageServlet?command=join_form'">
			<input type="button" value="아이디 비밀번호 찾기" class="submit"
			 onclick="location='NonageServlet?command=find_id_form'">
		</div>
	</form>
</article>

<%@ include file="../footer.jsp" %>  
```


<br><br><hr>

### 로그인 기능 구현  

 예제에는 forward 방식으로 했으나 회원가입 특성상 2번 일어나면 안되고 이전의 데이터를 남길 필요가 없으므로 Redirect 방식으로 바꿔주어보았다.

```java
public class LoginAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "member/login_fail.jsp";
		
		HttpSession session = request.getSession();
		
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		
		MemberDAO memberdao = MemberDAO.getInstance();
		MemberVO memberVO = memberdao.getMember(id);
		
		if(memberVO != null) {
			if(memberVO.getPwd().equals(pwd)) {
				session.removeAttribute("id");
				session.setAttribute("loginUser", memberVO);
				url = "NonageServlet?command=index";
			}
		}
		response.sendRedirect(url);
	}

}
```



<br><br><hr>

### 상대주소 -> 절대주소 경로 변경  

 header footer의 css img js 파일들이 상대경로로 지정되면서 redirect 방식으로 인하여 링크가 깨지게 된다.
 
 이런 문제점을 없애기 위해서 절대주소로 변경하여 어디서 호출되든 정확한 주소를 입력 받도록 `절대주소`로 바꾸어 주었다.
 
 절대 주소로 바꾸기 위한 메소드로는 `request.getContextPath()`를 사용해 다음과 같이 해결해 주었다.
 
 ```jsp
 <link href="<%=request.getContextPath()%>/css/shopping.css" rel="stylesheet">
<script type="text/javascript" src = "<%=request.getContextPath()%>/member/member.js" charset="utf-8"></script>
 ```





<br><br><hr>


## 로그아웃   

<br>

### 로그아웃 기능  

로그아웃은 간단하다.   

세션을 invalidate 하고 이전처럼 이동할 페이지를 절대 경로로 넣어주면 된다.

```java
public class LogoutAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "/NonageServlet?command=index";
		
		HttpSession session = request.getSession();
		
		session.invalidate();
		
		response.sendRedirect(request.getContextPath()+url);
	}

}
```


**결과 화면(로그인 상태, 로그아웃 후 상태)**   
![image](https://user-images.githubusercontent.com/84966961/131094130-32954c6c-37e3-49b7-87d1-130bab99acd0.png)
![image](https://user-images.githubusercontent.com/84966961/131094175-b676fb9b-a320-4ef2-b93a-0f30cca89cf3.png)

<br><br><hr>



