# Lecture28 Test12 리뷰

Key Word : MultiPartRequest의 주소값, DelegatingPrepareStatement with address : NULL is closed 오류, SQL과 톰캣의 오류

<hr>

## 오류 정리

1. MultiPartRequest 사용시 파일 주소값 설정.
```java
//			ServletContext context = getServletContext();
//			String path = context.getRealPath("/upload");
//			String encType = "UTF-8";
//			int sizeLimit = 20 * 1024 * 1024;
//			
//			MultipartRequest multi = new MultipartRequest(request, path, sizeLimit, encType, new DefaultFileRenamePolicy());
//			
//			request.setAttribute("context", context);
//			request.setAttribute("multi", multi);
```

 코드를 보면 두번째 줄에 getRealPath 부분에 /를 넣지 않고 했더니 다음과 같은 오류가 뜬다. 그래서 구글링하였고, getRealPath가 주소값에 뒤에 붙여주는 것임에도 이클립스에서 만든 폴더가 아니라 인식하지 못하는 듯하다는 답변을 찾았다. 하지만 그 밑의 답변에 `/`를 넣어주면 작동이 된다고 하여 넣었더니 작동이 되었다. 

![image](https://user-images.githubusercontent.com/84966961/129832832-ef67d651-83c1-4080-897d-b99b7fb0ec8b.png)    

참고 글 :

  - https://chinggin.tistory.com/213
  - 교재 출판사 자료 : http://roadbook.zerois.net/xe/qna1/8059
    - 파일 저장 장소를 다른 곳으로 하고 다른 서블릿을 만들도록 답변함.
    - 단순히 / 를 넣는 학생의 답변으로 해결함.

<br><br><hr>

2. DelegatingPrepareStatement 오류

![image](https://user-images.githubusercontent.com/84966961/129833175-4bec2c43-2f6e-4001-8b2f-476e27db22e6.png)

구글링을 해보니 pstmt가 close 되었기 때문이라고 답변이 있었으나 본인 스스로 찾지 못했음.

```java
	public boolean boardInsert(BoardBean boardBean){
		boolean result = false;
		try {
			String sql = "INSERT INTO board(board_num, board_name, board_pass, board_subject, board_content, board_file, board_readcount, board_date) VALUES(?, ?, ?, ?, ?, ?, 0, sysdate)";
//			String sql = "INSERT INTO board VALUES(2,'','','','','',0,sysdate)";
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
//			int cnt = getListCount()+1; 메소드 내부에서 다른 메소드를 쓰면 같은 걸 써서 닫아버림.
			int cnt = 2;
			System.out.println("인서트 내부 번호 정상 출력 :"+cnt);
			pstmt.setInt(1, cnt);
			System.out.println("인서트 내부 이름 :"+boardBean.getBoard_name());
			String name = boardBean.getBoard_name();
			String pass = boardBean.getBoard_pass();
			String subject = boardBean.getBoard_subject();
			String content = boardBean.getBoard_content();
			String file = boardBean.getBoard_file();
			pstmt.setString(2, name);
			pstmt.setString(3, pass);
			pstmt.setString(4, subject);
			pstmt.setString(5, content);
			pstmt.setString(6, file);
			
          
          int insert =pstmt.executeUpdate();
          if(insert==0)return false;
          
          return true;
       }catch(Exception ex){
          System.out.println("boardInsert 에러 : "+ex);
       }finally{
          if(rs!=null) try{rs.close();}catch(SQLException ex){}
          if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
          if(con!=null) try{con.close();}catch(SQLException ex){}
       }
       return false;
    }
```

 이유는 글갯수를 찾는 메소드를 사용해서 글 번호를 넣어주려고 했으나 DAO 메소드 상에서 같은 conn, pstmt를 사용했고 메소드 끝에 finally 블록에서 close 해버리니 우리가 실제 insert문을 넣어야  할 pstmt이 NULL 값으로 되는 문제가 발생함.
 
 -> DAO의 내부에서 다른 DAO 메소드를 사용하면 connection 풀에 커넥션이 여러 개니 개별적으로 작동할 것이라는 착각으로 유발된 문제이며 내부에서 사용하게되면 같은 커넥션을 사용하게 되고 만약 사용하고 싶다면 close를 하면 안된다.


<br><br><hr>

3. SQL과 톰캣의 오류

  -> 특정 이유를 모르겠으나 sql이나 톰캣이 멈춰서 이클립스에서 서버를 다시 리스타트 하더라도 먹통되어 sql 처리가 지연되고 먹통되는 경우가 있다. 그럴 때는 developer를 리프레시하거나 데이터를 삭제 후 다시 붙을수 있도록 해주자.










