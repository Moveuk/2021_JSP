package com.nonage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.nonage.dto.ProductVO;

import util.DBManager;

public class ProductDAO {
	private static ProductDAO instance = new ProductDAO();
	
	private void ProductDAO() {
	}
	
	public static ProductDAO getInstance() {
		return instance;
	}
	
	// New Item
	public ArrayList<ProductVO> listNewProduct() {
		
		ArrayList<ProductVO> productList = new ArrayList<>();
		String sql = "SELECT * FROM new_pro_view";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBManager.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				ProductVO pVo = new ProductVO();
				
				pVo.setPseq(rs.getInt("pseq"));
				pVo.setName(rs.getString("name"));
				pVo.setPrice2(rs.getInt("price2"));
				pVo.setImage(rs.getString("image"));
				
				productList.add(pVo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.close(conn, pstmt, rs);
		}
		
		return productList;
	}
	
	// New Item
	public ArrayList<ProductVO> listBestProduct() {
		
		ArrayList<ProductVO> productList = new ArrayList<>();
		String sql = "SELECT * FROM best_pro_view";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBManager.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				ProductVO pVo = new ProductVO();
				
				pVo.setPseq(rs.getInt("pseq"));
				pVo.setName(rs.getString("name"));
				pVo.setPrice2(rs.getInt("price2"));
				pVo.setImage(rs.getString("image"));
				
				productList.add(pVo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.close(conn, pstmt, rs);
		}
		
		return productList;
	}
}
