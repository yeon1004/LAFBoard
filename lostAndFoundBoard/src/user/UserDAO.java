package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import DBConnect.*;

public class UserDAO {
	DBConnect dbconnect = null;
	String sql="";
	
	public UserDAO() {
		dbconnect = new DBConnect();
	}
	
	public String Login(String userid, String userpw)
	{
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			sql = "SELECT uname FROM users WHERE userid=? and userpw=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setString(2, userpw);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getString(1);
			}
			
		}catch(Exception e) {
			
		}finally {
			DBClose.close(con,pstmt,rs);
		}
		
		return "";
	}
	
	public boolean idcheck(String userid)
	{
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		try {
			sql = "SELECT uname FROM users WHERE userid=? and userpw=?";
			pstmt = con.prepareStatement(sql);
			
			return true;
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			DBClose.close(con,pstmt);
		}
		return false;
	}
	
	public boolean Join(UserDTO udto)
	{
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		sql = "insert into users(userid, userpw, uname, uphone, uemail) values(?,?,?,?,?)";
		try {
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, udto.getUserid());
			pstmt.setString(2, udto.getUserpw());
			pstmt.setString(3, udto.getUname());
			pstmt.setString(4, udto.getUphone());
			pstmt.setString(5, udto.getUemail());
			
			pstmt.execute();
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}finally {
			DBClose.close(con,pstmt);
		}
		return true;
	}
}
