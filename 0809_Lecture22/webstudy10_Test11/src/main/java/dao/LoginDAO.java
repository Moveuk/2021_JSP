package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import vo.MemberVO;

public class LoginDAO {

	private static LoginDAO lDao = new LoginDAO();
	
	// 생성자를 숨겨야 싱글턴 패턴이 완성됨.
	private LoginDAO() {
		
	}
	
	public static LoginDAO getInstance() {
		return lDao;
	}
	
	public Connection getConnection() {
		Connection conn = null;
		Context init = null;
		DataSource ds = null;
		
		try {
			init = new InitialContext();
			ds = (DataSource) init.lookup("java:/comp/env/jdbc/OracleDB");
			conn = ds.getConnection();
		} catch (NamingException | SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	// 내 답안
	public MemberVO selectLoginMember(String id) {
		String sql = "select * from users where id = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberVO mVo = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				mVo = new MemberVO();
				mVo.setId(rs.getString("id"));
				mVo.setPassword(rs.getString("password"));
				mVo.setAddr(rs.getString("addr"));
				mVo.setAge(rs.getInt("age"));
				mVo.setGender(rs.getString("gender"));
				mVo.setName(rs.getString("name"));
				mVo.setNation(rs.getString("nation"));
			} // if 문 끝
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return mVo;
	}
	
	public MemberVO selectLoginMemberMaster(String id,String password) {
		String sql = "select * from users where id = ? and password = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberVO mVo = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				mVo = new MemberVO();
				mVo.setId(rs.getString("id"));
				mVo.setPassword(rs.getString("password"));
				mVo.setAddr(rs.getString("addr"));
				mVo.setAge(rs.getInt("age"));
				mVo.setGender(rs.getString("gender"));
				mVo.setName(rs.getString("name"));
				mVo.setNation(rs.getString("nation"));
			} // if 문 끝
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return mVo;
	}
	
	

}
