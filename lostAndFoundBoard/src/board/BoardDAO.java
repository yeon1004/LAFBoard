package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import DBConnect.*;

public class BoardDAO {
	DBConnect dbconnect = null;
	String sql="";
	
	public BoardDAO() {
		dbconnect = new DBConnect();
	}

	public int count() {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int cnt = 0;
		
		try {
			sql = "SELECT COUNT(*) FROM board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				cnt=rs.getInt(1);
			}
			
		}catch(Exception e) {
			
		}finally {
			DBClose.close(con,pstmt,rs);
		}
		return cnt;
	}
	
	public String pasing(String data) {
		try {
			data = new String(data.getBytes("8859_1"), "UTF-8");
		}catch (Exception e){ }
		return data;
	}
	
	public ArrayList<BoardDTO> getBoardMemberList() {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList<BoardDTO> boardList = new ArrayList<BoardDTO>();
		
		try {
			sql = "SELECT bid, btitle, bwriter, bdate, bhits, bfile1 FROM board ORDER BY bid DESC";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setBid(rs.getInt(1));
				dto.setBtitle(rs.getString(2));
				dto.setBwriter(rs.getString(3));
				dto.setBdate(rs.getString(4).substring(0,10));
				dto.setBhits(rs.getInt(5));
				boardList.add(dto);
			}
		}catch(Exception e) {
			
		}finally {
			DBClose.close(con,pstmt,rs);
		}
		return boardList;
	}
	
	public int getMax() {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int max = 0;
		
		try {
			sql = "SELECT MAX(NUM) FROM board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				max=rs.getInt(1);
			}
			
		}catch(Exception e) {
			
		}finally {
			DBClose.close(con,pstmt,rs);
		}
		return max;
	}
	
	public boolean insertWrite(BoardDTO dto) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		
		try {
			sql = "INSERT INTO board(bid, btitle, bwriter, bcont, bfile1, bfile2, bfile3, bquiz, banswer1, banswer2, banswer3) values(seq_bid.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, dto.getBtitle());
			pstmt.setString(2, dto.getBwriter());
			pstmt.setString(3, dto.getBcont());
			pstmt.setString(4, dto.getBfile1());
			pstmt.setString(5, dto.getBfile2());
			pstmt.setString(6, dto.getBfile3());
			pstmt.setString(7, dto.getBquiz());
			pstmt.setString(8, dto.getBanswer1());
			pstmt.setString(9, dto.getBanswer2());
			pstmt.setString(10, dto.getBanswer3());
			
			pstmt.execute();
			
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}finally {
			DBClose.close(con,pstmt);
		}
		return true;
	}
	
	public BoardDTO getBoardView(int idx) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardDTO dto = null;
		
		try {
			sql = "SELECT btitle, bcont, bwriter, bdate, bhits, bfile1, bfile2, bfile3 FROM board WHERE bid=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new BoardDTO();
				dto.setBtitle(rs.getString(1));
				dto.setBcont(rs.getString(2));
				dto.setBwriter(rs.getString(3));
				dto.setBdate(rs.getString(4));
				dto.setBhits(rs.getInt(5)+1);
				if(rs.getString(6)!=null)
					dto.setBfile1(rs.getString(6));
				else dto.setBfile1("");
				if(rs.getString(7)!=null)
					dto.setBfile2(rs.getString(7));
				else dto.setBfile2("");
				if(rs.getString(8)!=null)
					dto.setBfile3(rs.getString(8));
				else dto.setBfile3("");
			}
			
		}catch(Exception e) {
			
		}finally {
			DBClose.close(con,pstmt,rs);
		}
		return dto;
	}
	
	public void UpdateHit(int idx) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		
		try {
			sql = "UPDATE board SET bhits=bhits+1 where bid=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			
		}finally {
			DBClose.close(con,pstmt);
		}
	}
	
	public String getQuiz(int idx) {
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String quiz = "";
		
		try {
			sql = "SELECT bquiz FROM board where bid=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				quiz = rs.getString(1);
			}
			
		}catch(Exception e) {
			
		}finally {
			DBClose.close(con,pstmt,rs);
		}
		return quiz;
	}
	
	public boolean checkAnswer(String answer, int bid)
	{
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			sql = "SELECT * FROM board where bid=? and (banswer1=? or banswer2=? or banswer3=?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bid);
			pstmt.setString(2, answer);
			pstmt.setString(3, answer);
			pstmt.setString(4, answer);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return true;
			}
			
		}catch(Exception e) {
			
		}finally {
			DBClose.close(con,pstmt,rs);
		}
		return false;
	}
	
	public String getWriterPhone(int bid)
	{
		Connection con = dbconnect.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String phone = "null";
		
		try {
			sql = "select uphone from users, board where bid=? and bwriter=userid";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bid);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				phone = rs.getString(1);
			}
			
		}catch(Exception e) {
			
		}finally {
			DBClose.close(con,pstmt,rs);
		}
		return phone;
	}
}
