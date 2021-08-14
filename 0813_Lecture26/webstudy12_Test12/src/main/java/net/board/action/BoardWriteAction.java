package net.board.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BoardWriteAction implements Action {
	private static BoardWriteAction instance = new BoardWriteAction();
	
	private BoardWriteAction() {
	}
	
	public static BoardWriteAction getInstance() {
		return instance;
	}
	
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward af = new ActionForward();
		
		af.setRedirect(false);
		af.setPath("board/qna_board_write.jsp");
		
		return af;
	}

}
