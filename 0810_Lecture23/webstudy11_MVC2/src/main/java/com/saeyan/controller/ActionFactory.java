package com.saeyan.controller;

import com.saeyan.controller.action.Action;
import com.saeyan.controller.action.BoardCheckPassAction;
import com.saeyan.controller.action.BoardCheckPassFormAction;
import com.saeyan.controller.action.BoardDeleteAction;
import com.saeyan.controller.action.BoardListAction;
import com.saeyan.controller.action.BoardUpdateAction;
import com.saeyan.controller.action.BoardUpdateFormAction;
import com.saeyan.controller.action.BoardViewAction;
import com.saeyan.controller.action.BoardWriteAction;
import com.saeyan.controller.action.BoardWriteFormAction;

public class ActionFactory {
	private static ActionFactory instance = new ActionFactory();

	private ActionFactory() {
	}

	public static ActionFactory getInstance() {
		return instance;
	}

	public Action getAction(String command) {

		Action action = null;
		System.out.println("ActionFactory요청받은 명령어는 : " + command);

		if (command.equals("board_list")) {
			// 객체 생성
			action = new BoardListAction();
		} else if (command.equals("board_write_form")) {
			// 객체 생성
			action = new BoardWriteFormAction();
		} else if (command.equals("board_write")) {
			// 객체 생성
			action = new BoardWriteAction();
		} else if (command.equals("board_view")) {
			// 객체 생성
			action = new BoardViewAction();
		} else if (command.equals("board_check_pass_form")) {
			// 객체 생성
			action = new BoardCheckPassFormAction();
		} else if (command.equals("board_check_pass")) {
			// 객체 생성
			action = new BoardCheckPassAction();
		} else if (command.equals("board_update_form")) {
			// 객체 생성
			action = new BoardUpdateFormAction();
		} else if (command.equals("board_update")) {
			// 객체 생성
			action = new BoardUpdateAction();
		} else if (command.equals("board_delete")) {
			// 객체 생성
			action = new BoardDeleteAction();
		}
		return action;
	}
}
