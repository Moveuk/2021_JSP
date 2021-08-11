package com.saeyan.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/upload.do")
public class MultiUploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		// 여기를 바꿔주면 다운받는 경로가 바뀜
		String savePath = "upload";
		// 최대 업로드 파일 크기 5MB로 제한
		int uploadFileSizeLimit = 5 * 1024 *1024;
		String encType = "UTF-8";
		
		ServletContext context = getServletContext();
		String uploadFilePath = context.getRealPath(savePath);
		System.out.println("서버상의 실제 디렉토리 :");
		System.out.println(uploadFilePath);
		
		try {
			MultipartRequest multi = new MultipartRequest(
					request,				// request 객체
					uploadFilePath,			// 서버상의 실제 디렉토리
					uploadFileSizeLimit,	// 최대 업로드 파일 크기
					encType,				// 인코딩 방법
					new DefaultFileRenamePolicy());		// 동일한 이름이 존재하면 새로운 이름이 부여됨

			// 업로드된 여러 파일의 이름 얻기
			Enumeration files = multi.getFileNames();
			while (files.hasMoreElements()) {
				String file = (String) files.nextElement();
				String fileName = multi.getFilesystemName(file);
				String fileOriginalName = multi.getOriginalFileName(file);
				out.print("<br> 업로드된 파일명 : " + fileName);
				out.print("<br> 원본 파일명 : " + fileOriginalName);
				out.print("<hr>");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}	// catch
		
	}

}