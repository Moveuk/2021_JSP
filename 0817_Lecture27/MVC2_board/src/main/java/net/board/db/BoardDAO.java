package net.board.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
		try {
			Context init = new InitialContext();
			ds = (DataSource)init.lookup("java:comp/env/jdbc/OracleBoard");
		}catch(Exception e) {
			System.out.println("DB연결 실패");
		}
	}
	
	//글의 개수 구하기
		public int getListCount() {
			int count= 0;
			
			try{
				
				con=ds.getConnection();
				System.out.println("getConnection");
				pstmt=con.prepareStatement("select count(*) from board");
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					count=rs.getInt(1);
				}
			}catch(Exception ex){
				System.out.println("getListCount 에러: " + ex);			
			}finally{
				if(rs!=null) try{rs.close();}catch(SQLException ex){}
				if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
				if(con!=null) try{con.close();}catch(SQLException ex){}
			}
			
			
			return count;
		}
	//글 목록 보기
		public List<BoardBean> getBoardList(){
			
			String board_list_sql= "select BOARD_NUM,BOARD_NAME,BOARD_SUBJECT,"+
					"BOARD_CONTENT,BOARD_FILE,"+
					"BOARD_READCOUNT,BOARD_DATE from board order by BOARD_NUM desc";
					
					List<BoardBean> list = new ArrayList();
					
						
					try{
						con = ds.getConnection();
						pstmt = con.prepareStatement(board_list_sql);
						rs = pstmt.executeQuery();
						
						while(rs.next()){
							BoardBean board = new BoardBean();
							board.setBOARD_NUM(rs.getInt("BOARD_NUM"));
							board.setBOARD_NAME(rs.getString("BOARD_NAME"));
							board.setBOARD_SUBJECT(rs.getString("BOARD_SUBJECT"));
							board.setBOARD_CONTENT(rs.getString("BOARD_CONTENT"));
							board.setBOARD_FILE(rs.getString("BOARD_FILE"));	
							board.setBOARD_READCOUNT(rs.getInt("BOARD_READCOUNT"));
							board.setBOARD_DATE(rs.getDate("BOARD_DATE"));
							list.add(board);
						}
						
						
					}catch(Exception ex){
						System.out.println("getBoardList 에러 : " + ex);
					}finally{
						if(rs!=null) try{rs.close();}catch(SQLException ex){}
						if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
						if(con!=null) try{con.close();}catch(SQLException ex){}
					}
					System.out.println("list : " + list);
					return list;
		}


}
