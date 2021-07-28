package com.saeyan.cotroller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saeyan.dao.MemberDAO;


@WebServlet("/idCheck.do")
public class IdCheckServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 중복확인 위한 id값 param 받음
		String userid = request.getParameter("userid");
		
		// MemberDAO를 통해서 객체 구현 결과값 받음.
		MemberDAO mDao = MemberDAO.getInstance();
		int result = mDao.comfirmID(userid);
		
		// request에 값 저장.
		request.setAttribute("userid", userid);
		request.setAttribute("result", result);
		
		// 같이 보내버림.
		RequestDispatcher dispatcher = request.getRequestDispatcher("member/idcheck.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
