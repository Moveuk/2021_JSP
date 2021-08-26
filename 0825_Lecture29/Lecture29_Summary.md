# Lecture29 Nonage shop continue..

Key Word : 회원가입 폼 생성, DAO ID 중복체크 기능 추가

<hr>

## 회원가입 폼 생성    

<br>

### 폼 구현 및 ID 중복체크 파트

1. JoinFormAction 구성
```java
public class JoinFormAction implements Action {
  @Override
  public void execute(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {    
    String url = "/member/join.jsp";  
    
    RequestDispatcher dispatcher=request.getRequestDispatcher(url);
    dispatcher.forward(request, response);
  }
}
```

<br><br>

2. join.jsp 구성

![image](https://user-images.githubusercontent.com/84966961/130741117-793fc9ca-3349-48b9-b049-6b1fe4a4ea18.png)



<br><br>

3. IdCheckFormAction 구성
```java
public class IdCheckFormAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "/member/idcheck.jsp";
		
		String id = request.getParameter("id");
	}

}
```


<br><br>

4. id 중복 체크 폼 : idcheck.jsp

```jsp
<body>
	<div class="wrap">
		<h1>ID 중복체크</h1>
		<form method="post" name="formm" action="NonageServlet?command=id_check_form" style="margin-right: 0">
			User ID <input type="text" name="id" value=""> 
					<input type="submit" value="검색" class="submit">
			<div style="margin-top: 20px">
				<c:if test="${message == 1}">
					<script type="text/javascript">
						// 1이면 아이디가 존재하므로 부모창에 id 값을 빈값으로 만듬
						opener.document.formm.id.value = "";
					</script>
			        ${id}는 이미 사용중인 아이디입니다.
			    </c:if>
				<c:if test="${message==-1}">
			        ${id}는 사용 가능한 ID입니다.
			        <input type="button" value="사용" class="cancel" onclick="idok()">
				</c:if>
			</div>
		</form>
	</div>
</body>
```

<br><br><hr>


### DAO 파트

<br>

#### confirmID : id 중복체크 기능

```java
	  public int confirmID(String userid) {
		int result = -1;
	    String sql = "select * from member where id=?";
	       
	    Connection connn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    try {
	      connn = DBManager.getConnection();
	      pstmt = connn.prepareStatement(sql);
	      pstmt.setString(1, userid);
	      rs = pstmt.executeQuery();
	      if (rs.next()) { 
	    	  // 아이디 중복이라면
	        result = 1;
	      } else { 
	    	  // 아이디 중복이 아니라면
	        result = -1;
	      }
	    } catch (Exception e) {
	      e.printStackTrace();
	    } finally {
	      DBManager.close(connn, pstmt, rs);
	    }
	    return result;
	  }
```

<br><br><hr>



