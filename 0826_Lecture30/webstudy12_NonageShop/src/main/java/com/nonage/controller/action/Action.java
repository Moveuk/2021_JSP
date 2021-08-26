package com.nonage.controller.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface Action {
	// interface이므로 abstract 생략되어있음.
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
}
