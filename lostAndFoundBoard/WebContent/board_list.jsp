<%@ page language = "java" contentType="text/html;charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.sql.*,java.text.SimpleDateFormat,java.util.Date"%>
<%@ page import="java.util.*" %>
<%@ page import="board.*" %>

<jsp:useBean id="dao" class="board.BoardDAO"/>
<!DOCTYPE html>
<%
	request.setCharacterEncoding("utf-8");

    String userid = (String)session.getAttribute("userid");
	
	boolean bLogin = !(userid==null || userid.equals(""));
%>

<%	
	int total = dao.count();
	ArrayList<BoardDTO> boardList = dao.getBoardMemberList();
	int size = boardList.size();
	int size2 = size;
	
	final int ROWSIZE = 10;
	final int BLOCK = 5;
	int indent = 0;

	int pg = 1;
	
	if(request.getParameter("pg")!=null) {
		pg = Integer.parseInt(request.getParameter("pg"));
	}
	
	int end = (pg*ROWSIZE);
	
	int allPage = 0;

	int startPage = ((pg-1)/BLOCK*BLOCK)+1;
	int endPage = ((pg-1)/BLOCK*BLOCK)+BLOCK;
	
	allPage = (int)Math.ceil(total/(double)ROWSIZE);
	
	if(endPage > allPage) {
		endPage = allPage;
	}
	
	size2 -= end;
	if(size2 < 0) {
		end = size;
	}
	
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="board.css" type="text/css" media="screen"/>
<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/earlyaccess/notosanstc.css">
<title>분실물 게시판</title>
</head>
<body>
<div class='wrap'>
	<div class='top'>
		<!--로그인 체크-->
		<% if(bLogin){ %>
			<%= userid %>님 로그인&nbsp; 
			<input type='button' value='로그아웃' class='userbtn' onclick="location.href='controler.jsp?action=logout'"/>&nbsp;&nbsp;
		<% }else{  %>
			<input type='button' value='로그인' class='userbtn' onclick="location.href='user_login.jsp'"/>&nbsp;&nbsp;
			<input type='button' value='회원가입' class='userbtn2' onclick="location.href='user_join.jsp'"/>
		<% }%>
	</div>
	<div class='header'>
		<div><a href='board_list.jsp'><h1>분실물 게시판</h1></a></div>
	</div>
	<div class='cont'>
		<br><br>
		<table id="boardList">
			<tr>
				<th width="10%">글번호</th>
				<th width="50%">제목</th>
				<th width="15%">작성자</th>
				<th width="15%">작성일</th>
				<th width="10%">조회수</th>
			</tr>
			<%
			if(total==0) {
				%>
				<tr>
				<td colspan="5" style="padding: 30px 0;">등록된 글이 없습니다.</td>
				</tr>
				<%
			} else {
				for(int i=ROWSIZE*(pg-1); i<end; i++){
					BoardDTO dto = boardList.get(i);
					int idx = dto.getBid();
			%>
					<tr class="blist" align="center">
						<td align="center"><%=idx%></td>
						<td align="left">&nbsp;&nbsp;&nbsp;
							<a href="board_view.jsp?idx=<%=idx%>&pg=<%=pg%>"><%=dto.getBtitle()%></a>
						</td>
						<td align="center"><%=dto.getBwriter()%></td>
						<td align="center"><%=dto.getBdate()%></td>
						<td align="center"><%=dto.getBhits()%></td>
					</tr><%
				}
			} 
			%>
		</table>
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td align="center" colspan="5">
					<%
						if(pg>BLOCK) {
					%>
						[<a href="board_list.jsp?pg=1">◀◀</a>]
						[<a href="board_list.jsp?pg=<%=startPage-1%>">◀</a>]
					<%
						}
					%>
					
					<%
						for(int i=startPage; i<= endPage; i++){
							if(i==pg){
					%>
								<u><b>[<%=i %>]</b></u>
					<%
							}else{
					%>
								[<a href="board_list.jsp?pg=<%=i %>"><%=i %></a>]
					<%
							}
						}
					%>
					
					<%
						if(endPage<allPage){
					%>
						[<a href="board_list.jsp?pg=<%=endPage+1%>">▶</a>]
						[<a href="board_list.jsp?pg=<%=allPage%>">▶▶</a>]
					<%}
					%>
				</td>
			</tr>
			
			<tr align="right">
				<td colspan="5"><button type="button" onclick="window.location='board_write.jsp'" style="width: 100px; height: 30px; background-color: #2C3250; color: #FFFFFF; margin-right: 5%; border: 0;">글쓰기</button></td>
			</tr>
		</table>
	</div>
	<div data-role='footer' class='footer'>
		<%@ include file='footer.inc'%>
	</div>
</div>
</body>
</html>