<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="net.board.db.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean class="net.board.db.BoardBean" id="article"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="wrap" style="width: 600px;">
		<table style="width: 100%">
			<tr>
				<td>
					<h2>MVC 게시판</h2>
				</td>
			<%
			if (request.getAttribute("articleCount") == "0") {
			%>
			<td style="text-align: center;">등록된 글이 없습니다.</td></tr>
		</table>
		<%
		} else {
		%>
		<td>글 개수 : <%= request.getAttribute("articleCount") %></td></tr>
		</table>
		<table align="center">
			<tr>
				<td>번호</td>
				<td>제목</td>
				<td>작성자</td>
				<td>날짜</td>
				<td>조회수</td>
			</tr>
			<% 
			ArrayList<BoardBean> list = (ArrayList<BoardBean>) request.getAttribute("list");
			Iterator it = list.iterator();
			while (it.hasNext()) { 
			BoardBean bb = (BoardBean) it.next();%>
			<tr>
				<td style="text-align: center;"><%=bb.getBoard_num() %></td>
				<td style="width: 40%;"><a href="BoardDetail.bo?num=<%=bb.getBoard_num() %>"><%=bb.getBoard_subject() %></a></td>
				<td style="text-align: center;"><%=bb.getBoard_name() %></td>
				<td style="text-align: center;"><%=bb.getBoard_date() %></td>
				<td style="text-align: center;"><%=bb.getBoard_readcount() %></td>
			</tr>
			<%	} %>
		</table>
		<%
		}
		%>
		<div id="buttons" style="float: right;">
			[<a href="BoardWrite.bo">글쓰기</a>]
		</div>
	</div>
</body>
</html>