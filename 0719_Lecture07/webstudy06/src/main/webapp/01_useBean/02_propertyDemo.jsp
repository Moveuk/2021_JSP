<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<jsp:useBean id="member" class="javabeans.MemberBean"></jsp:useBean>
<hr>
◎ 자바 빈 객체 생성 후 저장된 정보 출력하기 <br /><br />

이름 : <jsp:getProperty property="member" name="name"/> <br>
아이디 : <jsp:getProperty property="member" name="userid"/>
<hr>

◎ 정보 변경한 후 변겅된 정보 출력하기 <br /><br />
<jsp:setProperty property="member" name="name" value="이동욱"/> <br>
<jsp:setProperty property="member" name="userid" value="moveuk"/> <br>
이름 : <jsp:getProperty property="member" name="name"/> <br>
아이디 : <jsp:getProperty property="member" name="userid"/>

</body>
</html>