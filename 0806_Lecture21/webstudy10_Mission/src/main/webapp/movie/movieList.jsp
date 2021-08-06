<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/movie.css">
</head>
<body>
	<div id="wrap" align="center">
		<h1>리스트</h1>
		<table>
			<tr>
				<td colspan="6" style="border: white; text-align: right;"><a href="movieWrite.do">정보등록</a></td>
			</tr>
			<tr>
				<th>제목</th>
				<th>감독</th>
				<th>배우</th>
				<th>가격</th>
				<th>파일</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			<c:if test="${empty movieList }"> 나는 비어있따</c:if>
			<c:forEach var="movie" items="${movieList }">
				<tr class="record">
					<td><a href="movieDetail.do?code=${movie.code }">${movie.title }</a></td>
					<td>${movie.director }</td>
					<td>${movie.actor }</td>
					<td>${movie.price }</td>
					<td><c:choose>
					<c:when test="${empty mVo.poster }">이미지가 없습니다.</c:when>
					<c:otherwise>
					<a href="upload/${mVo.poster }" download>${mVo.poster }</a>
					</c:otherwise>
				</c:choose></td>
					<td><a href="movieUpdate.do?code=${movie.code }">정보 수정</a></td>
					<td><a href="movieDelete.do?code=${movie.code }">정보 삭제</a></td>
				</tr>
			</c:forEach>
		</table>
	</div>
</body>
</html>