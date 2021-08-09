package com.saeyan.dao;

public class BoardDAO {
	public static BoardDAO instance = new BoardDAO();
	
	private BoardDAO() {	
	}
	
	public static BoardDAO getInstance() {
		return instance;
	}

}
