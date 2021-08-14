package net.board.action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import net.board.db.BoardBean;
import net.board.db.BoardDAO;

public class BoardAddAction implements Action {
	private static BoardAddAction instance = new BoardAddAction();
	
	private BoardAddAction() {
	}
	
	public static BoardAddAction getInstance() {
		return instance;
	}
	
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward af = new ActionForward();
		af.setRedirect(true);
		af.setPath("BoardList.bo");
		
		MultipartRequest multi = (MultipartRequest) request.getAttribute("multi");
//		ServletContext context = (ServletContext) request.getAttribute("context");
//		String path = context.getRealPath("upload");
//		String encType = "UTF-8";
//		int sizeLimit = 20 * 1024 * 1024;
//		
//		MultipartRequest multi = new MultipartRequest(request, path, sizeLimit, encType, new DefaultFileRenamePolicy());
//		
		BoardDAO boardDAO = new BoardDAO();
		
		BoardBean boardBean = new BoardBean();
		
		System.out.println("자바빈 객체 생성 성공");
		System.out.println(multi.getParameter("pass"));
		boardBean.setBoard_name(multi.getParameter("name"));
		boardBean.setBoard_pass(multi.getParameter("pass"));
		boardBean.setBoard_subject(multi.getParameter("subject"));
		boardBean.setBoard_content(multi.getParameter("content"));
		boardBean.setBoard_file(multi.getParameter("file"));
		
		boardDAO.boardInsert(boardBean);
		
		return af;
	}

}
