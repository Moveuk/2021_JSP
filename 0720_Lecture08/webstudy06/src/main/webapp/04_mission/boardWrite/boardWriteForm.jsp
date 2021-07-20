<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.content {
	margin: 0 auto;
}
.td:nth-of-type(2) {
	text-align: left;
}
</style>
</head>
<body>
	<div class="content">
		<h3>게시판 글쓰기</h3>
		<form action="boardWrite.jsp" method="post">
			<table border="1">
				<tr>
					<td>작성자</td>
					<td>
						<input type="text" name="name" value="너구리" size="20" />
					</td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td>
						<input type="password" name="pass" value="1234" size="20" />
						(게시물 수정 삭제시 필요합니다.)
					</td>
				</tr>
				<tr>
					<td>이메일</td>
					<td>
						<input type="text" name="email" value="pinksubin@nate.com" size="40" />
					</td>
				</tr>
				<tr>
					<td>글 제목</td>
					<td>
						<input type="text" name="title" value="JSP" size="80" />
					</td>
				</tr>
				<tr>
					<td>글 내용</td>
					<td>
						<textarea rows="30" name="content" cols="100" >JSP 정말 재미있어요.</textarea>
					</td>
				</tr>
			</table>
			<div>
				<input type="submit" value="등록">
				<input type="reset" value="다시 작성" />
			</div>
		</form>
	</div>

</body>
</html>