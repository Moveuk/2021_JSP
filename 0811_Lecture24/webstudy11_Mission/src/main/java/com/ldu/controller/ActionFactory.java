package com.ldu.controller;

import com.ldu.controller.action.Action;
import com.ldu.controller.action.EmployeeDeleteAction;
import com.ldu.controller.action.EmployeeDetailAction;
import com.ldu.controller.action.EmployeeListAction;
import com.ldu.controller.action.EmployeeUpdateAction;
import com.ldu.controller.action.EmployeeUpdateFormAction;
import com.ldu.controller.action.EmployeeWriteAction;
import com.ldu.controller.action.EmployeeWriteFormAction;

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

		if (command.equals("empList")) {
			// 객체 생성
			action = new EmployeeListAction();
		} else if (command.equals("empWriteForm")) {
			// 객체 생성
			action = new EmployeeWriteFormAction();
		} else if (command.equals("empWrite")) {
			// 객체 생성
			action = new EmployeeWriteAction();
		} else if (command.equals("empDetail")) {
			// 객체 생성
			action = new EmployeeDetailAction();
		} else if (command.equals("empUpdateForm")) {
			// 객체 생성
			action = new EmployeeUpdateFormAction();
		} else if (command.equals("empUpdate")) {
			// 객체 생성
			action = new EmployeeUpdateAction();
		} else if (command.equals("empDelete")) {
			// 객체 생성
			action = new EmployeeDeleteAction();
		}
		return action;
	}
}