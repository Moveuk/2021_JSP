package net.board.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
	DataSource ds;
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
	public BoardDAO() {
		try{
			Context init = new InitialContext();
	  	    ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleBoard");
		}catch(Exception ex){
			System.out.println("DB 연결 실패 : " + ex);
			return;
		}
		
	}
	//글의 개수 구하기
	public int getListCount() {
		int number = 0;
		try {
			String sql = "SELECT COUNT(*) FROM board";
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
			number = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				pstmt.close();
				con.close();				
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return number;
	}
	
	//글 목록 보기
	public List getBoardList(){
		ArrayList<BoardBean> list = null;
		BoardBean boardBean = null;
		try {
			String sql = "SELECT * FROM board ORDER BY board_num DESC";
			list = new ArrayList<>();
			BoardDAO bDao = new BoardDAO();
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				boardBean = new BoardBean();
				boardBean.setBoard_num(rs.getInt("board_num"));
				boardBean.setBoard_name(rs.getString("board_name"));
				boardBean.setBoard_pass(rs.getString("board_pass"));
				boardBean.setBoard_subject(rs.getString("board_subject"));
				boardBean.setBoard_content(rs.getString("board_content"));
				boardBean.setBoard_file(rs.getString("board_file"));
				boardBean.setBoard_readcount(rs.getInt("board_readcount"));
				boardBean.setBoard_date(rs.getTimestamp("board_date"));
				list.add(boardBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				pstmt.close();
				con.close();				
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return list;
	}
	
	//글 내용 보기.
	public BoardBean getDetail(int num) throws Exception{
		BoardBean boardBean = null;
		try {
			String sql = "SELECT * FROM board WHERE board_num = ?";
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();

			if (rs.next()) {
				boardBean = new BoardBean();
				boardBean.setBoard_num(rs.getInt("board_num"));
				boardBean.setBoard_name(rs.getString("board_name"));
				boardBean.setBoard_pass(rs.getString("board_pass"));
				boardBean.setBoard_subject(rs.getString("board_subject"));
				boardBean.setBoard_content(rs.getString("board_content"));
				boardBean.setBoard_file(rs.getString("board_file"));
				boardBean.setBoard_readcount(rs.getInt("board_readcount"));
				boardBean.setBoard_date(rs.getTimestamp("board_date"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				pstmt.close();
				con.close();				
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return boardBean;
	}
	
	//글 등록
	public boolean boardInsert(BoardBean boardBean){
		boolean result = false;
		try {
//			String sql = "INSERT INTO board(board_num, board_name, board_pass, board_subject, board_content, board_file, board_readcount, board_date) VALUES(?, ?, ?, ?, ?, ?, 0, sysdate)";
			String sql = "INSERT INTO board VALUES(2,'','','','','',0,sysdate)";
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			int cnt = getListCount()+1;
			System.out.println("인서트 내부 번호 정상 출력 :"+cnt);
			pstmt.setInt(1, cnt);
			System.out.println("인서트 내부 이름 :"+boardBean.getBoard_name());
			String name = boardBean.getBoard_name();
			String pass = boardBean.getBoard_pass();
			String subject = boardBean.getBoard_subject();
			String content = boardBean.getBoard_content();
			String file = boardBean.getBoard_file();
			pstmt.setString(2, name);
			pstmt.setString(3, pass);
			pstmt.setString(4, subject);
			pstmt.setString(5, content);
			pstmt.setString(6, file);
			
			int insert = pstmt.executeUpdate();
			
			if (insert > 0) {
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("인서트 오류");
		} finally {
			try {
				pstmt.close();
				con.close();				
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return result;
	}
	

	//조회수 업데이트
	public void setReadCountUpdate(int num) throws Exception{
		String sql = "UPDATE board SET board_readcount=board_readcount+1 where board_num = ?";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				con.close();				
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}


}
	