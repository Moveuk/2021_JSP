<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!

// 1. int 형 변수 하나를 정의하고 12345로 초기화 한다.
	int num = 12345;
// 2. reverse() 메소드를 정의한다.
// 3. 반환 타입은 int 형으로 한다.
// 4. 54321로 리턴하는 함수를 만든다.
	int reverse(int n) {
		int result = 0;
		for (int i = 0; n > 0; i++) {
		//while (n != 0) {		
			result = result*10 + (n % 10);
			n /= 10;
		}
	
	return result;
	}

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>초기값을 뒤집어 출력하는 함수 만들기</h2>

	초기값 : <%=num %><br>
	결과값 : <%=reverse(num) %>

</body>
</html>