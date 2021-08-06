package com.theater.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.theater.dao.MovieDAO;
import com.theater.dto.MovieVO;

@WebServlet("/movieWrite.do")
public class MovieWriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("movie/movieWrite.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		
		
		ServletContext context = getServletContext();
		String path = context.getRealPath("upload");
		String encType = "UTF-8";
		int sizeLimit = 20 * 1024 * 1024;
		
		
		MultipartRequest multi = new MultipartRequest(request, path, sizeLimit, encType, new DefaultFileRenamePolicy());
		
		
		
		MovieVO mVo = new MovieVO();
		
		
		mVo.setTitle(multi.getParameter("title"));
		mVo.setPrice(Integer.parseInt(multi.getParameter("price")));
		mVo.setDirector(multi.getParameter("director"));
		mVo.setActor(multi.getParameter("actor"));
		mVo.setSynopsis(multi.getParameter("synopsis"));
		mVo.setPoster(multi.getFilesystemName("pictureurl"));
		
		MovieDAO mDao = MovieDAO.getInstance();
		mDao.insertMovie(mVo);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("movieList.do");
		dispatcher.forward(request, response);
	}

}
