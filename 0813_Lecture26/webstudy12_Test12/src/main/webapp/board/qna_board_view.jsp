<%@page import="net.board.db.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<body>
	<div id="wrap" style="width: 600px;">
		<table style="width: 100%">
			<tr>
				<td>
					<h2 style="text-align: center;">MVC 게시판</h2>
				</td>
			</tr>
		</table>
			<table>
			<% BoardBean bb = (BoardBean) request.getAttribute("article"); %>
				<tr>
					<td>제 목</td>
					<td>
						<%= bb.getBoard_subject() %>
					</td>
				</tr>
				<tr>
					<td>내 용</td>
					<td style="height: 400px;">
						<%= bb.getBoard_content() %>
					</td>
				</tr>
				<tr>
					<td>첨부파일</td>
					<td>
						<a href="#"><%= bb.getBoard_file()  %></a>
					</td>
				</tr>
			</table>
		<div id="buttons" style="text-align: center;">
			[<a href="BoardList.bo" >목록</a>]
		</div>
	</div>
</body>
</html>