package com.ldu.controller.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ldu.controller.action.Action;
import com.ldu.dao.EmployeeDAO;
import com.ldu.dto.EmployeeVO;

public class EmployeeWriteAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("EmployeeWriteAction 호출됨");
		
		request.setCharacterEncoding("UTF-8");

		EmployeeVO eVo = new EmployeeVO();
		eVo.setId(request.getParameter("id"));
		eVo.setPass(request.getParameter("pass"));
		eVo.setName(request.getParameter("name"));
		eVo.setLev(request.getParameter("lev"));
		eVo.setGender(request.getParameter("gender"));
		eVo.setPhone(request.getParameter("phone"));

		EmployeeDAO eDao = EmployeeDAO.getInstance();
		eDao.insertEmployee(eVo);
		
		response.sendRedirect("empList");
	}

}
