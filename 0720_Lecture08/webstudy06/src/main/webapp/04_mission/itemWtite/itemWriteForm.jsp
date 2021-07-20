<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="content">
		<h3>정보 입력 폼</h3>
		<form action="itemWrite.jsp" method="post">
			<table border="1">
				<tr>
					<td>상품명</td>
					<td>
						<input type="text" name="name" value="핸드폰" size="20" />
					</td>
				</tr>
				<tr>
					<td>가격</td>
					<td>
						<input type="text" name="price" value="450000" size="20" /> 원
					</td>
				</tr>
				<tr>
					<td>설명</td>
					<td>
						<textarea name="description" rows="10" cols="100" >LTE-A입니다.</textarea>
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