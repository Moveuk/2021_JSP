package unit01;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Hello")
public class HelloServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// 우리가 이런 타입을 구성하고 사용할 것이라는 것을 명시적으로 알려준다.
		response.setContentType("text/html;charset=UTF-8");
		// html 형태로 웹브라우저를 실행하겠다.
		// charset=UTF-8를 통해 웹브라우저가 한글을 인식하여 깨짐을 방지하게 해준다.
		
		PrintWriter out = response.getWriter();
		out.print("<html><head><titie></title></head>");
		out.print("<body>");
		out.print("Hello Servelet 안녕하세요");
		out.print("</body></html>");
		
	}

}
