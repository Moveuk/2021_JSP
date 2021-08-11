package com.ldu.controller.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ldu.dao.EmployeeDAO;
import com.ldu.dto.EmployeeVO;

public class EmployeeDeleteAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("EmployeeDeleteAction 호출됨");
		
		System.out.println("넘어오는 id 값 : "+request.getParameter("id"));
		System.out.println("넘어오는 lev 값 : "+request.getParameter("lev"));
		System.out.println("넘어오는 gender 값 : "+request.getParameter("gender"));
		

		EmployeeDAO eDao = EmployeeDAO.getInstance();
		eDao.deleteEmployeeByID(request.getParameter("id"));
		
		response.sendRedirect("empList");
	}

}
