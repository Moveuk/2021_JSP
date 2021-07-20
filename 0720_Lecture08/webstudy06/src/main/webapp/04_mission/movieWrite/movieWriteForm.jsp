<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="content">
		<h3>게시판 글쓰기</h3>
		<form action="movieWrite.jsp" method="post">
			<table border="1">
				<tr>
					<td>작성자</td>
					<td>
						<input type="text" name="title" value="설국열차" size="20" />
					</td>
				</tr>
				<tr>
					<td>가격</td>
					<td>
						<input type="text" name="price" value="7000" size="20" />
						원
					</td>
				</tr>
				<tr>
					<td>감독</td>
					<td>
						<input type="text" name="director" value="봉준호" size="20" />
					</td>
				</tr>
				<tr>
					<td>배우</td>
					<td>
						<input type="text" name="actor" value="송강호" size="20" />
					</td>
				</tr>
				<tr>
					<td>시놉시스</td>
					<td>
						<textarea name="synopsis" rows="30" cols="100">기상 이변으로 모든 것이 꽁꽁 얼어 붙은 지구. 살아남은 사람들을 태운 기차 한 대가 끝없이 궤도를 달리고 있다. 춥고 배고픈 사람들이 바글대는 빈민굴 같은 맨 뒤쪽의 꼬리칸, 그리고 선택된 사람들이 술과 마약까지 즐기며 호화로운 객실을 뒹굴고 있는 앞쪽칸, 열차 안의 세상은 결코 평등하지 않다.</textarea>
					</td>
				</tr>
				<tr>
					<td>장르</td>
					<td>
						<select name="genre" >
							<option value="로맨스">로맨스</option>
							<option value="스릴러">스릴러</option>
							<option value="미스터리">미스터리</option>
							<option value="액션">액션</option>
							<option value="코메디">코메디</option>
							<option value="애니메이션">애니메이션</option>
						</select>
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