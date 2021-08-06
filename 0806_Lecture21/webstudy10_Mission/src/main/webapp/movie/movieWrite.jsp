<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/movie.css">
<script type="text/javascript" src="script/movie.js"></script>
</head>
<body>
<div id="wrap">
	<h1>영화 정보 등록</h1>
	<form action="movieWrite.do" method="post" enctype="multipart/form-data" name="frm">
	<table>
		<tr>
			<th>제 목</th>
			<td><input type="text" name="title" size="100"/></td>
		</tr>
		<tr>
			<th>가 격</th>
			<td><input type="text" name="price" size="100"/> 원</td>
		</tr>
		<tr>
			<th>감 독</th>
			<td><input type="text" name="director" size="100" /></td>
		</tr>
		<tr>
			<th>배 우</th>
			<td><input type="text" name="actor" size="100"/></td>
		</tr>
		<tr>
			<th>설 명</th>
			<td><textarea name="synopsis" id="synopsis" cols="80" rows="10"></textarea></td>
		</tr>
		<tr>
			<th>사 진</th>
			<td><input type="file" name="pictureurl"/><input type="hidden" name="noimage"/></td>
		</tr>
	</table>
	<div class="btns" align="center">
		<input type="submit" value="확인" onclick="return movieCheck()"/>
		<input type="reset" value="취소" />
		<input type="button" value="목록" onclick="javascript:location.href='movieList.do'"/>
	</div>
	</form>
</div>
</body>
</html>