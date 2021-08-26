<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="CSS/subpage.css" rel="stylesheet">
<style type="text/css">
body {
	background-color: #B96DB5;
	font-family: Verdana;
}

#wrap {
	margin: 0 20px;
}

h1 {
	font-family: "Times New Roman", Times, serif;
	font-size: 45px;
	color: #CCC;
	font-weight: normal;
}

input[type=button], input[type=submit] {
	float: right;
}
</style>
<script type="text/javascript">
	function idok() {
		opener.formm.id.value="${id}";
		opener.formm.reid.value="${id}";
		self.close();
	}
</script>
</head>
<body>
	<div class="wrap">
		<h1>ID 중복체크</h1>
		<form method="post" name="formm" action="NonageServlet?command=id_check_form" style="margin-right: 0">
			User ID <input type="text" name="id" value=""> 
					<input type="submit" value="검색" class="submit">
			<div style="margin-top: 20px">
				<c:if test="${message == 1}">
					<script type="text/javascript">
						// 1이면 아이디가 존재하므로 부모창에 id 값을 빈값으로 만듬
						opener.document.formm.id.value = "";
					</script>
			        ${id}는 이미 사용중인 아이디입니다.
			    </c:if>
				<c:if test="${message==-1}">
			        ${id}는 사용 가능한 ID입니다.
			        <input type="button" value="사용" class="cancel" onclick="idok()">
				</c:if>
			</div>
		</form>
	</div>
</body>
</html>