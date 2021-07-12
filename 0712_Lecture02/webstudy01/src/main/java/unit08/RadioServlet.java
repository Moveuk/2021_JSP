package unit08;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RadioServlet")
public class RadioServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		String gender = request.getParameter("gender");
		String chk_mail = request.getParameter("chk_mail");
		String content = request.getParameter("content");

		// 화면 출력.
		out.print("<html><head><titie></title></head>");
		out.print("<body>");
		out.print("당신이 입력한 정보입니다.<br><hr>");
		out.print("<br>성   별 : <b>" + gender);
		out.print("</b><br>메일정보 수신 여부 : <b>" + chk_mail);
		out.print("</b><br>가입 인사 : <br><pre><b>" + content);
		out.print("</b></pre><br><a href= 'javascript:history.go(-1)'>돌아가기</a>");		
		out.print("</body></html>");
		
		out.close();
	}

}
