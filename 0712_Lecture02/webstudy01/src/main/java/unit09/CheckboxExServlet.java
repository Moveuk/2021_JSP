package unit09;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/CheckboxExServlet")
public class CheckboxExServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		// item 이 0~ 아이템 갯수 만큼 배열 값으로 넘어온다.
		String items[] = request.getParameterValues("item");

		// 화면 출력.
		out.print("<html><head><titie></title><style> body {background-color:black; color:white;}"
				+ " img {border: yellow 2px solid;} div.img-wrapper {width=auto; display:block; margin: 0 auto;} </style></head>");
		
		
		out.print("<body>");
		out.print("당신이 입력한 정보입니다.<br><hr><br><div class='img-wrapper'>");
		if (items == null) {
			out.print("선택항목이 없습니다.");
		} else {
			for (String item : items) {
				out.print("<img alt='"+item+"' src='img/"+item+".jpg'>");
			}
		}
		out.print("</div><br>");
		out.print("<br><a href= 'javascript:history.go(-1)'>돌아가기</a>");
		out.print("</body></html>");

		out.close();
	}

}
