package com.ldu.controller.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ldu.dao.EmployeeDAO;
import com.ldu.dto.EmployeeVO;

public class EmployeeUpdateFormAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("EmployeeUpdateFormAction 호출됨");
		
		String url = "emp/empUpdate.jsp";
		
		String id = request.getParameter("id");
		
		EmployeeDAO eDao = EmployeeDAO.getInstance();
		EmployeeVO eVo = eDao.selectEmployeeByID(id);
		
		request.setAttribute("eVo", eVo);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/"+url);
		dispatcher.forward(request, response);
	}

}
