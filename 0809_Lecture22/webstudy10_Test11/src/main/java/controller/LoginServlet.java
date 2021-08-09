package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.LoginService;
import vo.MemberVO;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();

		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String url = "loginForm.html";

		// 로그인 후 mVo 객체 반환
		LoginService ls = new LoginService(id, password);

//		// Master
//		MemberVO mVo = ls.getLoginMemberMaster(id, password);
//		if (mVo != null) {
//			HttpSession session = request.getSession();
//			session.setAttribute("id", id);
//			url = "index.jsp";
//			response.sendRedirect(url);
//			
//		} else {
//			out.println("<script> alert('로그인실패'); history.back(); </script>");
//		}

		// 아이디 비밀번호 같으면
		if (ls.result) {
			// 로그인 성공시 세션 id 저장 후 이동 url 변경
			HttpSession session = request.getSession();
			session.setAttribute("id", id);
			url = "index.jsp";
		} else {
			out.println("<script> alert('로그인실패'); history.back(); </script>");
		}

		// 이동.
//		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
//		dispatcher.forward(request, response);
	}

}
