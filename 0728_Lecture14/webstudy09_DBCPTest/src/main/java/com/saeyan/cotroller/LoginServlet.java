package com.saeyan.cotroller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.saeyan.dao.MemberDAO;
import com.saeyan.dto.MemberVO;

@WebServlet("/login.do")
public class LoginServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String url = "member/login.jsp";
		
		HttpSession session = request.getSession();
		
		// 이미 로그인된 상태면 바로 메인으로 보냄.
		if(session.getAttribute("loginUser") != null) {
			url = "main.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		String url = "member/login.jsp";
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("pwd");
		PrintWriter out = response.getWriter();

		MemberDAO mDao = MemberDAO.getInstance();
		int result = mDao.userCheck(userid, pwd);

		if (result == 1) {
			MemberVO mVo = mDao.getMember(userid);
			// 세션 저장.
			HttpSession session = request.getSession();
			session.setAttribute("loginUser", mVo);
			request.setAttribute("message", "로그인 성공했습니다.");
			url = "main.jsp";
			out.print("로그인 성공했습니다.");
		} else if (result == 0) {
			request.setAttribute("message", "비밀번호 맞지 않습니다.");
			out.print("비밀번호 맞지 않습니다.");
		} else if (result == -1) {
			request.setAttribute("message", "존재하지 않는 회원입니다.");
			out.print("존재하지 않는 회원입니다.");
		}

		
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request, response);
		 

	}

}
