package com.saeyan.controller.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saeyan.dao.BoardDAO;
import com.saeyan.dto.BoardVO;

public class BoardListAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// http://localhost:8181/webstudy11_MVC2/BoardServlet?command=board_list
		System.out.println("BoardListAction 시작");
		String url = "board/boradList.jsp";
		
		BoardDAO bDao = BoardDAO.getInstance();
		List<BoardVO> boardList = bDao.selectAllBoards();
		request.setAttribute("boardList", boardList);
		if (boardList == null) {
			System.out.println("BoardListAction.execute 값 : null");
		}
		System.out.println(boardList);
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request, response);
	}
}

