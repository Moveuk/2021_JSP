package com.nonage.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.nonage.dto.ProductVO;

import util.DBManager;

public class ProductDAO {
	private static ProductDAO instance = new ProductDAO();
	
	private ProductDAO() {
	}
	
	public static ProductDAO getInstance() {
		 return instance;
	}
	
	
	//New Item
	public ArrayList<ProductVO> listNewProduct(){
		
		ArrayList<ProductVO> productList = new ArrayList<ProductVO>();
		String sql= "select * from new_pro_view";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
		  conn = DBManager.getConnection();
	      pstmt = conn.prepareStatement(sql);
	      rs = pstmt.executeQuery();
	      while (rs.next()) {
	        ProductVO product = new ProductVO();
	        product.setPseq(rs.getInt("pseq"));
	        product.setName(rs.getString("name"));
	        product.setPrice2(rs.getInt("price2"));
	        product.setImage(rs.getString("image"));
	        productList.add(product);
	      }
		} catch (Exception e) {
		      e.printStackTrace();
		} finally {
		  DBManager.close(conn, pstmt, rs);
		}
		
		return productList;	
	}
	
	//Best Item
	public ArrayList<ProductVO> listBestProduct() {
		
		ArrayList<ProductVO> productList = new ArrayList<ProductVO>();
		String sql= "select * from best_pro_view";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
		  conn = DBManager.getConnection();
	      pstmt = conn.prepareStatement(sql);
	      rs = pstmt.executeQuery();
	      while (rs.next()) {
	        ProductVO product = new ProductVO();
	        product.setPseq(rs.getInt("pseq"));
	        product.setName(rs.getString("name"));
	        product.setPrice2(rs.getInt("price2"));
	        product.setImage(rs.getString("image"));
	        productList.add(product);
	      }
		} catch (Exception e) {
		      e.printStackTrace();
		} finally {
		  DBManager.close(conn, pstmt, rs);
		}
		
		return productList;	
	}

	public ProductVO getProduct(String pseq) {
		ProductVO pVo = null;
		String sql = "SELECT * FROM product WHERE pseq = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBManager.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pseq);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				pVo = new ProductVO();
				pVo.setPseq(rs.getInt("pseq"));
				pVo.setName(rs.getString("name"));
				pVo.setKind(rs.getString("kind"));
				pVo.setPrice1(rs.getInt("price1"));
				pVo.setPrice2(rs.getInt("price2"));
				pVo.setPrice3(rs.getInt("price3"));
				pVo.setContent(rs.getString("content"));
				pVo.setImage(rs.getString("image"));
				pVo.setUseyn(rs.getString("useyn"));
				pVo.setBestyn(rs.getString("bestyn"));
				pVo.setIndate(rs.getTimestamp("indate"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBManager.close(conn, pstmt, rs);
		}
		
		return pVo;
	}

	
	public ArrayList<ProductVO> listKindProduct(String kind) {
		ArrayList<ProductVO> productList = new ArrayList<ProductVO>();
		ProductVO pVo = null;
		String sql = "SELECT * FROM product WHERE kind = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DBManager.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, kind);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				pVo = new ProductVO();
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
