package com.manage.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.manage.dao.EmployeesDAO;
import com.manage.dto.EmployeesVO;

@WebServlet("/list.do")
public class ListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		EmployeesVO eVo= (EmployeesVO)session.getAttribute("loginUser");
		int result = (Integer)session.getAttribute("result");
		
		if(eVo != null && result == 2 && session!=null) {
			EmployeesDAO eDao = EmployeesDAO.getInstance();
			ArrayList<EmployeesVO> members = eDao.getEmpList();
			request.setAttribute("members", members);
			request.setAttribute("message", "사원 정보 조회 성공");
			RequestDispatcher rd = request.getRequestDispatcher("list.jsp");
			rd.forward(request, response);
		}else {
			response.sendRedirect("login.do");
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
