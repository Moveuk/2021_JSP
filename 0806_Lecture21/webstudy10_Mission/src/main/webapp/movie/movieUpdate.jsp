<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	<h1>영화 정보 수정</h1>
	<form action="movieUpdate.do" method="post" enctype="multipart/form-data" name="frm">
	<input type="hidden" name="code" value="${mVo.code }" />
	<input type="hidden" name="noimage" value="${mVo.poster }" />
	<table border="1">
		<tr>
			<td rowspan="7" style="text-align: center;">
				<c:choose>
					<c:when test="${empty mVo.poster }"><img src="upload/noimage.gif"/></c:when>
					<c:otherwise><img src="upload/${mVo.poster }"/></c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<th>제 목</th>
			<td><input type="text" name="title" size="80" value="${mVo.title }"/></td>
		</tr>
		<tr>
			<th>가 격</th>
			<td><input type="text" name="price" size="80" value="${mVo.price }"/> 원</td>
		</tr>
		<tr>
			<th>감 독</th>
			<td><input type="text" name="director" size="80" value="${mVo.director }"/></td>
		</tr>
		<tr>
			<th>배 우</th>
			<td><input type="text" name="actor" size="80" value="${mVo.actor }"/></td>
		</tr>
		<tr>
			<th>설 명</th>
			<td><textarea name="synopsis" id="synopsis" cols="80" rows="10">${mVo.synopsis }</textarea></td>
		</tr>
		<tr>
			<th>사 진</th>
			<td><input type="file" name="poster"/></td>
		</tr>
	</table>
	<div class="btns" align="center">
		<input type="submit" value="수정" onclick="return movieCheck()"/>
		<input type="reset" value="취소" />
		<input type="button" value="목록" onclick="javascript:location.href='movieList.do'"/>
	</div>
	
	</form>
</div>
</body>
</html>