package com.ldu.controller.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ldu.dao.EmployeeDAO;
import com.ldu.dto.EmployeeVO;

public class EmployeeListAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("EmployeeListAction 호출됨");

		String url = "emp/empList.jsp";
		
		EmployeeDAO eDao = EmployeeDAO.getInstance();
		List<EmployeeVO> empList = eDao.selectAllEmployees();
		
		if (empList == null) {
			System.out.println("EmployeeListAction.execute 값 : null");
		} else {
			request.setAttribute("empList", empList);
			System.out.println(empList);
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/"+url);
		dispatcher.forward(request, response);
	}

}
