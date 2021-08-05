# Lecture20 상품 정보 쇼핑몰 & Mission

Key Word : 상품 등록(Create), 상품 수정(Read & Update) 상품 삭제(Read & Delete), action 속성 생략, sequence의 cache 및 non cache 모드, Mission  

<hr>

## 오늘 생각해봐야 할점들

### 1. form 태그에 action 속성이 생략되었을 경우

 현재 코드를 보면 jsp와 js 모두 post 방식으로 request를 던지지만 action 속성에 대한 내용은 존재하지 않는다.   
 
> productList.jsp -> ProductWriteServlet.java -> productWrite.jsp
 
위의 경로로 페이지가 흘러왔는데 만약 action 속성을 생략한다면 이전에 호출한 적이 있는 곳으로 가서 처리를 하게 된다.   

 이 코드에서는 productList.jsp 에서 마지막으로 a 태그를 통해 href 속성으로 넘어 왔으므로 ProductWriteServlet.java에서 처리하게 된다.   


### 2. sequence의 cache 및 non cache 모드

 수업 진행중 문제였던 점. sequence 로 code PK 로서 넣었는데 중간중간에 띄엄띄엄 되는 현상을 발견함. -> 구글링 실시.
     
 ![image](https://user-images.githubusercontent.com/84966961/128356725-3efc39f6-6dc7-4972-b268-45bb0a669c4a.png)     
    
 검색해보니 sequence는 실행될 때 미리 어느정도의 번호를 메모리에 cache하여 사용하는데 껐다가 키게 되면 메모리에 담겨져 있던 설정한 번호들이 함께 증발하게 된다. 그러면서 위와 같이 중간에 비는 번호들이 생기게 되는 것이다. 만약 1부터 순차적으로 올라가야 한다면 non cache 속성을 바꾸어서 사용하거나 다른 방식을 사용해야 한다.     
 
 다음은 sql의 cache 속성 사진이다. 나는 20으로 설정이 되어 있기 때문에 20씩 사라진다

![image](https://user-images.githubusercontent.com/84966961/128357126-444d2a98-47e5-4b08-82e3-36ff70382fd3.png)




<hr>

## 상품 등록

**ProductWriteServlet.java**
```java
package com.saeyan.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.saeyan.dao.ProductDAO;
import com.saeyan.dto.ProductVO;

@WebServlet("/productWrite.do")
public class ProductWriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		RequestDispatcher dispatcher = request.getRequestDispatcher("product/productWrite.jsp");
		dispatcher.forward(request, response);
	}
}
```



**상품 등록 화면**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/shopping.css">
<script type="test/javascript" src="script/product.js"></script>
</head>
<body>
	<div id="wrap" align="center">
		<h1>상품 등록 - 관리자 페이지</h1>
		<form method="post" enctype="multipart/form-data" name="frm">
			<table>
				<tr>
					<th> 상 품 명 </th>
					<td><input type="text" name="name" size="80" /></td>
				</tr>
				<tr>
					<th> 가 &nbsp; 격 </th>
					<td><input type="text" name="price"/> 원</td>
				</tr>
				<tr>
					<th> 사 &nbsp; 진 </th>
					<td><input type="file" name="pictureUrl" /><br>(주의사항 : 이미지를 변경하고자 할때만 선택하시오)</td>
				</tr>
				<tr>
					<th> 설 &nbsp; 명 </th>
					<td><textarea cols="80" rows="10" name="description" size=""></textarea></td>
				</tr>
			</table>
			<br>
			<input type="submit" value="등록" onclick="return productCheck()">
			<input type="reset" value="다시작성">
			<input type="button" value="목록" onclick="location.href='productList.do'">
		</form>
	</div>
</body>
</html>
```


**product.js**
```js
function productCheck() {
	if (document.frm.name.value.length == 0) {
		alert("상품명을 넣어주세요.");
		document.frm.name.focus();
		return false;
	}
	if (document.frm.price.value.length == 0) {
		alert("가격을 넣어주세요.");
		document.frm.price.focus();
		return false;
	}
	if (isNaN(document.frm.price.value)) {
		alert("가격은 숫자이어야만 합니다.");
		document.frm.price.focus();
		return false;
	}
	return true;
}
```


<br><br><hr>

## DAO : insert 추가


**ProductDAO.java**
```java
// 생략
	// Create r u d
	public void insertProduct(ProductVO pVo) {
		String sql = "insert into product values(product_seq.nextval, ?, ?, ?, ?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = DBManager.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pVo.getName());
			pstmt.setInt(2, pVo.getPrice());
			pstmt.setString(3, pVo.getPictureUrl());
			pstmt.setString(4, pVo.getDescription());
			pstmt.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.close(conn, pstmt);
		}
	
	}
```


<br><br><hr>

## 서블릿 post 처리


**ProductWriteServlet**
```java
// 생략
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
	// 파일 업로드
		// 파일 업로드 속성 설정
		ServletContext context = getServletContext();
		String path = context.getRealPath("upload");
		String encType = "UTF-8";
		int sizeLimit = 20 * 1024 * 1024;
		
		// 파일 업로드 호출
		MultipartRequest multi = new MultipartRequest(request, path, sizeLimit, encType, new DefaultFileRenamePolicy());
		
	// DB 연동
		// DB에 들어갈 속성 받기
		String name = multi.getParameter("name");
		int price = Integer.parseInt(multi.getParameter("price"));
		String description = multi.getParameter("description");
		String pictureUrl = multi.getFilesystemName("pictureUrl");	// 서버에 저장한 파일 이름
		
		// pVo 객체 생성 및 멤버 변수 초기화
		ProductVO pVo = new ProductVO();
		pVo.setName(name);
		pVo.setPrice(price);
		pVo.setDescription(description);
		pVo.setPictureUrl(pictureUrl);
		
		// DB Insert
		ProductDAO pDao = ProductDAO.getInstance();	// static 하므로 바로 불러옴
		pDao.insertProduct(pVo);					// DB 입력
		
		response.sendRedirect("productList.do");
	}
```



<br><br><hr>

## DAO : select - Read 추가


**ProductDAO.java**
```java
// 중략
	// c Read u d 
	public ProductVO selectProductByCode(String code) {
		String sql = "select * from product where code = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ProductVO pVo = null;
		
		try {
			conn = DBManager.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, code);
			rs = pstmt.executeQuery();
			if (rs.next()) { // 이동은 행(로우) 단위로
				pVo = new ProductVO();
				pVo.setCode(rs.getInt("code"));
				pVo.setName(rs.getString("name"));
				pVo.setPrice(rs.getInt("price"));
				pVo.setPictureUrl(rs.getString("pictureUrl"));
				pVo.setDescription(rs.getString("description"));
			}// if 문 끝
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.close(conn, pstmt, rs);
		}
		
		return pVo;
	}
```

<br><br><hr>

## 상품 수정 

**ProductUpdateServlet.java**
```java
package com.saeyan.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.saeyan.dao.ProductDAO;
import com.saeyan.dto.ProductVO;

@WebServlet("/productUpdate.do")
public class ProductUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	      String code = request.getParameter("code");
	      
	      ProductDAO pDao = ProductDAO.getInstance();
	      ProductVO pVo = pDao.selectProductByCode(code);
	      
	      request.setAttribute("product", pVo);
	      
	      RequestDispatcher dispatcher = request.getRequestDispatcher("product/productUpdate.jsp");
	      dispatcher.forward(request, response);

	}
}
```


**productUpdate.jsp**
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/shopping.css">
<script type="text/javascript" src="script/projuct.js"></script>
</head>
<body>
	<div id="wrap" align="center">
		<h1>상품 수정 - 관리자 페이지</h1>
		<form method="post" enctype="multipart/form-data" name="frm">
			<input type="hidden" name="code" value="${product.code }">
			<input type="hidden" name="nonmakeImg" value="${product.pictureUrl }">
			<table>
				<tr>
					<td>
					<c:choose>
							<c:when test="${empty product.pictureUrl }">
								<img src="upload/noimage.gif">
							</c:when>
							<c:otherwise>
								<img src="upload/${product.pictureUrl }">
							</c:otherwise>
						</c:choose>
					</td>
					<td>
						<table>
							<tr>
								<th>상 품 명</th>
								<td><input type="text" name="name" value="${product.name }" size="80" /></td>
							</tr>
							<tr>
								<th>가 &nbsp; 격</th>
								<td><input type="text" name="price" value="${product.price }"  /> 원</td>
							</tr>
							<tr>
								<th>사 &nbsp; 진</th>
								<td><input type="file" name="pictureUrl" /><br>(주의사항 : 이미지를 변경하고자 할때만 선택하시오)</td>
							</tr>
							<tr>
								<th>설 &nbsp; 명</th>
								<td><textarea cols="90" rows="10" name="description" size="">${product.description }</textarea></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<br> <input type="submit" value="수정" onclick="return productCheck()"> <input type="reset" value="다시작성"> <input type="button" value="목록" onclick="location.href='productList.do'">
		</form>
	</div>
</body>
</html>
```


<br><br><hr>

## DAO : 상품 수정  Update


****
```java
//생략
  // c r Update d
	public void updateProduct(ProductVO pVo) {
		String sql = "update product set name=?, price=?, pictureurl=?, description=? where code = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = DBManager.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pVo.getName());
			pstmt.setInt(2, pVo.getPrice());
			pstmt.setString(3, pVo.getPictureUrl());
			pstmt.setString(4, pVo.getDescription());
			pstmt.setInt(5, pVo.getCode());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.close(conn, pstmt);
		}
	}
```



<br><br><hr>

## 상품 수정 서블릿 마무리

**ProductUpdateServlet.java**
```java
// 생략
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
	// 파일 업로드
		// 파일 업로드 속성 설정
		ServletContext context = getServletContext();
		String path = context.getRealPath("upload");
		System.out.println(path);
		String encType = "UTF-8";
		int sizeLimit = 20 * 1024 * 1024;
		
		// 파일 업로드 호출
		MultipartRequest multi = new MultipartRequest(request, path, sizeLimit, encType, new DefaultFileRenamePolicy());
		
	// DB 연동
		// DB에 들어갈 속성 받기
		String code = multi.getParameter("code");
		String name = multi.getParameter("name");
		int price = Integer.parseInt(multi.getParameter("price"));
		String description = multi.getParameter("description");
		String pictureUrl = multi.getFilesystemName("pictureUrl");	// 서버에 저장한 파일 이름
		
		if (pictureUrl == null) {
			pictureUrl = multi.getParameter("nonmakeimg");
		}
		
		// pVo 객체 생성 및 멤버 변수 초기화
		ProductVO pVo = new ProductVO();
		pVo.setCode(Integer.parseInt(code));
		pVo.setName(name);
		pVo.setPrice(price);
		pVo.setDescription(description);
		pVo.setPictureUrl(pictureUrl);
		
		// DB Insert
		ProductDAO pDao = ProductDAO.getInstance();	// static 하므로 바로 불러옴
		pDao.updateProduct(pVo);					// DB 입력
		
		response.sendRedirect("productList.do");
	}
```


<br><br><hr>

## 상품 삭제 - Delete 기능

**ProductDeleteServlet**
```java
package com.saeyan.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saeyan.dao.ProductDAO;
import com.saeyan.dto.ProductVO;

@WebServlet("/productDelete.do")
public class ProductDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String code = request.getParameter("code");
		
		ProductDAO pDao = ProductDAO.getInstance();
		ProductVO pVo = pDao.selectProductByCode(code);
		
		request.setAttribute("product", pVo);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("product/productDelete.jsp");
		dispatcher.forward(request, response);
}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String code = request.getParameter("code");
		
		ProductDAO pDao = ProductDAO.getInstance();
		pDao.deleteProduct(code);
		
		response.sendRedirect("productList.do");
	}

}
```

**ProductDAO.java**
```java
// 생략
	 // c r u Delete
	public void deleteProduct(String code) {
		String sql = "delete product where code=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DBManager.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, code);
			pstmt.executeUpdate();
					
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.close(conn, pstmt);
		}
		
	}
```

**결과 화면**     
![image](https://user-images.githubusercontent.com/84966961/128356426-96e92baf-bb51-4a5c-956c-86dacd992658.png)    

NULL 이므로 noimage.gif를 강제로 넣어준다.   

![image](https://user-images.githubusercontent.com/84966961/128357228-1487b1cd-d41f-413f-bda9-0862ca5edc41.png)   

![image](https://user-images.githubusercontent.com/84966961/128357288-c1d3f89c-1f60-4a93-96ed-361787b89ecb.png)    

![image](https://user-images.githubusercontent.com/84966961/128357624-020d93f4-1dae-4d7a-8764-ff980253da40.png)    

![image](https://user-images.githubusercontent.com/84966961/128357655-7e6c012a-ba57-454f-ab46-1fdf29a876ce.png)    


<br><br><hr>

# Mission - Movie

## 영화 관리 프로그램을 위한 프로젝트 및 환경 설정.

1. 프로젝트 생성
2. 각종 라이브러리 구성
3. 구성 계획
4. db 설계 및 작성

```sql
create table movie(
    code number(4) primary key,
    title varchar2(50),
    price number(10),
    director varchar2(20),
    actor varchar2(20),
    poster varchar2(100),
    synopsis varchar2(3000)
);

create SEQUENCE movie_seq 
    start with 1
    increment by 1;

INSERT INTO movie VALUES (movie_seq.nextval, '베를린', 10000, '류승완', '하정우', 'movie1.jpg', '거대한 국제적 음모가 숨겨진 운명의 도시 베를린');
INSERT INTO movie VALUES (movie_seq.nextval, '박수건달', 10000, '조진규', '박신양, 엄지원', 'movie2.jpg', '건달로 사느냐, 무당으로 사느냐 그것이 문제로다.');
INSERT INTO movie VALUES (movie_seq.nextval, '레미제라블', 10000, '톰 후퍼', '휴 잭맨', 'movie3.jpg', '빵 한 조각을 훔친 죄로 19년의 감옥살이를 한 장발장');
INSERT INTO movie VALUES (movie_seq.nextval, '7번방의 선물', 9000, '이환경', '류승룡, 갈소원', 'movie4.jpg', '최악의 흉악범들이 모인 교도소 7번방에 이상한 일이 벌어졌다.');

select * from movie;

select * from movie order by code desc;
```


![image](https://user-images.githubusercontent.com/84966961/128359222-9fc0bfac-1837-403f-942f-c87e553891ce.png)   

![image](https://user-images.githubusercontent.com/84966961/128359232-ac0c28ca-0789-423c-92ba-37a2a3d3db1d.png)   



<br><br><hr>

## 영화 정보 리스트

![image](https://user-images.githubusercontent.com/84966961/128360482-552a79e8-30b7-4e2c-b014-cb8bd94e52e7.png)


<br><br><hr>

## 영화 정보 등록

![image](https://user-images.githubusercontent.com/84966961/128369306-60cffde7-6287-4b2c-9f3f-370bea497614.png)   

![image](https://user-images.githubusercontent.com/84966961/128369273-699310b5-16c8-41f3-af87-101ee23047c9.png)    

