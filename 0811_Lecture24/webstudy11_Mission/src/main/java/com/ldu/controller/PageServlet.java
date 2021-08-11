package com.ldu.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.StringTokenizer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/adm/*")
public class PageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("PageServlet 호출됨.");
		
		request.setCharacterEncoding("UTF-8");
		// content 타입 잘못입력시 크롬브라우저 상에서 다운로드가 되버림.
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		// 주소값 받아서 쪼갬
		String requestUri = request.getRequestURI();
		System.out.println(requestUri);
//		String requestUri = "localhost:8181/webstudy11_Mission/adm/emp/empList";
		StringTokenizer requestUriTokens = new StringTokenizer(requestUri, "/");
		
		// URL 정리
		String projectName = null;
		String requestLev = null;
		String controllerName = null;
		String actionMethodName = null;
		
		// URL 분리
		if (requestUriTokens.countTokens() >= 4) {
			projectName = requestUriTokens.nextToken();
			requestLev = requestUriTokens.nextToken();
			controllerName = requestUriTokens.nextToken();
			actionMethodName = requestUriTokens.nextToken();
		} else {
			out.println("잘못된 페이지 입력입니다.");
		}
		
		// 토큰 테스트
//		while (requestUriTokens.hasMoreTokens()) {
//			System.out.println(requestUriTokens.nextToken());			
//		}
//		System.out.println(requestUriTokens.countTokens());
//		
		System.out.println("actionMethodName : "+actionMethodName);
		
		ActionFactory af = ActionFactory.getInstance();
		
		if (actionMethodName != null) {
			af.getAction(actionMethodName).execute(request, response);
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
