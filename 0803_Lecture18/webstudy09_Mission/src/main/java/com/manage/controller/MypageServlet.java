package com.manage.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.manage.dao.EmployeesDAO;
import com.manage.dto.EmployeesVO;


@WebServlet("/mypage.do")
public class MypageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		EmployeesVO emp = (EmployeesVO) session.getAttribute("loginUser");
		
		if(emp != null) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("mypage.jsp");
			dispatcher.forward(request, response);			
		}
		
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		EmployeesVO eVo = new EmployeesVO();
		EmployeesDAO eDao = EmployeesDAO.getInstance();
		
		eVo.setId(request.getParameter("id"));
		eVo.setPass(request.getParameter("pwd"));
		eVo.setName(request.getParameter("name"));
		eVo.setLev(request.getParameter("lev"));
		eVo.setGender(Integer.parseInt(request.getParameter("gender")));
		eVo.setPhone(request.getParameter("phone"));

		int result = eDao.updateMypage(eVo);
		
		if (result == 1) {
			HttpSession session = request.getSession();
			session.setAttribute("loginUser", eVo);
			request.setAttribute("message", "회원 정보가 수정되었습니다.");
		} else {
			request.setAttribute("message", "회원 정보 수정에 실패하였습니다.");
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("updatesuccess.jsp");
		dispatcher.forward(request, response);
	}

}
