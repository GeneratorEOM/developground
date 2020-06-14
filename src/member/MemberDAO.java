package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MemberDAO {

	private Connection getConnection() throws Exception{
		
		 // 예외처리를 메서드호출한 곳에서 처리하겠다
		 //1단계 드라이버 로더
		 Class.forName("com.mysql.jdbc.Driver");
		 //2단계 디비연결
		 String dbUrl="jdbc:mysql://localhost:3306/jspdb1";
		 String dbUser="root";
		 String dbPass="1234";
		 Connection con=DriverManager.getConnection(dbUrl, dbUser, dbPass);
		 
		 return con;
	}
	public void insertMember(MemberBean mb) {
		
		Connection con = null;
		PreparedStatement pstmt=null;
		
		try {
			// 예외가 발생할것 같은 구문
				 con = getConnection();
				
				 String sql = "insert into member(id,pass,name,reg_date,email,address,phone,mobile) values(?,?,?,?,?,?,?,?)";
				 pstmt=con.prepareStatement(sql);
				 pstmt.setString(1, mb.getId());
				 pstmt.setString(2, mb.getPass());
				 pstmt.setString(3, mb.getName());
				 pstmt.setTimestamp(4, mb.getReg_date());
				 pstmt.setString(5, mb.getEmail());
				 pstmt.setString(6, mb.getAddress());
				 pstmt.setString(7, mb.getPhone());
				 pstmt.setString(8, mb.getMobile());

				 pstmt.executeUpdate();
			
			} catch (Exception e) {
			// 예외가 발생하면 처리하는 구문
				e.printStackTrace();
			}finally {
			// 예외 상관없이 마무리 작업 구문 => 기억장소 해제
				if(pstmt!=null) {
					try {
						pstmt.close();
					} catch (SQLException ex) {
						
					}
				}
				if(con!=null) {
					try {
						con.close();
					} catch (SQLException ex) {
						
					}
				}
			
			}
	}
	public int idCheck(String id) {
		
		int check = 0;
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		
		try {
			
			 con = getConnection();
		
			 String sql = "select * from member where id = ?";
			 pstmt=con.prepareStatement(sql);
			 pstmt.setString(1, id);
			 rs = pstmt.executeQuery();
			 
			 if(rs.next()) {
				 check=1;
			 }else {
				 check=-1;
			 }
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException ex) {
					
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException ex) {
					
				}
			}
		}
		return check;
		
	}
	public int usercheck(String id, String pass) {
		
		int check = 0;
		Connection con = null;
		PreparedStatement pstmt=null;
		 ResultSet rs = null;
		
		try {
		
				 con = getConnection();
				
				 String sql = "select * from member where id = ?";
				 pstmt=con.prepareStatement(sql);
				 pstmt.setString(1, id);
				 rs = pstmt.executeQuery();
				 
				 if(rs.next()) {
					 
					 if(rs.getString("pass").equals(pass)) {
						 
						 check = 1;
					 }else {
						 
						 check = 0;
					 }
					 
				 }else {
					 check = -1;
				 }
			
			} catch (Exception e) {
			
				e.printStackTrace();
			}finally {
		
				if(pstmt!=null) {
					try {
						pstmt.close();
					} catch (SQLException ex) {
						
					}
				}
				if(con!=null) {
					try {
						con.close();
					} catch (SQLException ex) {
						
					}
				}
				if(rs!=null) {
					try {
						rs.close();
					} catch (SQLException ex) {
						
					}
				}
			
			}
		return check;
	}
	public MemberBean getMember(String id) {
		
		MemberBean mb = new MemberBean();
		Connection con = null;
		PreparedStatement pstmt=null;
		 ResultSet rs = null;
		
		try {
			
			con = getConnection();

			 String sql="select * from member where id=? ";

			 pstmt = con.prepareStatement(sql);

			 pstmt.setString(1, id);
			 
			 rs=pstmt.executeQuery();
			 
			
			if(rs.next()) { 
				
			 mb.setId(rs.getString("id"));
			 mb.setName(rs.getString("name"));
			 mb.setReg_date(rs.getTimestamp("reg_date"));
			 mb.setEmail(rs.getString("email"));
			 mb.setAddress(rs.getString("address"));
			 mb.setPhone(rs.getString("phone"));
			 mb.setMobile(rs.getString("mobile"));
			}

	
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException ex) {
					
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException ex) {
					
				}
			}
			if(rs!=null) {
				try {
					rs.close();
				} catch (SQLException ex) {
					
				}
			}
		}
		return mb;
	}
	public void updateMember(MemberBean mb) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			 con = getConnection();
			 
	 		 String sql = "update member set name=?, email=?, address=?, phone=?, mobile=? where id = ? ";
	 	     pstmt = con.prepareStatement(sql);
	 		 pstmt.setString(1, mb.getName());
	 		pstmt.setString(2, mb.getEmail());
	 		pstmt.setString(3, mb.getAddress());
	 		pstmt.setString(4, mb.getPhone());
	 		pstmt.setString(5, mb.getMobile());
	 		 
	 		 pstmt.setString(6, mb.getId());
	 		 pstmt.executeUpdate();
		} catch (Exception e) {
			
		}finally {
			
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException ex) {
					
				}
			}if(con!=null) {
				try {
					con.close();
				} catch (SQLException ex) {
					
				}
			}
			
		}	
	}
	public void deleteMember(MemberBean mb) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
	
		try {
			 con = getConnection();
			
			 String sql = "delete from member where id = ?";
 			 pstmt = con.prepareStatement(sql);
 			 pstmt.setString(1, mb.getId());
 		 	 pstmt.executeUpdate();
 			
		} catch (Exception e) {
			// TODO: handle exception
		}finally {

			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException ex) {
					
				}
			}if(con!=null) {
				try {
					con.close();
				} catch (SQLException ex) {
					
				}
			}
		}
	}
	public List getIdList() {
		
		List list = new ArrayList();		
		Connection con = null;
		PreparedStatement pstmt=null;
		 ResultSet rs = null;
		
		try {
			
			con = getConnection();

			 String sql="select id from member";

			 pstmt = con.prepareStatement(sql);		 
			 rs=pstmt.executeQuery();
			 
			 			
			while(rs.next()) { 
				
			 MemberBean mb = new MemberBean();
			 mb.setId(rs.getString("id"));
			 
			 list.add(mb);
			}

	
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException ex) {
					
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException ex) {
					
				}
			}
			if(rs!=null) {
				try {
					rs.close();
				} catch (SQLException ex) {
					
				}
			}
		}
		return list;
	}
	
}
