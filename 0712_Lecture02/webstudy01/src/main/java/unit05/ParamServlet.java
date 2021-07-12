package unit05;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ParamServlet")
public class ParamServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		String id = request.getParameter("id"); // name이(파라미터가) id인 것의 데이터값을 String 상태로 받아온다.
		int age = Integer.parseInt(request.getParameter("age")); // name이(파라미터가) age인 것의 데이터값을 String 상태로 받아온다.

//		getParameter 양식
//		String getParameter(String name)

		// 화면 출력.
		out.print("<html><head><titie></title></head>");
		out.print("<body>");
		out.print("당신이 입력한 정보입니다.<br>");
		out.print("<br>id : " + id);
		out.print("<br>age : " + age);
		// 뒤로가기(history.go(-1)) a 태그 버튼 생성.
		out.print("<br><a href= 'javascript:history.go(-1)'>다시</a>");		
		out.print("</body></html>");

	}

}
