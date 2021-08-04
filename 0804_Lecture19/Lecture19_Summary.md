# Lecture19 파일 업로드 & 상품 정보 쇼핑몰

Key Word : 파일 업로드, 상품 정보 쇼핑몰 관리자, DTO, DAO, DBManager, ListForm, css, Controller 서블릿

<hr>

## 멀티 업로드

**02_multi_upload.jsp**
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
	1. 파일 지정하기 : <input type="file" name="uploadFile01" /> <br>
	2. 파일 지정하기 : <input type="file" name="uploadFile02" /> <br>
	3. 파일 지정하기 : <input type="file" name="uploadFile03" /> <br>
<input type="submit" value="전송">
</form>
</body>
</html>
```

**MultiUploadServlet.java**
```java
package com.saeyan.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/upload.do")
public class MultiUploadServlet extends HttpServlet {
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
			Enumeration files = multi.getFileNames();
			while (files.hasMoreElements()) {
				String file = (String) files.nextElement();
				String fileName = multi.getFilesystemName(file);
				String fileOriginalName = multi.getOriginalFileName(file);
				out.print("<br> 업로드된 파일명 : " + fileName);
				out.print("<br> 원본 파일명 : " + fileOriginalName);
				out.print("<hr>");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}	// catch
		
	}

}

```


<br><br><hr>

## 멀티 업로드 예제 2 - 수업

**fileUploadForm.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title>FileUpload Form</title>
<style>
	#uploadFormArea{
		margin : auto;
		width : 350px;
		border : 1px solid black;
	}
	.td_title{
		font-size: xx-large;
		text-align: center;
	}
</style>
</head>
<body>
<section id = "uploadFormArea">
<form action="fileUpload.jsp" method="post" enctype="multipart/form-data">
<table>
	<tr>
		<td colspan="2" class = "td_title" >파일 업로드 폼</td>
	<tr>
		<td><label for = "name">올린 사람 : </label></td><td><input type="text" name="name" id = "name"></td>
	</tr>
	<tr>
		<td><label for = "subject">제목 : </label></td><td><input type="text" name="subject" id = "subject"></td>
	</tr>
	<tr>
		<td><label for = "fileName1">파일명1 : </label></td><td><input type="file" name="fileName1" id = "fileName1"></td>
	</tr>
	<tr>
		<td><label for = "fileName2">파일명2 : </label></td><td><input type="file" name="fileName2" id = "fileName2"></td>
	</tr>
	<tr>
		<td colspan=2 align=center><input type="submit" value="전송"></td>
	</tr>
</table>
</form>
</section>
</body>
</html>
```

**fileUpload.jsp**
```jsp
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	String savePath = "upload";
	int uploadFileSizeLimit = 5 * 1024 * 1024;
	String encType = "UTF-8";
	String uploadFilePath = request.getRealPath("/upload");
	
	String name = "";
	String subject = "";
	String filename1 = "";
	String filename2 = "";
	String origfilename1 = "";
	String origfilename2 = "";

	try {
		MultipartRequest multi = new MultipartRequest(
				request,
				uploadFilePath,
				uploadFileSizeLimit,
				encType,
				new DefaultFileRenamePolicy());
		
		name = multi.getParameter("name");
		subject = multi.getParameter("subject");
		
		Enumeration files = multi.getFileNames();
		
		String file1 = (String)files.nextElement();
		filename1 = multi.getFilesystemName(file1);
		origfilename1 = multi.getOriginalFileName(file1);
		
		String file2 = (String)files.nextElement();
		filename2 = multi.getFilesystemName(file2);
		origfilename2 = multi.getOriginalFileName(file2);
		
	} catch (Exception e) {
		e.printStackTrace();
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form name="filecheck" action="fileCheck.jsp" method="post">
		<input type="hidden" name="name" value=<%=name%>>
		<input type="hidden" name="subject" value=<%=subject%>>
		<input type="hidden" name="filename1" value=<%=filename1%>>
		<input type="hidden" name="filename2" value=<%=filename2%>>
		<input type="hidden" name="origfilename1" value=<%=origfilename1%>>
		<input type="hidden" name="origfilename2" value=<%=origfilename2%>>
		<a href="#" onclick="javascript:filecheck.sumbit()">업로드 확인 및 다운로드 페이지 이동</a>
	</form>
</body>
</html>
```



**결과 화면**    
![image](https://user-images.githubusercontent.com/84966961/128111198-04d79716-6027-414d-994d-03f53d384335.png)    
![image](https://user-images.githubusercontent.com/84966961/128111155-8104166c-0ca0-441a-9257-7f1c135a85c7.png)    
![image](https://user-images.githubusercontent.com/84966961/128111329-55da74a6-8894-4f8f-920c-657f1f8615cd.png)   
![image](https://user-images.githubusercontent.com/84966961/128111307-43fbf786-9251-4d8e-a386-00351011ffe4.png)    



**fileCheck.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("name");
	String subject = request.getParameter("subject");
	String filename1 = request.getParameter("filename1");
	String filename2 = request.getParameter("filename2");
	String origfilename1 = request.getParameter("origfilename1");
	String origfilename2 = request.getParameter("origfilename2");
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	올린사람 : <%= name  %><br>
	제 &nbsp; 목 : <%= subject%><br>
	파일명1 : <a href="file_down.jsp?file_name=<%=filename1%>"></a><%= origfilename1%><br>
	파일명2 : <a href="file_down.jsp?file_name=<%=filename2%>"></a><%= origfilename2%><br>
</body>
</html>
```

**file_down.jsp**
```jsp
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%
	String fileName = request.getParameter("file_name");
	
	// 폴더 위치
	String savePath = "upload";
	// 주소값 얻기 :  jsp getRealPath로 얻어와도 됨.
	ServletContext context = getServletContext();
	String sDownloadFilePath = context.getRealPath(savePath);
	String sFilePath = sDownloadFilePath + "\\" + fileName;
	byte b[] = new byte[4096];
	FileInputStream in = new FileInputStream(sFilePath);
	
	String sMimeType = getServletContext().getMimeType(sFilePath);
	
	if (sMimeType == null) {
		sMimeType = "application/octet-stream";
	}
	
	response.setContentType(sMimeType);
	String agent = request.getHeader("User-Agent");
	boolean ieBrowser = (agent.indexOf("MSIE") > -1) || (agent.indexOf("Trident") > -1);

	if (ieBrowser) {
		fileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
	} else {
		fileName = new String(fileName.getBytes("UTF-8"), "iso-8859-1");
	}

	response.setHeader("Content-Disposition", "attachment; filename = " + fileName);		
	
	ServletOutputStream out2 = response.getOutputStream();

	int numRead;
	
	while ((numRead = in.read(b,0,b.length)) != -1) {
		out2.write(b,0,numRead);
		
	}
	
	out2.flush();
	out2.close();
	in.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>
```
**결과 화면**   
클릭시 다운로드가 된다.    
![image](https://user-images.githubusercontent.com/84966961/128127003-6c851c2b-cc8a-4323-9b2c-0fc85a4960fa.png)


<br><br><hr>

## 쇼핑몰 관리자 애플리케이션 작성 - cos.jar 파일을 이용한 이미지 업로드

![image](https://user-images.githubusercontent.com/84966961/128126700-ec7a0a8e-0a71-41c5-a088-0f373638e044.png)


**db 생성**

```sql
create table product(
    code number(5),
    name varchar2(100),
    price number(8),
    pictureurl varchar(50),
    description varchar(1000),
    primary key(code)
);

create SEQUENCE product_seq 
    start with 1
    increment by 1;
    
insert into product values(product_seq.nextval,'개념을 콕콕 잡아주는 데이터베이스',27000,'db.jpg','데이터베이스에 관한 모든것을 쉽고 재미있게 정리한 교재...');
insert into product values(product_seq.nextval,'웹표준을 위한 HTML5',25000,'html5,jpg','HTML5 가이드북. 홈페이지 제작을 위한 필수 선택 HTML 기본 문법...');
insert into product values(product_seq.nextval,'Dynamic Programming book 시리즈-01 오라클 11g + PL/SQL',25000,'oracle.jpg','Dynamic 실무 코칭 프로그래밍 Book의 첫번째 책으로, 오라클 11g의 새로운 ...');
insert into product values(product_seq.nextval,'Visual C++ MFC 윈도우 프로그래밍',26000,'mfc.jpg','Visual C++를 처음 시작하는 독자의 눈높이에 맞춘 Visual C++...');
insert into product values(product_seq.nextval,'jQuery and jQuery Mobile : 이해하기 쉽게 풀어쓴',25000,'jquery.jpg','소스 하나로 데스크탑과 모바일까지 HTML5와 함께 사용한다. 초보자들도 ...');
commit;
```




<br><br><hr>

## DTO와 DBManager 생성

**ProductVO.java**
```java
package com.saeyan.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProductVO {
	private Integer code;
	private String name;
	private Integer price;
	private String description;
	private String pictureUrl;
	
	@Override
	public String toString() {
		return "ProductVO [code=" + code + ", name=" + name + ", price=" + price + ", description=" + description
				+ ", pictureUrl=" + pictureUrl + "]";
	}
	
}

```


**DBManger.java**
```java
package util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DBManger {

	
	
	public Connection getConnection() throws Exception {
		Connection conn = null;
		Context init = null;

		try {
			init = new InitialContext();
			DataSource ds = (DataSource) init.lookup("java:/comp/env/jdbc/OracleDB");
			conn = ds.getConnection();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return conn;
	}
	
	// select을 수행한 후 리소스 해제를 위한 메소드
	public static void close(Connection conn, Statement stmt, ResultSet rs) {
		try {
			rs.close();
			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// insert, update, delete 작업을 수행한 후 리소스 해제를 위한 메소드
	public static void close(Connection conn, Statement stmt) {
		try {
			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
```



<br><br><hr>

## DAO (DBManager 빠져나감)



**ProductDAO.java**
```java
package com.saeyan.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.saeyan.dto.ProductVO;

import util.DBManager;

public class ProductDAO {

	private static ProductDAO instance = new ProductDAO();
	
	private ProductDAO() {
		
	}
	
	public static ProductDAO getInstance() {
		return instance;
	}
	
	public List<ProductVO> selectAllProducts() {
		String sql = "select * from product order by code desc";
		List<ProductVO> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DBManager.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) { // 이동은 행(로우) 단위로
				ProductVO pVo = new ProductVO();
				pVo.setCode(rs.getInt("code"));
				pVo.setName(rs.getString("name"));
				pVo.setPrice(rs.getInt("price"));
				pVo.setPictureUrl(rs.getString("pictureUrl"));
				pVo.setDescription(rs.getString("description"));
				list.add(pVo);
			}// while 문 끝
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.close(conn, pstmt, rs);
		}
		
		return list;
	}
}
```



<br><br><hr>

## Controller 서블릿 생성


**ProductListServlet.java**
```java
package com.saeyan.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saeyan.dao.ProductDAO;
import com.saeyan.dto.ProductVO;

@WebServlet("/productList.do")
public class ProductListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		ProductDAO pDao = ProductDAO.getInstance();
		
		List<ProductVO> productList = pDao.selectAllProducts();
		request.setAttribute("productList", productList);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("product/productList.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

```



<br><br><hr>

## 리스트폼

**productList.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/shopping.css">
</head>
<body>
	<div id="wrap" align="center">
		<h1>상품 리스트 - 관리자 페이지</h1>
		<table>
			<tr>
				<td colspan="5" style="border: white; text-align: right;"><a href="productWrite.do">상품등록</a></td>
			</tr>
			<tr>
				<th>번호</th>
				<th>이름</th>
				<th>가격</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			<c:forEach var="product" items="${productList }">
				<tr class="record">
					<td>${product.code }</td>
					<td>${product.name }</td>
					<td>${product.price }</td>
					<td><a href="productUpdate.do?code=${product.code}">상품 수정</a></td>
					<td><a href="productDelete.do?code=${product.code}">상품 삭제</a></td>
				</tr>
			</c:forEach>
		</table>
	</div>
</body>
</html>
```


<br><br><hr>

### 리스트 table thead tbody 의 차이

![image](https://user-images.githubusercontent.com/84966961/128140713-4b0d0d49-44fc-46c4-b82c-cd0e1ae7a100.png)   

이렇게 thead로 묶어버리면 강제적으로 맨위로 올라간다. 따라서 결과가 다음과 같이 되버린다.    

![image](https://user-images.githubusercontent.com/84966961/128140779-db024ee8-99a3-41bd-a59b-7b5219faa6fe.png)    

하지만 다음과 같이 tbody thead로 크게 묶지 않으면 th로 강조하면서 맨위에 칸도 쓸 수 있다.   

![image](https://user-images.githubusercontent.com/84966961/128140899-fa9abf36-ea02-448f-b4ab-db38a090ec1e.png)   
![image](https://user-images.githubusercontent.com/84966961/128140922-6b95dd1f-7358-40f4-a7ae-cd566fd94cd1.png)    

















