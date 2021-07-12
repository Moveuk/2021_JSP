package unit06;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/InfoServlet")
public class InfoServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		String name = request.getParameter("name");
		String addr = request.getParameter("addr");

		// 화면 출력.
		out.print("<html><head><titie></title></head>");
		out.print("<body>");
		out.print("당신이 입력한 정보입니다.<br>");
		out.print("<br>이   름 : " + name);
		out.print("<br>주   소 : " + addr);
		out.print("<br><a href= 'javascript:history.go(-1)'>돌아가기</a>");		
		out.print("</body></html>");
		
		out.close();
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		
		doGet(request, response);
		// 똑같다면 post 내부에서 get을 불러서 사용할 수 있다.
		
//		response.setContentType("text/html;charset=UTF-8");
//		PrintWriter out = response.getWriter();
//		
//		String name = request.getParameter("name");
//		String addr = request.getParameter("addr");
//
//		// 화면 출력.
//		out.print("<html><head><titie></title></head>");
//		out.print("<body>");
//		out.print("당신이 입력한 정보입니다.<br>");
//		out.print("<br>이   름 : " + name);
//		out.print("<br>주   소 : " + addr);
//		out.print("<br><a href= 'javascript:history.go(-1)'>돌아가기</a>");		
//		out.print("</body></html>");
//		
//		out.close();
		
	}
}
