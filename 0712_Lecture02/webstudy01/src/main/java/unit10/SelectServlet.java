package unit10;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SelectServlet")
public class SelectServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		// item 이 0~ 아이템 갯수 만큼 배열 값으로 넘어온다.
		String job = request.getParameter("job");
		String interests[] = request.getParameterValues("interest");
		
		out.print("<html><head><title></title></head>");
		out.print("<body>");
		out.print("<h1>당신의 직업은 : </h1>"+job);
		out.print("<br>");
		out.print("<br>");
		
		if (interests == null) {		
			out.print("관심 분야 없음");
		} else {
			out.print("<h1>당신의 관심 분야는 : </h1>");
			
			for (String interest : interests) {
				out.print(interest+ "  ");
			}			
		}
		out.print("<br>");
		out.print("<br><a href= 'javascript:history.go(-1)'>돌아가기</a>");
		out.print("</body></html>");

		out.close();
	}
		
}
