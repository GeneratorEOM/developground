package message;

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

public class MessageDAO {

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
	
	public void insertMessage(MessageBean mb) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			
			con = getConnection();
			
			String sql = "insert into message (send_id, receive_id, subject, content, date) values(?,?,?,?,?)";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,  mb.getSend_id());
			pstmt.setString(2,  mb.getReceive_id());
			pstmt.setString(3,  mb.getSubject());
			pstmt.setString(4,  mb.getContent());
			pstmt.setTimestamp(5,  mb.getDate());
	
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			
			if(con!=null) try {con.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}

		}
		
		
	}
	public List getSendMessageList(String id, int startRow, int pageSize) {
		
		List boardList = new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			con = getConnection();
			String sql = "select * from message where send_id = ? and send_del = 1 order by num desc limit ?, ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, startRow-1); // startRow 시작행 포함하지 않음 => startRow-1
			pstmt.setInt(3, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) { 	
				
			MessageBean bb = new MessageBean();
			
			bb.setNum(rs.getInt("num"));
			bb.setReceive_id(rs.getString("receive_id"));
			bb.setSubject(rs.getString("subject"));
			bb.setContent(rs.getString("content"));
			bb.setDate(rs.getTimestamp("date"));
			bb.setSend_read(rs.getInt("send_read"));
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
	public List getReceiveMessageList(String id, int startRow, int pageSize) {
		
		List boardList = new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			con = getConnection();
			String sql = "select * from message where receive_id = ? and receive_del = 1 order by num desc limit ?, ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, startRow-1); // startRow 시작행 포함하지 않음 => startRow-1
			pstmt.setInt(3, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) { 	
				
			MessageBean bb = new MessageBean();
			
			bb.setNum(rs.getInt("num"));
			bb.setSend_id(rs.getString("send_id"));
			bb.setSubject(rs.getString("subject"));
			bb.setContent(rs.getString("content"));
			bb.setDate(rs.getTimestamp("date"));
			bb.setReceive_read(rs.getInt("receive_read"));
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

	public MessageBean getSendMessage(int num) {
		
		MessageBean bb = new MessageBean();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
		con = getConnection();
		String sql = "select * from message where num = ? ";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, num);
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			
			bb.setNum(rs.getInt("num"));
			bb.setSend_id(rs.getString("send_id"));
			bb.setReceive_id(rs.getString("receive_id"));
			bb.setSubject(rs.getString("subject"));
			bb.setContent(rs.getString("content"));
			bb.setDate(rs.getTimestamp("date"));
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
	public MessageBean getReceiveMessage(int num) {
		
		MessageBean bb = new MessageBean();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
		con = getConnection();
		String sql = "select * from message where receive_id = ?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, num);
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			
			bb.setNum(rs.getInt("num"));
			bb.setSend_id(rs.getString("send_id"));
			bb.setReceive_id(rs.getString("receive_id"));
			bb.setSubject(rs.getString("subject"));
			bb.setContent(rs.getString("content"));
			bb.setDate(rs.getTimestamp("date"));
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
	public int getSendMessageCount(String id) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		try {
			con = getConnection();
			String sql = "select count(*) as count from message where send_id = ? and send_del = 1";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
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
	public int getReceiveMessageCount(String id) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		try {
			con = getConnection();
			String sql = "select count(*) as count from message where receive_id = ? and receive_del = 1";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
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
	public void deleteSendMessage(int num) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = getConnection();
			String sql = "update message set send_del = 0 where num = ?";
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
	public void deleteReceiveMessage(int num) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = getConnection();
			String sql = "update message set receive_del = 0 where num = ?";
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
	public void deleteMessage() {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = getConnection();
			String sql = "delete from message where send_del = 0 and receive_del = 0";
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			
			if(con!=null) try {con.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
		}
		
	}
	public void getSendRead(int num) {
		
		Connection con = null;
		PreparedStatement pstmt = null;


		try {
			con = getConnection();
			String sql = "update message set send_read = send_read+1 where num = ?";
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
	public void getReceiveRead(int num) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		
		try {
			con = getConnection();
			String sql = "update message set receive_read = receive_read+1 where num = ?";
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
	public int getSendReadCount(int num) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		try {
			con = getConnection();
			String sql = "select send_read from message";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt("send_read");
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
	public int getReceiveReadCount() {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		try {
			con = getConnection();
			String sql = "select receive_read from message";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt("receive_read");
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