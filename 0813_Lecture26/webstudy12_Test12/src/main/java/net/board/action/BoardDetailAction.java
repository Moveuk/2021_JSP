package net.board.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.board.db.BoardBean;
import net.board.db.BoardDAO;

public class BoardDetailAction implements Action {
		private static BoardDetailAction instance = new BoardDetailAction();
		
		private BoardDetailAction() {
		}
		
		public static BoardDetailAction getInstance() {
			return instance;
		}
		
		@Override
		public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
			ActionForward af = new ActionForward();
			
			af.setRedirect(false);
			af.setPath("board/qna_board_view.jsp");
			
			int num = Integer.parseInt(request.getParameter("num"));
			
			BoardDAO boardDAO = new BoardDAO();
			boardDAO.setReadCountUpdate(num);
			BoardBean article = boardDAO.getDetail(num);
			
			request.setAttribute("article",article);
			
			return af;
		}

	}

