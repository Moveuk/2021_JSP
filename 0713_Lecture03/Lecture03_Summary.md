# Lecture02 웹 서버와 세션
Key Word : 서버, 세션

<hr>
 
## 세션 (교재 242p 세션 개념 설명)
   
 세션 객체를 이용하여 도메인을 통해 실제 서버에 접속하여 정보를 처리할 수 있다.







<br><br>
<hr>
 
### 세션 객체 저장

**세션 **
```java
package unit12;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/SetNameServlet")
public class SetNameServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		HttpSession session = request.getSession();
		session.setAttribute("name", "오정원");
		out.println("<h1>이름 저장 성공</h1>");
		
		
	}

}
```

**결과 화면**
![image](https://user-images.githubusercontent.com/84966961/125394523-c27db900-e3e4-11eb-8cee-ba4a80ed43ae.png)



<br><br>
<hr>
 
### 세션 객체 불러오기



**세션 불러오기**
```java
@WebServlet("/SetNameServlet")
public class GetNameServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		HttpSession session = request.getSession();
		String name = (String) session.getAttribute("name");
		out.println("<h1>이름 불러오기 성공</h1>");
	}
}
```



















































































