package net.board.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.StringTokenizer;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet(urlPatterns = "*.bo")
public class BoardFrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("BoardFrontController 호출됨.");
		
		request.setCharacterEncoding("UTF-8");
		// content 타입 잘못입력시 크롬브라우저 상에서 다운로드가 되버림.
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		// 주소값 받아서 쪼갬
		String requestUri = request.getRequestURI();
		System.out.println(requestUri);
//		String requestUri = "localhost:8181/webstudy12_Test12/BoardFrontController";
		StringTokenizer requestUriTokens = new StringTokenizer(requestUri, "/");
		
		// URL 정리
		String projectName = null;
		String actionMethodName = null;
		
		// URL 분리
		if (requestUriTokens.countTokens() >= 2) {
			projectName = requestUriTokens.nextToken();
			actionMethodName = requestUriTokens.nextToken();
			System.out.println("요청받은 페이지 : "+actionMethodName);
		} else {
			out.println("잘못된 페이지 입력입니다.");
		}
		
		String actionName = actionMethodName.replace(".bo", "");
		
		ActionForward af = null;

		try {
		if (actionName.equals("BoardList")) {
			Action action = BoardListAction.getInstance();
				af = action.execute(request, response);
		} else if (actionName.equals("BoardWrite")) {
			Action action = BoardWriteAction.getInstance();
				af = action.execute(request, response);
		} else if (actionName.equals("BoardAddAction")) {
			
			ServletContext context = getServletContext();
			String path = context.getRealPath("upload");
			String encType = "UTF-8";
			int sizeLimit = 20 * 1024 * 1024;
			
			MultipartRequest multi = new MultipartRequest(request, path, sizeLimit, encType, new DefaultFileRenamePolicy());
			
			request.setAttribute("context", context);
			request.setAttribute("multi", multi);
			
			Action action = BoardAddAction.getInstance();
			af = action.execute(request, response);
		} else if (actionName.equals("BoardDetail")) {
			Action action = BoardDetailAction.getInstance();
			af = action.execute(request, response);
		} else {
			out.println(actionName + "은 잘못된 페이지 입력입니다.");
		}} catch (Exception e) {
			e.printStackTrace();
		}
		
		if (af.isRedirect()) {
			response.sendRedirect(af.getPath());
		} else {
			RequestDispatcher dispatcher = request.getRequestDispatcher(af.getPath());
			dispatcher.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		doGet(request, response);
	}

}
