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