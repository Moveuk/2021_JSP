package com.saeyan.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.saeyan.dto.MemberVO;

public class MemberDAO {

	// static 하게 하여 단일 인스턴스로 만듬.
	private static final MemberDAO MEMBER_DAO = new MemberDAO();
	
	// 기본 생성자는 private하게
	private MemberDAO() {

	}
	
	// 인스턴스를 불러옴. 외부에서 새로 메모리를 잡아먹게 만들 필요가 없음.
	public static MemberDAO getInstance() {
		return MEMBER_DAO;
	}
	
	// 커넥션하는 메소드
	public Connection getConnection() throws Exception {
		Context initContext = new InitialContext();
		DataSource ds = (DataSource) initContext.lookup("java:comp/env/jdbc/OracleDB");
		Connection conn = ds.getConnection();
		
		return conn;
	}
	
	public int userCheck (String userid, String pwd) {
		// 아이디 틀리면 -1
		int result = -1;
		String sql = "select pwd from member where userid=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				if(rs.getString(1) != null && rs.getString(1).equals(pwd)) {
					result = 1;
				} else {
					result = 0;
				}
			} else {
				result = -1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				pstmt.close();
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return result;
	}
	
	public MemberVO getMember(String userid) {
		MemberVO mVo = null;
		String sql = "select * from member where userid = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				mVo = new MemberVO();
				mVo.setName(rs.getString("name"));
				mVo.setUserid(rs.getString("userid"));
				mVo.setPwd(rs.getString("pwd"));
				mVo.setEmail(rs.getString("email"));
				mVo.setPhone(rs.getString("phone"));
				mVo.setAdmin(rs.getInt("admin"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				pstmt.close();
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return mVo;
	}
	
}

// 싱글톤 패턴
// 외부에서 직접 생성이 불가능한 클래스
// 내부에서 한번만 생성된다.

// 싱글톤 패턴 조건
// 1. 생성자는 private해야한다.
// 2. private한 멤버변수가 존재한다.
// 3. public한 메소드가 존재한다.