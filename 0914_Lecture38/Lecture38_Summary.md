# Lecture38 Nonage shop continue..

Key Word : qna 구현   

<hr>

## qna 기능


![image](https://user-images.githubusercontent.com/84966961/133212308-20da7329-0e06-4ab8-8167-241e5287ea84.png)


<br><hr>

### 서브메뉴 서브이미지 구성

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta charset="UTF-8">
	<nav id="sub_menu">
		<ul>
			<li><a href="NonageServlet?command=qna_list">Q&amp;A 게시글 리스트</a></li>
			<li><a href="NonageServlet?command=qna_write_form">Q&amp;A 게시글 쓰기</a></li>
		</ul>
	</nav>
```

```jsp
<div id="sub_img">
	<img src="images/mypage/sub_img.jpg" alt="" />
</div>
<div class="clear"></div>
```

<br><hr>


### qna list controller

```java
package com.nonage.controller.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.nonage.dao.OrderDAO;
import com.nonage.dao.QnaDAO;
import com.nonage.dto.MemberVO;
import com.nonage.dto.OrderVO;
import com.nonage.dto.QnaVO;

public class QnaListAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "qna/qnaList.jsp";
		
		HttpSession session = request.getSession();
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		
		if(loginUser == null) {
			url = "NonageServlet?command=login_form";
		}else {
			QnaDAO qnaDAO = QnaDAO.getInstance();
			ArrayList<QnaVO> qnaList = QnaDAO.listQna(loginUser.getId());
			
			request.setAttribute("qnaList", qnaList);
		}
		request.getRequestDispatcher(url).forward(request, response);
		
		
	}

}

```

<br><hr>

### qna list 뷰페이지

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
				<th>번호</th>
				<th>제목</th>
				<th>등록일</th>
				<th>답변여부</th>
			</tr>
			<c:forEach items="${qnaList}" var="qnaVO">
				<tr>
					<td>${qnaVO.qseq}</td>
					<td>${qnaVO.subject}</td>
					<td>${qnaVO.indate}</td>
					<td>
						<c:choose>
							<c:when test="${qnaVO.rep == 1 }">no</c:when>
							<c:when test="${qnaVO.rep == 2 }">yes</c:when>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
		</table>
		<div class="clear"></div>
		<div id="buttons" style="float: right">
			<input type="button" value="1:1 질문하기" class="submit" onclick="location.href='NonageServlet?command=qna_write_form'">
			<input type="button" value="쇼핑 계속하기" class="cancel" onclick="location.href='NonageServlet?command=index'">
		</div>
	</form>
</article>
<%@ include file="../footer.jsp"%>
```

<br><hr>


