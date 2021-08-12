package com.nonage.controller;

import com.nonage.controller.action.Action;

public class ActionFactory {
	private static ActionFactory instance = new ActionFactory(); 
	
	private ActionFactory() {
		
	}
	
	public static ActionFactory getInstance() {
		return instance;
	}
	
	public Action getAction(String command) {
		Action action = null;
		System.out.println("ActionFactory에 요청 사항 : "+ command);
		
		return action;
	}
}
