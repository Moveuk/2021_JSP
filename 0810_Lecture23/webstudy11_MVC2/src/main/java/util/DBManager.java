package util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class DBManager {

	public static Connection getConnection() throws Exception {
		Connection conn = null;
		Context init = null;
		DataSource ds = null;
		
		try {
			init = new InitialContext();
			ds = (DataSource) init.lookup("java:/comp/env/jdbc/OracleDB");
			conn = ds.getConnection();
			
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		return conn;
	}
	
	public static void close(Connection conn, Statement stmt, ResultSet rs) {
		
		try {
			rs.close();
			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void close(Connection conn, Statement stmt) {
		
		try {
			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
