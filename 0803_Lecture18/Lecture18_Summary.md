# Lecture18 도전 : 사원 관리 시스템 퀴즈 & 파일 업로드

Key Word : 관리자 열람시 리스트 구현, 파일 업로드

<hr>

## 톰캣 구동 로그 확인 maxActive -> maxTotal

1. 로그창을 확인하다보니 maxActive 속성이 ignored 되었다는 로그가 뜨길래 검색해보았다.    
 
 ![image](https://user-images.githubusercontent.com/84966961/127944015-40c639d2-f757-4b8a-8b89-4170fe990b8a.png)
 
 검색해보니 네이버 기술 블로그에서 정리해준 좋은 글이 있었다.   

 JDBCP 버전 1.x 에서 버전 2로 바뀌면서 바뀐 변수들이 있다.    

![image](https://user-images.githubusercontent.com/84966961/127943480-790c4b89-eff0-4dc3-a8bb-f8846737ee83.png)   
출처 : https://d2.naver.com/helloworld/5102792   

 context.xml 파일에서 변경해주니 사라졌다.   

![image](https://user-images.githubusercontent.com/84966961/127944057-9457d444-0917-41f1-949d-d51271b87f22.png)   

<br>

2. INFO: 적어도 하나의 JAR가 TLD들을 찾기 위해 스캔되었으나 아무 것도 찾지 못했습니다. 스캔했으나 TLD가 없는 JAR들의 전체 목록을 보시려면, 로그 레벨을 디버그 레벨로 설정하십시오. 스캔 과정에서 불필요한 JAR들을 건너뛰면, 시스템 시작 시간과 JSP 컴파일 시간을 단축시킬 수 있습니다.

 이 문제도 검색해보니 잘 정리해놓으신 글이 있었다.   
 
링크 : https://javacan.tistory.com/entry/decrease-tomcat-startup-time-by-skip-jar-scan   

<br>

 [톰캣]/conf/logging.properties 파일에 다음 문구 추가
```
# logging.properties 파일 하단에 추가



# 탐색하는 jar 파일 목록 출력

org.apache.catalina.startup.ContextConfig.level = FINE

# TLD 관련 로그 출력

org.apache.jasper.servlet.TldScanner.level = FINE
```

다만 해보니 40ms 정도 차이가 나는 걸로 보아 미비하지만 서비스 사이즈가 커지면 요과가 있을지는 모르겠다. 또한 설정했는데도 불구하고 로그자체는 계속 뜬다.

<br><br><hr>

## mission : List를 출력하기

 header에 버튼을 하나 추가하여 관리자만이 리스트를 열람할 수 있도록 서블릿을 통해 구현하라.
 
 ![image](https://user-images.githubusercontent.com/84966961/127943630-169850b1-9808-4132-8061-6a52c66bc69d.png)    
![image](https://user-images.githubusercontent.com/84966961/127943685-2a196573-1e93-4254-b4c2-6517a1875d69.png)    
**클릭 불가능**    
![image](https://user-images.githubusercontent.com/84966961/127943712-12172578-f97d-4ae8-afc9-abd5dc6ccf8a.png)

<br><br><hr>

### 활용 기술

  - DAO에서 정보 List로 받아오기
  - for each를 사용해서 테이블 작성하기

<

**EmployeesDAO.java**
```java
	public ArrayList<EmployeesVO> getEmpList() {
		
		String sql = "SELECT * FROM employees";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		EmployeesVO member = null;
		ArrayList<EmployeesVO> members = new ArrayList<>();
		
		try {
			conn = getConnection();
			pstmt= conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
	
			while (rs.next()) {
				member = new EmployeesVO();
				member.setId(rs.getString(1));
				member.setPass(rs.getString(2));
				member.setName(rs.getString(3));
				member.setLev(rs.getString(4));
				member.setEnter(rs.getDate(5));
				member.setGender(rs.getInt(6));
				member.setPhone(rs.getString(7));
				
				members.add(member);
			}
			
		} catch (Exception e) {
			try {
				rs.close();
				pstmt.close();
				conn.close();
			} catch (Exception e2) {
				e.printStackTrace();
			}
		}
		
		return members;
	}
```


**ListServlet.java**
```java
package com.manage.controller;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.manage.dao.EmployeesDAO;
import com.manage.dto.EmployeesVO;

@WebServlet("/list.do")
public class ListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		EmployeesVO eVo= (EmployeesVO)session.getAttribute("loginUser");
		int result = (Integer)session.getAttribute("result");
		
		if(eVo != null && result == 2 && session!=null) {
			EmployeesDAO eDao = EmployeesDAO.getInstance();
			ArrayList<EmployeesVO> members = eDao.getEmpList();
			request.setAttribute("members", members);
			request.setAttribute("message", "사원 정보 조회 성공");
			RequestDispatcher rd = request.getRequestDispatcher("list.jsp");
			rd.forward(request, response);
		}else {
			response.sendRedirect("login.do");
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
```

 - JSTL과 ArrayList Iterator 활용
-> JSTL이 더 간단하다.


**list.jsp**
```jsp
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body align="center">
<table border="1" style="margin: 0 auto;">
	<thead>
		<tr>
			<th colspan="6"><h1> 회원 목록 </h1><div style="color: red;">${message }</div></th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>아이디</td>
			<td>비밀번호</td>
			<td>이름</td>
			<td>권한</td>
			<td>성별</td>
			<td>전화번호</td>
		</tr>
		<c:forEach var="emp" items="${members }">
		<tr>
			<td>${emp.id }</td>
			<td>${emp.pass }</td>
			<td>${emp.name }</td>
			<td>${emp.lev == 'A' ? "운영자" : "일반회원" }</td>
			<td>${emp.gender == 1 ? "남자" : "여자" }</td>
			<td>${emp.phone }</td>
		</tr>
		</c:forEach>
		<tr>
			<td colspan="6" style="color: red;"> 어레이 리스트 이터레이터 사용 </td>
		</tr>
		<% ArrayList<EmployeesVO> members = (ArrayList<EmployeesVO>) request.getAttribute("members");
		Iterator iterator = members.iterator();
		while (iterator.hasNext()) {
			EmployeesVO eVo = (EmployeesVO) iterator.next();
			out.print("<tr>");
				out.println("<td>"+eVo.getId()+"</td>");
				out.println("<td>"+eVo.getPass()+"</td>");
				out.println("<td>"+eVo.getName()+"</td>");
				out.println("<td>"+(eVo.getLev().equals("A") ? "운영자" : "일반회원")+"</td>");
				out.println("<td>"+(eVo.getGender() == 1 ? "남자" : "여자" )+"</td>");
				out.println("<td>"+eVo.getPhone()+"</td>");
			out.print("</tr>");
		}
		%>
		<tr>
			<td colspan="6"><input type="button" value="메인화면으로 이동" onclick="location.href='main.jsp'"></td>
		</tr>
	</tbody>
</table>
</body>
</html>
```

**결과 화면**   
![image](https://user-images.githubusercontent.com/84966961/127962748-38dad327-3bad-418c-941c-3cf242415936.png)
   

<br><br><hr>

## 생각해봐야할 점

DAO 내부
 -  DAO에 ArrayList를 사용하면 rs를 직접 쓰지 않고 깔끔해진다.
 -  가능하다면 각 튜플도 Map을 이용해 받으면 깔끔해질 것.

jsp 표현 방식
 -  jsp에서는 굳이 자바 코드를 사용해서 하는 것보다 JSTL 이라는 태그가 존재하므로 사용하면 이터레이터보다 깔끔하고 가독성 높은 jsp 파일을 만들 수 있다.




<br><br><hr>

# 교재 524p : 10강 파일 업로드

<hr>

## 파일 업로드에 사용되는 COS 라이브러리

<br>

### 배포방법

 다운로드 홈페이지 : http://www.servlets.com/cos/

 다운로드 링크 : http://www.servlets.com/cos/cos-20.08.zip

![image](https://user-images.githubusercontent.com/84966961/127966221-2f99e8b5-a215-49e6-9ce8-941490ce2adf.png)   

<br>

파일 내부의 lib > cos.jar 을 프로젝트 lib 내부에 복사 붙여넣기.   
   
![image](https://user-images.githubusercontent.com/84966961/127966444-a0fdfdaf-f18f-430a-a815-5c53b8e94d59.png)   

<br><br><hr>


### 파일 전송 폼 만들기

**01_upload.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="upload.do" method="post" enctype="multipart/form-data">
글쓴이 : <input type="text" name="name"><br>
제 &nbsp; 목 : <input type="text" name="title"><br />
파일 지정하기 : <input type="file" name="uploadFile" /> <br>
<input type="submit" value="전송">
</form>
</body>
</html>
```
   
**결과 화면**   
![image](https://user-images.githubusercontent.com/84966961/127967774-ec823bbc-4f95-4298-8718-77f94d83bfa5.png)




### 우리가 사용할 multipartRequest 라이브러리

![image](https://user-images.githubusercontent.com/84966961/127968285-f1cbc3e2-eeb9-41f0-a814-7ce5b2ff1ba5.png)


 MultipartRequest 클래스의 생성자와 매개변수에 대한 설명   
   

```
 MultipartRequest(
    javax.servlet.http.HttpServletRquest request,
    java.lang.String saveDirectory,
    int maxPostSize
    java.lang.String encoding,
    FileRenamePolicy policy
 )
```

매개 변수 | 설명
-|-
request | MultipartRequest와 연결할 request 객체 
saveDirectory | 서버 측에 저장될 경로(우리가 파일을 받을 위치)
maxPostSize | 최대 파일 크기
encoding | 파일의 인코딩 방식 (파일 이름이 한글일 경우 매개 변수 값을 utf-8로 준다.
policy | 파일 중복 처리를 위한 매개 변수.<br> policy는 중복 처리를 해주는 매개 변수로서 `b.bmp` 파일을 업로드 하였는데 다시 같은 파일을 업로드 할 경우 `b1.bmp`등으로 자동으로 파일 중복 처리를 해준다.<br> 매개 변수 값으로는 `new DefaultFileRenamePolicy()`를 사용한다.

다음은 MultipartRequest 클래스에서 사용하는 유용한 메소드를 정리한 표이다.    
-> 파일이 서버에 올라간 이후에 우리가 올라간 파일에 접근하여 속성을 확인할 때 사용하는 메소드들이다.

메소드명 | 설명
-|-
getParameterNames() | 폼에서 전송된 파라미터의 이름을 Enumeration 타입으로 리턴한다.
getParameterValues() | 폼에서 전송된 파라미터들을 배열로 받아온다.
getParameter() | 객체에 있는 해당 마라미터의 값을 가져온다.
getFileNames() | 파일을 여러 개 업로드 할 경우 극 값들을 Enumeration 타입으로 리턴한다.
getFilesystemName() | 서버에 실제로 업로드 된 파일의 이름을 의미한다.
getOriginalFileName() | 클라이언트가 업로드한 파일의 원본 이름을 의미한다.
getContentType() | 업로드 파일의 컨텐트 타입을 얻을 때 사용한다.
getFile() | 서버에 업로드된 파일의 정보를 객체로 얻어낼 때 사용한다.

<br><br><hr>


### 파일 전송 예제

다음은 파일을 저장하기 위한 디렉토리와 파일의 최대 크기 등을 정의한다.

```
String savePath = "upload"; // <- 여기를 바꿔부면 다운받는 경로가 바뀜.
int uploadFileSizeLimit = 5 * 1024 * 1024; // 최대 업로드 파일 크기 5MB로 제한
String encTyoe = "UTF-8";
```

다음은 서버상의 실제 경로를 찾아낸다.

```
ServletContext context = getServletContext();
String uploadFilePath = context.getRealPath(savePath);
```

uploadFilePath는 서버상에서 정한 파일 저장 위치를 나타낸다.    
   
D:\IT\HumanCenter\JSP\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps   
   
 이 위치에 저장된다.


<br><br><hr>


## 파일 전송 처리 서블릿

**UploadServlet.java**
```java
package com.saeyan.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/upload.do")
public class UploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		// 여기를 바꿔주면 다운받는 경로가 바뀜
		String savePath = "upload";
		// 최대 업로드 파일 크기 5MB로 제한
		int uploadFileSizeLimit = 5 * 1024 *1024;
		String encType = "UTF-8";
		
		ServletContext context = getServletContext();
		String uploadFilePath = context.getRealPath(savePath);
		System.out.println("서버상의 실제 디렉토리 :");
		System.out.println(uploadFilePath);
		
		try {
			MultipartRequest multi = new MultipartRequest(
					request,				// request 객체
					uploadFilePath,			// 서버상의 실제 디렉토리
					uploadFileSizeLimit,	// 최대 업로드 파일 크기
					encType,				// 인코딩 방법
					new DefaultFileRenamePolicy());		// 동일한 이름이 존재하면 새로운 이름이 부여됨
			// 업로드된 파일의 이름 얻기
			String fileName = multi.getFilesystemName("uploadFile");
			
			if (fileName == null) { // 파일이 업로드 되지 않았을 때.
				System.out.println("파일이 업로드 되지 않았음.");
			} else {	// 파일이 업로드 되었을 때
				out.println("<br> 글쓴이 : " + multi.getParameter("name"));
				out.println("<br> 제 &nbsp; 목 : " + multi.getParameter("title"));
				out.println("<br> 파일명 : " + fileName);
			}	// else
		} catch (Exception e) {
			e.printStackTrace();
		}	// catch
		
	}

}

```

**결과 화면**    
![image](https://user-images.githubusercontent.com/84966961/127977109-d0e5fd94-7a6b-4c3d-8949-e7c5600e5f9a.png)    
    
![image](https://user-images.githubusercontent.com/84966961/127977073-937d2ba7-e19c-4087-b07d-4512dfa5f977.png)     
    
![image](https://user-images.githubusercontent.com/84966961/127977177-e50e08b6-fc6f-454a-8e80-f9bfcbe1b483.png)    

<br><br>

두번 입력하면 1이 붙어서 올라간다.

![image](https://user-images.githubusercontent.com/84966961/127979514-85c00093-5059-4f15-9557-a62a909caa2e.png)    
![image](https://user-images.githubusercontent.com/84966961/127979577-f8a916e5-6388-4e15-92d3-f36eecdc8b8e.png)    


<br><br><hr>

## 서버에 현재 올라간 파일들 보기

![image](https://user-images.githubusercontent.com/84966961/127979974-c9e11e30-3535-4975-9c4e-787bcdad36a8.png)    

이 상태에서 09번을 없애면 메타데이터 폴더의 서버 코어 플러그인 상에서 사라진다.    

![image](https://user-images.githubusercontent.com/84966961/127980042-f176f7b3-7c93-4758-9509-c2baffc24023.png)    

![image](https://user-images.githubusercontent.com/84966961/127980119-9d574ade-0dfa-41b0-b8b5-67b9d2847265.png)    












