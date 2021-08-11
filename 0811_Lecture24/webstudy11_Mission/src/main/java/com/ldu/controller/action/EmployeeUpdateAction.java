package com.ldu.controller.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ldu.dao.EmployeeDAO;
import com.ldu.dto.EmployeeVO;

public class EmployeeUpdateAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("EmployeeUpdateAction 호출됨");
		
		// 테스트
//		System.out.println("넘어오는 id 값 : "+request.getParameter("id"));
//		System.out.println("넘어오는 lev 값 : "+request.getParameter("lev"));
//		System.out.println("넘어오는 gender 값 : "+request.getParameter("gender"));
		
		EmployeeVO eVo = new EmployeeVO();
		eVo.setId(request.getParameter("id"));
		eVo.setPass(request.getParameter("pass"));
		eVo.setName(request.getParameter("name"));
		eVo.setLev(request.getParameter("lev"));
		eVo.setGender(request.getParameter("gender"));
		eVo.setPhone(request.getParameter("phone"));

		EmployeeDAO eDao = EmployeeDAO.getInstance();
		eDao.updateEmployee(eVo);
		
		response.sendRedirect("empList");
	}

}
