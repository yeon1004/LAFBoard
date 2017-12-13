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
	int idx = Integer.parseInt(request.getParameter("idx"));
	int pg = Integer.parseInt(request.getParameter("pg"));
	BoardDTO dto = dao.getBoardView(idx);	
	dao.UpdateHit(idx);
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
		<table id="tbView">
		<tr id="btitle">
			<td width="5%"><%=idx%><!--글번호--></td>
			<th width="auto" style="text-align: left; font-size: 20px; font-style: bolder;"><%=dto.getBtitle()%><!--제목--></th>
			<td style="width: 8em;" align="right"><font style="color:gray;">조회수 : </font><%=dto.getBhits()%><!--조회수--></td>
		</tr>
		<tr id="binfo">
			<td colspan="3" align="right" style=" border-top: 2px solid #2C3250;">
				<font style="color:gray;">작성자 : </font><%=dto.getBwriter()%><!--작성자-->
				<font style="color:gray;">&nbsp;&nbsp;작성일 : </font><%=dto.getBdate()%><!--작성일-->
			</td>
		</tr>
		<tr id="bcont">
			<td colspan="3" style="padding: 20px 5%;">
				<%=dto.getBcont()%><!--내용-->
			</td>
		</tr>
		<tr id="bfiles">
			<td colspan="3" style="padding: 20px 5%;">
				<%
				if(!dto.getBfile1().equals("파일없음")){
					%>
					<a href="fileDown.jsp?file_name=<%=dto.getBfile1()%>"><%=dto.getBfile1() %></a><br>
					<%
				}
				if(!dto.getBfile2().equals("파일없음")){
					%>
					<a href="fileDown.jsp?file_name=<%=dto.getBfile2()%>"><%=dto.getBfile2() %></a><br>
					<%
				}
				if(!dto.getBfile3().equals("파일없음")){
					%>
					<a href="fileDown.jsp?file_name=<%=dto.getBfile3()%>"><%=dto.getBfile3() %></a><br>
					<%
				}
				%>
			</td>
		</tr>
		</table>
		<input type="button" id="btnMyItem" value="제 물건 같아요!" onClick="location.href='controler.jsp?action=quiz&bid=<%=idx%>';"/>
	</div>
	<div data-role='footer' class='footer'>
		<%@ include file='footer.inc'%>
	</div>
</div>
</body>
</html>