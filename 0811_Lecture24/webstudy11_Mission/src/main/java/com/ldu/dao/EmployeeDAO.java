package com.ldu.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.ldu.dto.EmployeeVO;

import util.DBManager;

public class EmployeeDAO {
	public static EmployeeDAO eDao = new EmployeeDAO();
			
	private EmployeeDAO() {
	}
	
	public static EmployeeDAO getInstance() {
		return eDao;
	}

	public List<EmployeeVO> selectAllEmployees() {
		String sql = "SELECT * FROM employee";
		List<EmployeeVO> list = new ArrayList<EmployeeVO>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null; 
		
		try {
			conn = DBManager.getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				EmployeeVO eVo = new EmployeeVO();
				eVo.setNum(rs.getInt("num"));
				eVo.setId(rs.getString("id"));
				eVo.setPass(rs.getString("pass"));
				eVo.setName(rs.getString("name"));
				eVo.setLev(rs.getString("lev"));
				eVo.setEnter(rs.getTimestamp("enter"));
				eVo.setGender(rs.getString("gender"));
				eVo.setPhone(rs.getString("phone"));
				list.add(eVo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.close(conn, stmt, rs);
		}
		
		return list;
	}
	
	public void insertEmployee(EmployeeVO eVo) {
		String sql = "INSERT INTO employee VALUES(emp_seq.nextval, ?,?,?,?,sysdate,?,?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = DBManager.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, eVo.getId());
			pstmt.setString(2, eVo.getPass());
			pstmt.setString(3, eVo.getName());
			pstmt.setString(4, eVo.getLev());
			pstmt.setString(5, eVo.getGender());
			pstmt.setString(6, eVo.getPhone());
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.close(conn, pstmt);
		}
		
	}

	public EmployeeVO selectEmployeeByID(String id) {
		String sql = "SELECT * FROM employee WHERE id = ?";
		EmployeeVO eVo = new EmployeeVO();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		
		try {
			conn = DBManager.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				eVo.setNum(rs.getInt("num"));
				eVo.setId(rs.getString("id"));
				eVo.setPass(rs.getString("pass"));
				eVo.setName(rs.getString("name"));
				eVo.setLev(rs.getString("lev"));
				eVo.setEnter(rs.getTimestamp("enter"));
				eVo.setGender(rs.getString("gender"));
				eVo.setPhone(rs.getString("phone"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.close(conn, pstmt, rs);
		}
		
		return eVo;
	}

	public void updateEmployee(EmployeeVO eVo) {
		String sql = "UPDATE employee SET pass = ?, name = ?, lev = ?, gender = ?, phone = ? WHERE id = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = DBManager.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, eVo.getPass());
			pstmt.setString(2, eVo.getName());
			pstmt.setString(3, eVo.getLev());
			pstmt.setString(4, eVo.getGender());
			pstmt.setString(5, eVo.getPhone());
			pstmt.setString(6, eVo.getId());			
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.close(conn, pstmt);
		}
	}

	public void deleteEmployeeByID(String id) {
		String sql = "DELETE FROM employee WHERE id = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = DBManager.getConnection();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, id);
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.close(conn, pstmt);
		}
	}
}
