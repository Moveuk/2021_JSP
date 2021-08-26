package com.nonage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.nonage.dto.AddressVO;

import util.DBManager;

public class AddressDAO {

	private AddressDAO() {
	}
	
	private static AddressDAO instance = new AddressDAO();
	
	public static AddressDAO getInstance() {
		return instance;
	}

	public List<AddressVO> selectAddressByDong(String dong) {
		List<AddressVO> list = new ArrayList<AddressVO>();
		String sql = "SELECT * FROM address WHERE dong like '%'||?||'%'";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBManager.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dong);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				AddressVO aVo = new AddressVO();
				aVo.setZip_num(rs.getString("zip_num"));
				aVo.setSido(rs.getString("sido"));
				aVo.setGugun(rs.getString("gugun"));
				aVo.setDong(rs.getString("dong"));
				aVo.setZip_code(rs.getString("zip_code"));
				aVo.setBunji(rs.getString("bunji"));
				list.add(aVo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.close(conn, pstmt, rs);
		}
		
		return list;		
	}
}
