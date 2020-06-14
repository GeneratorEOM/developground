package like;

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

public class LikeDAO {

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
	
	public void insertLike(String id, int board) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			
			con = getConnection();
			
			String sql = "insert into boardlike(id, board) values(?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,  id);
			pstmt.setInt(2,  board);

			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			
			if(con!=null) try {con.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}

		}
	}
	public void deleteBoard(String id, int board) {
			
		Connection con = null;
		PreparedStatement pstmt = null;
			
		try {
				
			con = getConnection();
			String sql = "delete from boardlike where id=? and board=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, board);
			pstmt.executeUpdate();
				
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(con!=null) try {con.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
		
		}
	}
	public int likeCheck(String id, int board) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int num = 0;
		
		try {
			con = getConnection();
			
			String sql ="select * from boardlike where id = ? and board = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, board);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				num=0;
				
			}else {
				
				num=1;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(con!=null) try {con.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}
		}
		return num;
	}

	public void upLike(int board) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
		
			con = getConnection();
			String sql = "update board set board_like=(board_like+1) where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(con!=null) try {con.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			
		}

	}
	public void downLike(int board) {
		
		
		Connection con = null;
		PreparedStatement pstmt = null;
	
		
		try {
			
		con = getConnection();
		String sql = "update board set board_like=(board_like-1) where num=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, board);
		pstmt.executeUpdate();

			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			
			if(con!=null) try {con.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			
		}
	
	}
	public int getLike(int board) {
		
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int num=0;
		try {
			
		con = getConnection();
		String sql = "select board_like from board where num=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, board);
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			num=rs.getInt("board_like");
			
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			
			if(con!=null) try {con.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			
		}
		
		return num;
	}
	
	// board
	
	public void insertLikeF(String id, int board) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			
			con = getConnection();
			
			String sql = "insert into fboardlike(id, board) values(?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,  id);
			pstmt.setInt(2,  board);

			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			
			if(con!=null) try {con.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}

		}
	}
	public void deleteBoardF(String id, int board) {
			
		Connection con = null;
		PreparedStatement pstmt = null;
			
		try {
				
			con = getConnection();
			String sql = "delete from fboardlike where id=? and board=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, board);
			pstmt.executeUpdate();
				
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(con!=null) try {con.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
		
		}
	}
	public int likeCheckF(String id, int board) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int num = 0;
		
		try {
			con = getConnection();
			
			String sql ="select * from fboardlike where id = ? and board = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, board);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				num=0;
				
			}else {
				
				num=1;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(con!=null) try {con.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}
		}
		return num;
	}

	public void upLikeF(int board) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
		
			con = getConnection();
			String sql = "update fboard set board_like=(board_like+1) where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(con!=null) try {con.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			
		}

	}
	public void downLikeF(int board) {
		
		
		Connection con = null;
		PreparedStatement pstmt = null;
	
		
		try {
			
		con = getConnection();
		String sql = "update fboard set board_like=(board_like-1) where num=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, board);
		pstmt.executeUpdate();

			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			
			if(con!=null) try {con.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			
		}
	
	}
	public int getLikeF(int board) {
		
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int num=0;
		try {
			
		con = getConnection();
		String sql = "select board_like from fboard where num=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, board);
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			num=rs.getInt("board_like");
			
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			
			if(con!=null) try {con.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			
		}
		
		return num;
	}
	
	// fboard
	
	public void insertLikeP(String id, int board) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			
			con = getConnection();
			
			String sql = "insert into pboardlike(id, board) values(?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,  id);
			pstmt.setInt(2,  board);

			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			
			if(con!=null) try {con.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}

		}
	}
	public void deleteBoardP(String id, int board) {
			
		Connection con = null;
		PreparedStatement pstmt = null;
			
		try {
				
			con = getConnection();
			String sql = "delete from pboardlike where id=? and board=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, board);
			pstmt.executeUpdate();
				
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(con!=null) try {con.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
		
		}
	}
	public int likeCheckP(String id, int board) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int num = 0;
		
		try {
			con = getConnection();
			
			String sql ="select * from pboardlike where id = ? and board = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, board);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				num=0;
				
			}else {
				
				num=1;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(con!=null) try {con.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}
		}
		return num;
	}

	public void upLikeP(int board) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
		
			con = getConnection();
			String sql = "update pboard set board_like=(board_like+1) where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(con!=null) try {con.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			
		}

	}
	public void downLikeP(int board) {
		
		
		Connection con = null;
		PreparedStatement pstmt = null;
	
		
		try {
			
		con = getConnection();
		String sql = "update pboard set board_like=(board_like-1) where num=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, board);
		pstmt.executeUpdate();

			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			
			if(con!=null) try {con.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			
		}
	
	}
	public int getLikeP(int board) {
		
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int num=0;
		try {
			
		con = getConnection();
		String sql = "select board_like from pboard where num=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, board);
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			num=rs.getInt("board_like");
			
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			
			if(con!=null) try {con.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			
		}
		
		return num;
	}
	
	// pboard
}