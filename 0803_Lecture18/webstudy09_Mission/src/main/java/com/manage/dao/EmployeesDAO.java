package com.manage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

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
				// 인덱스 번호 1번째부터 불러와짐
				eVo = new EmployeesVO();
				eVo.setId(rs.getString(1));
				eVo.setPass(rs.getString(2));
				eVo.setName(rs.getString(3));
				eVo.setLev(rs.getString(4));
				eVo.setEnter(rs.getDate(5));
				eVo.setGender(rs.getInt(6));
				eVo.setPhone(rs.getString(7));
//				eVo = new EmployeesVO();
//				eVo.setId(rs.getString("ID"));
//				eVo.setPass(rs.getString("PASS"));
//				eVo.setName(rs.getString("name"));
//				eVo.setLev(rs.getString("lev"));
//				eVo.setEnter(rs.getDate("ENTER"));
//				eVo.setGender(rs.getInt("GENDER"));
//				eVo.setPhone(rs.getString("PHONE"));
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
	
	public int updateMypage(EmployeesVO eVo) {
		int result = -1;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE EMPLOYEES SET PASS=?, NAME=?, LEV=?, GENDER=?, PHONE=? WHERE ID = ?";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, eVo.getPass());
			pstmt.setString(2, eVo.getName());
			pstmt.setString(3, eVo.getLev());
			pstmt.setInt(4, eVo.getGender());
			pstmt.setString(5, eVo.getPhone());
			pstmt.setString(6, eVo.getId());
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return result;	
	}
	public void insertMember(EmployeesVO eVo) {
		String sql = "insert into employees values(?,?,?,?,SYSDATE,?,?)";
		Connection conn = null;
		PreparedStatement ptsm = null;
		try {
			conn = getConnection();
			ptsm = conn.prepareStatement(sql);
			ptsm.setString(1, eVo.getId());
			ptsm.setString(2, eVo.getPass());
			ptsm.setString(3, eVo.getName());
			ptsm.setString(4, eVo.getLev());
			ptsm.setInt(5, eVo.getGender());
			ptsm.setString(6, eVo.getPhone());
			ptsm.executeUpdate();
		}catch (Exception e) {
		}finally {
			try {
				if(ptsm!=null) {
					ptsm.close();
				}
				if(conn!=null) {
					conn.close();
				}
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public ArrayList<EmployeesVO> getEmpList() {
		
		String sql = "SELECT * FROM employees";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		EmployeesVO member = null;
		ArrayList<EmployeesVO> members = new ArrayList<>();
		
		try {
			conn = getConnection();
			pstmt= conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
	
			while (rs.next()) {
				member = new EmployeesVO();
				member.setId(rs.getString(1));
				member.setPass(rs.getString(2));
				member.setName(rs.getString(3));
				member.setLev(rs.getString(4));
				member.setEnter(rs.getDate(5));
				member.setGender(rs.getInt(6));
				member.setPhone(rs.getString(7));
				
				members.add(member);
			}
			
		} catch (Exception e) {
			try {
				rs.close();
				pstmt.close();
				conn.close();
			} catch (Exception e2) {
				e.printStackTrace();
			}
		}
		
		return members;
	}
}