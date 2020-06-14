package mail;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import board.BoardBean;

public class EmailDAO {

	private Connection getConnection() throws Exception{
		
		// 예외처리를 메서드 호출한 곳에서 처리함
		// 1단계 드라이버 로더
//		Class.forName("com.mysql.jdbc.Driver");
		// 2단계 디비연결
//		String dbUrl = "jdbc:mysql://localhost:3306/jspdb1";
//		String dbUser = "root";
//		String dbPass = "1234";
//		Connection con = DriverManager.getConnection(dbUrl, dbUser, dbPass);
		
//		return con;
		
		Context init=new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		Connection con=ds.getConnection();
		return con;
	}
	public void insertEmail(String email, String emailKey) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			
			con = getConnection();
			
			String sql = "insert into email values(?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,  email);
			pstmt.setString(2,  emailKey);
		    pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			
			if(con!=null) try {con.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}

		}
		
		
	}
	public int getEmail(EmailBean eb ) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int check = 0;
		
		try {
			
		con = getConnection();
		String sql = "select * from email where email=? and email_key=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, eb.getEmail());
		pstmt.setString(2, eb.getEmail_key());
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			
			check=0;
			
		}else {
			
			check=1;
		}
		
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			
			if(con!=null) try {con.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}
			
		}
		return check;
	}
	public void deleteEmail(EmailBean eb ) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			
		con = getConnection();
		String sql = "delete from email where email=? and email_key=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, eb.getEmail());
		pstmt.setString(2, eb.getEmail_key());
		pstmt.executeUpdate();
					
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			
			if(con!=null) try {con.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			
		}
	}
	
}
