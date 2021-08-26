package com.nonage.controller.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nonage.dao.ProductDAO;
import com.nonage.dto.ProductVO;

public class ProductDetailAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String url = "product/productDetail.jsp";
		
		String pseq = request.getParameter("pseq");
		
		
		ProductDAO pDao = ProductDAO.getInstance();
		ProductVO pVo = pDao.getProduct(pseq);
		
		request.setAttribute("productVO", pVo);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request, response);
	}

}
