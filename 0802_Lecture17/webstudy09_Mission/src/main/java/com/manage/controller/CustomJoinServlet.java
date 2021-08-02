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

@WebServlet("/custom.do")
public class CustomJoinServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		EmployeesVO emp = (EmployeesVO)session.getAttribute("loginUser");
		int result = (Integer)session.getAttribute("result");
		if(emp != null && result == 2 && session!=null) {
			RequestDispatcher rd = request.getRequestDispatcher("customjoin.jsp");
			rd.forward(request, response);
		}else {
			response.sendRedirect("login.do");
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		String name = request.getParameter("name");
		String lev = request.getParameter("lev");
		String gender = request.getParameter("gender");
		String phone = request.getParameter("phone");
		
		
		EmployeesVO eVo = new EmployeesVO();
		eVo.setId(id);
		eVo.setPass(pwd);
		eVo.setName(name);
		eVo.setLev(lev);
		eVo.setGender(Integer.parseInt(gender));
		eVo.setPhone(phone);
		EmployeesDAO eDAO = EmployeesDAO.getInstance();
		eDAO.insertMember(eVo);
		
		request.setAttribute("message","회원 등록이  성공했습니다.");
		request.setAttribute("member", eVo);
		RequestDispatcher dispatcher = request.getRequestDispatcher("joinsuccess.jsp");
		dispatcher.forward(request, response);
	}

}
