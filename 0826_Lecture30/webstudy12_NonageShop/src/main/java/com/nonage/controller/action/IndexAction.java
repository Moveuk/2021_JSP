package com.nonage.controller.action;

import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nonage.dao.ProductDAO;
import com.nonage.dto.ProductVO;

public class IndexAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String url = "/index.jsp";
		
		ProductDAO pDao = ProductDAO.getInstance();
		ArrayList<ProductVO> newProductList = pDao.listNewProduct();
		ArrayList<ProductVO> bestProductList = pDao.listBestProduct();
		
		request.setAttribute("newProductList", newProductList);
		request.setAttribute("bestProductList", bestProductList);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request, response);
	}

}
