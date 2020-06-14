package board;

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

public class BoardDAO {

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
	
	public void insertBoard(BoardBean bb) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			
			con = getConnection();
			
			String sql = "insert into board values(?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,  bb.getNum());
			pstmt.setString(2,  bb.getId());
			pstmt.setString(3,  bb.getSubject());
			pstmt.setString(4,  bb.getContent());
			pstmt.setInt(5, bb.getReadcount());
			pstmt.setTimestamp(6, bb.getReg_date());
			pstmt.setInt(7, bb.getBoard_like());
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			
			if(con!=null) try {con.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}

		}
		
		
	}
	public int getNum() {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int num = 0;
		
		try {
			con = getConnection();
			
			String sql ="select max(num) as mnum from board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				num = rs.getInt("mnum")+1;
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
	public List getBoardList(int startRow, int pageSize) {
		
		List boardList = new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			con = getConnection();
			String sql = "select * from board order by num desc limit ?, ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow-1); // startRow 시작행 포함하지 않음 => startRow-1
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) { 	
				
			BoardBean bb = new BoardBean();
			
			bb.setNum(rs.getInt("num"));
			bb.setId(rs.getString("id"));			
			bb.setSubject(rs.getString("subject"));
			bb.setContent(rs.getString("content"));
			bb.setReadcount(rs.getInt("readcount"));
			bb.setReg_date(rs.getTimestamp("date"));
			bb.setDate(rs.getTimestamp("date"));
			bb.setBoard_like(rs.getInt("board_like"));
			boardList.add(bb);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(con!=null) try {con.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}
		}
		return boardList;
	}
	
	public List getBoardList(int startRow, int pageSize, String search) {
		
		List boardList = new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			con = getConnection();
			String sql = "select * from board where subject LIKE ? order by num desc limit ?, ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
			pstmt.setInt(2, startRow-1); // startRow 시작행 포함하지 않음 => startRow-1
			pstmt.setInt(3, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) { 	
				
			BoardBean bb = new BoardBean();
			
			bb.setNum(rs.getInt("num"));
			bb.setId(rs.getString("id"));		
			bb.setSubject(rs.getString("subject"));
			bb.setContent(rs.getString("content"));
			bb.setReadcount(rs.getInt("readcount"));
			bb.setReg_date(rs.getTimestamp("date"));
			bb.setDate(rs.getTimestamp("date"));
			bb.setBoard_like(rs.getInt("board_like"));
			boardList.add(bb);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(con!=null) try {con.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}
		}
		return boardList;
	}
	
	public void getReadcount(int num) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
		
			con = getConnection();
			String sql = "update board set readcount = readcount+1 where num = ?";
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
	public BoardBean getBoard(int num) {
		
		BoardBean bb = new BoardBean();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
		con = getConnection();
		String sql = "select * from board where num = ?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, num);
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			
			bb.setNum(rs.getInt("num"));
			bb.setId(rs.getString("id"));
			bb.setSubject(rs.getString("subject"));
			bb.setContent(rs.getString("content"));
			bb.setReadcount(rs.getInt("readcount"));
			bb.setReg_date(rs.getTimestamp("date"));
			bb.setBoard_like(rs.getInt("board_like"));
		}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			
			if(con!=null) try {con.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}
			
		}
		return bb;
	}
	public void updateBoard(BoardBean bb) {
		
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			
			con = getConnection();
			String sql = "update board set subject=? , content=? where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bb.getSubject());
			pstmt.setString(2, bb.getContent());
			pstmt.setInt(3, bb.getNum());
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(con!=null) try {con.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
		

		}
	}
	public void deleteBoard(int num) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			
			con = getConnection();
			String sql = "delete from board where num = ?";
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
	public int getBoardCount() {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		try {
			con = getConnection();
			String sql = "select count(*) as count from board";
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
	
	
}
