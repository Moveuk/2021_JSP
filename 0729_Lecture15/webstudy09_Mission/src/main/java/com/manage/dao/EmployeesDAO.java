package com.manage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.manage.dto.EmployeesVO;

public class EmployeesDAO {

	private static final EmployeesDAO DAO = new EmployeesDAO();

	private EmployeesDAO() {

	}

	public static EmployeesDAO getInstance() {
		return DAO;
	}

	public Connection getConnection() throws Exception {
		Connection conn = null;
		Context init = null;

		try {
			init = new InitialContext();
			DataSource ds = (DataSource) init.lookup("java:/comp/env/jdbc/OracleDB");
			conn = ds.getConnection();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return conn;
	}

	public int userCheck(String userid, String pwd, String lev) {
	      int result = 1;
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      String sql = "select * from employees where id = ?";
	      
	      try {
	         
	         conn = getConnection();
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, userid);
	         
	         rs = pstmt.executeQuery();
	         
	         if(rs.next()){
	            //비밀번호가 일치하고
	            if(pwd.equals(rs.getString("PASS"))){
	               //회원등급이 일치하면
	               if(lev.equals(rs.getString("LEV"))){
	                  result = 2; //관리자로 로그인 성공
	                  if(lev.equals("B")){
	                     result=3;//일반 회원으로 로그인 성공
	                  }
	               }else{//레벨 불일치 로그인 실패
	                  result =1;
	               }
	            }else{  //비밀번호 불일치 로그인 실패
	               result = 0;
	            }
	         }else{  //아이디 불일치 로그인 실패
	            result = -1;
	         }
	         
	      }catch(Exception e){
	         e.printStackTrace();
	      }finally{
	         try {
	            rs.close();
	            pstmt.close();
	            conn.close();
	         } catch (SQLException e) {
	            e.printStackTrace();
	         }
	      }
	      return result;
	   }

	public EmployeesVO getEmployee(String userid) {
		EmployeesVO eVo = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from employees where id = ?";

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				// 인덱스 번호로 불러오면 안됨. 어째서?
				eVo = new EmployeesVO();
				eVo.setId(rs.getString("ID"));
				eVo.setPass(rs.getString("PASS"));
				eVo.setName(rs.getString("name"));
				eVo.setLev(rs.getString("lev"));
				eVo.setEnter(rs.getDate("ENTER"));
				eVo.setGender(rs.getInt("GENDER"));
				eVo.setPhone(rs.getString("PHONE"));
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

		return eVo;

	}
}