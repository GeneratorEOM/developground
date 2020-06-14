package board.file;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import board.CommentBean;




public class FileCommentDAO 
{
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	

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
	
	// �������� �����´�.
	public int getCommentNum() 
	{
		int result = 1;
		try {
			conn = getConnection();
			
			// ������ ���� �����´�. (DUAL : ������ ���� ������������ �ӽ� ���̺�)
			StringBuffer sql = new StringBuffer();
			sql.append("select max(num) as max from fcomment");

			pstmt = conn.prepareStatement(sql.toString());
			rs = pstmt.executeQuery(); // ���� ����

			if (rs.next())	result = rs.getInt(1);

		} catch (Exception e) {
			throw new RuntimeException(e.getMessage());
		}finally {
			
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}
		}

		return result;
	} 
	
	
	public void insertComment(FileCommentBean cb) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			
			con = getConnection();			
			String sql = "insert into fcomment values (?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cb.getNum());
			pstmt.setInt(2, cb.getBoard());
			pstmt.setString(3, cb.getId());
			pstmt.setString(4, cb.getContent());
			pstmt.setTimestamp(5, cb.getDate());			
			pstmt.executeUpdate();

			
		} catch (Exception e) {
			
			e.printStackTrace();

		}finally {
		
			if(con!=null) try {con.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}

		}
		
	}  	
	


	
	public List getCommentList(int startRow, int pageSize,int board ) {
		
		List commentList = new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		FileCommentBean cb = new FileCommentBean();
		
		try {
			
			con = getConnection();
			String sql = "select c.* from fboard b join fcomment c on b.num = c.board where b.num=? order by num desc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board);
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, pageSize);

			rs = pstmt.executeQuery();
			
			while(rs.next()) { 	
				
			FileCommentBean cd = new FileCommentBean();
			
			cd.setNum(rs.getInt("num"));
			cd.setBoard(rs.getInt("board"));
			cd.setId(rs.getString("id"));
			cd.setContent(rs.getString("content"));
			cd.setDate(rs.getTimestamp("date"));
			cd.setBoard(rs.getInt("board"));

			commentList.add(cd);
			
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(con!=null) try {con.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}
		}
		return commentList;
	}
	public int getCommentCount() {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		try {
			con = getConnection();
			String sql = "select count(*) as count from fcomment";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt("count");
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			
			if(con!=null) try {con.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}
		}
		return count;
	}
	public int getCommentCount(int num) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		try {
			con = getConnection();
			String sql = "select count(*) as count from fcomment where board=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt("count");
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			
			if(con!=null) try {con.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}
		}
		return count;
	}
	public void updateComment(String content, int num) {
		
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			
			con = getConnection();
			String sql = "update fcomment set content=? where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, content);
			pstmt.setInt(2, num);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(con!=null) try {con.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
		

		}
	}
	public void deleteComment(int num) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			
			con = getConnection();
			String sql = "delete from fcomment where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(con!=null) try {con.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			
		}
	}
		
}
