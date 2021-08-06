<%@page import="java.io.FileInputStream"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/movie.css">
</head>
<body>
<div id="wrap">
	<h1>영화 정보 상세</h1>
	<table>
		<tr>
			<td rowspan="7" style="width: 25%; text-align: center;">
				<c:choose>
					<c:when test="${empty mVo.poster }"><img src="upload/noimage.gif"/></c:when>
					<c:otherwise><img src="upload/${mVo.poster }"/></c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<th>제 목</th>
			<td>${mVo.title }</td>
		</tr>
		<tr>
			<th>가 격</th>
			<td>${mVo.price } 원</td>
		</tr>
		<tr>
			<th>감 독</th>
			<td>${mVo.director }</td>
		</tr>
		<tr>
			<th>배 우</th>
			<td>${mVo.actor }</td>
		</tr>
		<tr>
			<th>설 명</th>
			<td>${mVo.synopsis }</td>
		</tr>
		<tr>
			<th>사 진</th>
			<td>
				<c:choose>
					<c:when test="${empty mVo.poster }">이미지가 없습니다.</c:when>
					<c:otherwise>
					<a href="upload/${mVo.poster }" download>${mVo.poster }</a><br>
					<a href="upload/${mVo.poster }" download>${mVo.poster }</a>
					</c:otherwise>
				</c:choose></td>
		</tr>
	</table>
	<div class="btns" align="center">
		<input type="button" value="글쓰기" onclick="javascript:location.href='movieWrite.do'"/>
		<input type="button" value="목록" onclick="javascript:location.href='movieList.do'"/>
	</div>
</div>
</body>
</html>