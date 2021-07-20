<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="board" class="javabeans.BoardBean"></jsp:useBean>
<jsp:setProperty property="*" name="board" />
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
				<jsp:getProperty property="name" name="board"/>
			</td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td>
				<jsp:getProperty property="pass" name="board"/>
			</td>
		</tr>
		<tr>
			<td>이메일</td>
			<td>
				<jsp:getProperty property="email" name="board"/>
			</td>
		</tr>
		<tr>
			<td>글 제목</td>
			<td>
				<jsp:getProperty property="title" name="board"/>
			</td>
		</tr>
		<tr>
			<td>글 내용</td>
			<td>
				<jsp:getProperty property="content" name="board"/>
			</td>
		</tr>
	</table>
</body>
</html>