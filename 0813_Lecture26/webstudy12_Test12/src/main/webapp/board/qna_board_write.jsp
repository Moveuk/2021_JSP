<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function add() {
	document.frm.submit();
}
</script>
</head>
<body>
	<div id="wrap" style="width: 600px;">
		<table style="width: 100%">
			<tr>
				<td>
					<h2 style="text-align: center;">MVC 게시판</h2>
				</td>
			</tr>
		</table>
		<form action="BoardAddAction.bo" method="post" enctype="multipart/form-data" name="frm">
			<table>
				<tr>
					<td>글쓴이</td>
					<td>
						<input type="text" name="name" />
					</td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td>
						<input type="password" name="pass" />
					</td>
				</tr>
				<tr>
					<td>제 목</td>
					<td>
						<input type="text" name="subject" />
					</td>
				</tr>
				<tr>
					<td>내 용</td>
					<td>
						<textarea rows="15" cols="70" name="content"></textarea>
					</td>
				</tr>
				<tr>
					<td>파일 첨부</td>
					<td>
						<input type="file" name="file" />
					</td>
				</tr>
			</table>
		</form>
		<div id="buttons" style="text-align: center;">
			[<a href="#" onclick="return add()">등록</a>] 
			[<a href="#" onclick="history.back()">뒤로</a>]
		</div>
	</div>
</body>
</html>