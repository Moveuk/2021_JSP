package unit11_quiz;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/QuizServlet")
public class QuizServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html; charset='UTF-8';");
		PrintWriter out = response.getWriter();
		
		String name = request.getParameter("name");
		String psno1 = request.getParameter("psno1");
		String psno2 = request.getParameter("psno2");
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String pass_chk = request.getParameter("pass_chk");
		String email_id = request.getParameter("email_id");
		String email_site = request.getParameter("email_site");
		String email_select = request.getParameter("email_select");
		String post = request.getParameter("post");
		String addr1 = request.getParameter("addr1");
		String addr2 = request.getParameter("addr2");
		String mobile = request.getParameter("mobile");
		String job = request.getParameter("job");
		String interests[] = request.getParameterValues("interest");
		
		
		
		
		out.print("<html><head><title></title></head>");
		out.print("<body>");
		out.print("이름 : "+name + "<br>");
		out.print("주민들록번호 : "+ psno1 +" - "+ psno2 +"<br>");
		out.print("아이디 : "+id+"<br>");
		out.print("비밀번호 : "+password+"<br>");
		out.print("이메일 : "+email_id+"@"+email_site+"<br>");
		out.print("우편번호 : "+post+"<br>");
		out.print("주소 : "+addr1+"  "+ addr2 +"<br>");
		out.print("핸드폰번호 : "+mobile+"<br>");
		out.print("직업 : "+job+"<br>");
		if (interests == null) {		
			out.print("관심 분야 없음");
		} else {
			out.print("관심분야 : ");;
			for (String interest : interests) {
				out.print(interest+ " ");
			}			
		}
		out.print("<br>");
		out.print("<br><a href= 'javascript:history.go(-1)'>돌아가기</a>");
		out.print("</body></html>");

		out.close();
	}

}
