# Lecture22 상품 정보 쇼핑몰 & Mission & MVC2 Model

Key Word : Test11 Review, Mision review, MVC2 model, Factory Pattern

<hr>

## Test11 Review

1. 싱글턴 패턴
  - 기본 생성자를 숨겨야 싱글턴 패턴이 완성됨.
```
  private LoginDAO() {
	}
```

2. HTML로 alert를 보내기 위해서 out을 쓴다.
```
			out.println("<script> alert('로그인실패'); </script>");
```




<br><br><hr>

## Mission file download Review

 1. MovieDetail 서블릿
```java
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String code = request.getParameter("code");
		
		MovieDAO mDao = MovieDAO.getInstance();
		MovieVO mVo = mDao.selectMovie(Integer.parseInt(code));
		
		request.setAttribute("mVo", mVo);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("movie/movieDetail.jsp");
		dispatcher.forward(request, response);
	}
```

 2. 파일 다운 코드
```java
		// 폴더 위치
		String savePath = "upload";
		// 주소값 얻기 :  jsp getRealPath로 얻어와도 됨.
		ServletContext context = getServletContext();
		String sDownloadFilePath = context.getRealPath(savePath);
		String sFilePath = sDownloadFilePath + "\\" + fileName;
		byte b[] = new byte[4096];
		FileInputStream in = new FileInputStream(sFilePath);
		String sMimeType = getServletContext().getMimeType(sFilePath);
		System.out.println("sMimeType>>>" + sMimeType);
		
		
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
```


3. 웹서버 src 위치를 생각하자.




<br><br><hr>

## MVC 2 Model

![image](https://user-images.githubusercontent.com/84966961/128663958-ac54e0a0-1143-474c-8626-ba76030ee399.png)


MVC1을 사용하는 경우
 - 간단한 홈페이지 경우에는 빠르게 만들기 위해서 MVC1을 사용한다.
 - 시간을 단축할 수 있고 개발 방식이 쉽다.
 - 단점으로는 규모가 커질수록 관리가 어렵고 유지보수가 어렵다.


![image](https://user-images.githubusercontent.com/84966961/128665145-2ed7cc1b-d1a7-4bb2-b67f-3d125793058c.png)





<br><br><hr>

### FrontController vs ActionController

  - FrontController : 문지기 역할 업무를 분리하고 정해주는 역할.
  - ActionController : 실제 페이지에 필요한 기능을 실행하는 역할.
    - db 사용할 수도 있고 안할 수도 있음.
    - ActionController에 Model을 붙어 데이터를 처리함.
    - 단 하나의 기능을 가진다 -> 하나의 메소드를 구현하여 사용한다.


Factory Pattern 사용.
   - FrontController가 actionController를 생성 및 호출 해야 하지만 ActionFactory.java 를 거쳐서 생성하도록 만듬.

![image](https://user-images.githubusercontent.com/84966961/128668624-0eab429a-3879-4a4d-bf8d-4618a121978c.png)






<br><br><hr>

## FrontController

  - command를 받아 ActionFactory로 보내준다.
  - ActionFactory에서 실제 ActionContoller로 요청을 보낸다.

**BoardServlet.java**
```java
package com.saeyan.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/BoardServlet")
public class BoardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String command = request.getParameter("command");
		System.out.println("요청받은 명령어는 : "+ command);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
```





<br><br><hr>








