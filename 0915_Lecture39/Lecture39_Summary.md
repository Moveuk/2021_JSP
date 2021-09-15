# Lecture39 Nonage shop continue..

Key Word : qna write 구현, qna view 구현   

<hr>

## qna write 기능

![image](https://user-images.githubusercontent.com/84966961/133389336-477349c1-26e8-4c1b-8794-6b91df2d88a9.png)

<br><hr>

### qna 글쓰기 폼 액션

```java
public class QnaWriteFormAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "qna/qnaWrite.jsp";
		
		HttpSession session = request.getSession();
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		
		if (loginUser == null) {
			url = "NonageServlet?command=login_form";
		}
		
		request.getRequestDispatcher(url).forward(request, response);
	}

}
```


<br><hr>

### qna 글쓰기 뷰페이지

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<%@ include file="sub_img.html"%>
<%@ include file="sub_menu.jsp"%>
<article>
	<h2>1:1 고객 게시판</h2>
	<h3>고객님의 질문에 대해서 운영자가 1:1 답변을 드립니다.</h3>
	<form name="formm" method="post" action="NonageServlet?command=qna_write">
		<fieldset>
			<legend>Board Info</legend>
			<label>Title</label>
			<input type="text" name="subject" size="78">
			<br>
			<label>Content</label>
			<textarea rows="20" cols="80" name="content"></textarea>
			<br>
		</fieldset>
		<div class="clear"></div>
		<div id="buttons" style="float: right">
			<input type="submit" value="글쓰기" class="submit"> 
			<input type="reset" value="취소" class="cancel">
			<input type="button" value="쇼핑 계속하기" class="submit" onclick="location.href='NonageServlet?command=index'">
		</div>
	</form>
</article>
<%@ include file="../footer.jsp"%>

```


<br><hr>

### qna 글쓰기 액션

```java
public class QnaWriteAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "NonageServlet?command=qna_list";
		
		HttpSession session = request.getSession();
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		
		if(loginUser == null) {
			url = "NonageServlet?command=login_form";
		} else {
			QnaVO qnaVO = new QnaVO();
			qnaVO.setSubject(request.getParameter("subject"));
			qnaVO.setContent(request.getParameter("content"));
			
			QnaDAO qnaDAO = QnaDAO.getInstance();
			qnaDAO.insertQna(qnaVO, loginUser.getId());
		
		}
		
		response.sendRedirect(url);
	}

}
```

<br><hr>

### qna insert dao 추가

```java
	public void insertQna(QnaVO qnaVO, String session_id) {
		String sql = "insert into qna (qseq, subject, content, id) values(qna_seq.nextval, ?, ?, ?)";

		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DBManager.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, qnaVO.getSubject());
			pstmt.setString(2, qnaVO.getContent());
			pstmt.setString(3, session_id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.close(conn, pstmt);
		}
	}
```

<br><hr>

### actionFactory에 매핑 추가 후 작동 확인 

**작동 확인**   
![image](https://user-images.githubusercontent.com/84966961/133389914-d9987b4e-4fe8-4729-be4b-27332a3d428b.png)


![image](https://user-images.githubusercontent.com/84966961/133390408-16c38538-c8c9-4421-85ca-55773e4453c3.png)


<br><hr>

## qna 상세보기 기능

### qna 상세 뷰페이지

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<%@ include file="sub_img.html"%>
<%@ include file="sub_menu.jsp"%>
<article>
	<h2>1:1 고객 게시판</h2>
	<h3>고객님의 질문에 대해서 운영자가 1:1 답변을 드립니다.</h3>
	<form name="formm" method="post">
		<table id="cartList">
			<tr>
				<td>제목</td>
				<td>${qnaVO.subject }</td>
			</tr>
			<tr>
				<td>등록일</td>
				<td>${qnaVO.indate }</td>
			</tr>
			<tr>
				<td>질문내용</td>
				<td>${qnaVO.content }</td>
			</tr>
			<tr>
				<td>답변내용</td>
				<td>${qnaVO.reply }</td>
			</tr>
			</table>

		<div class="clear"></div>
		<div id="buttons" style="float: right">
			<input type="button" value="목록보기" class="submit" onclick="location.href='NonageServlet?command=qna_list'">
			<input type="button" value="쇼핑 계속하기" class="cancel" onclick="location.href='NonageServlet?command=index'">
		
		</div>
	</form>
</article>
<%@ include file="../footer.jsp"%>

```


<br><hr>

### qna action 

```java
public class QnaViewAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "qna/qnaView.jsp";
		
		HttpSession session = request.getSession();
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		
		if (loginUser == null) {
			url = "NonageServlet?command=login_form";
		} else {
			int qseq = Integer.parseInt(request.getParameter("qseq"));
			QnaDAO qnaDAO = QnaDAO.getInstance();
			
			QnaVO qnaVO = qnaDAO.getQna(qseq);
			
			request.setAttribute("qnaVO", qnaVO);
		}
		
		request.getRequestDispatcher(url).forward(request, response);
	}

}

```


<br><hr>

### getqna dao

```java
	public QnaVO getQna(int qseq) {
		String sql = "select * from qna where qseq=?";
		QnaVO qna = new QnaVO();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DBManager.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qseq);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				qna.setQseq(rs.getInt("qseq"));
				qna.setSubject(rs.getString("subject"));
				qna.setContent(rs.getString("content"));
				qna.setReply(rs.getString("reply"));
				qna.setId(rs.getString("id"));
				qna.setRep(rs.getString("rep"));
				qna.setIndate(rs.getTimestamp("indate"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.close(conn, pstmt, rs);
		}

		return qna;
	}
```


<br><hr>

### 매핑 후 작동 확인

**작동 확인**
![image](https://user-images.githubusercontent.com/84966961/133393383-a4b55748-be72-4315-b327-e47c90fbf31a.png)




<br><hr>
