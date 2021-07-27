<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>정보 입력 폼</h2>
		<form method="post" action="itemWriteResult.jsp">
			<table>
				<tr>
					<td id="rowstyle">상품명</td>
					<td><input type="text" name="name"></td>

				</tr>
				<tr>
					<td id="rowstyle">가격</td>
					<td><input type="text" name="price"></td>
				</tr>
				<tr> 
					<td id="rowstyle" height="100px">설명</td>
					<td>
					<textarea cols="80" rows="10" name="description"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="전송">
						<input type="reset" value="취소">
					</td>
				</tr>
				<tr>
			</table>
			
		</form>
</body>
</html>