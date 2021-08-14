package net.board.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.board.db.BoardBean;
import net.board.db.BoardDAO;

public class BoardListAction implements Action {
	private static BoardListAction instance = new BoardListAction();
	
	private BoardListAction() {
	}
	
	public static BoardListAction getInstance() {
		return instance;
	}
	
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward af = new ActionForward();
		
		af.setRedirect(false);
		af.setPath("board/qna_board_list.jsp");
		
		BoardDAO boardDAO = new BoardDAO();
		int articleCount = boardDAO.getListCount();
		System.out.println("글의 갯수 : "+articleCount);
		request.setAttribute("articleCount",articleCount);
		

		ArrayList<BoardBean> list = (ArrayList<BoardBean>) boardDAO.getBoardList();
		
		request.setAttribute("list", list);
		
		return af;
	}

}
