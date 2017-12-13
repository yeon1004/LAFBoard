<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
	//request.setCharacterEncoding("utf-8");

    String userid = (String)session.getAttribute("userid");
	
	boolean bLogin = !(userid==null || userid.equals(""));
	if(bLogin){
		%>
		<script>
		alert('이미 로그인하셨습니다!');
		location.href('controler.jsp?action=list');
		</script>
		<%
	}
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="board.css" type="text/css" media="screen"/>
<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/earlyaccess/notosanstc.css">
<title>분실물 게시판</title>
<script>
function check(){
	var f = document.loginForm;
	if(!f.userid.value){
		alert("아이디를 입력하세요.");
		return;
	}
	else if(!f.userpw.value){
		alert("비밀번호를 입력하세요.");
		return;
	}
	else{
		f.submit();
	}
}
</script>
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
	<form name='loginForm' action='controler.jsp?action=login' method='post'>
		<table id='tbLogin'>
			<tr>
			<td>아이디</td>
			<td><input type='text' name='userid'/></td>
			</tr>
			<tr>
			<td>비밀번호</td>
			<td><input type='password' name='userpw'/></td>
			</tr>
			<tr>
			<td colspan="2"><button type="button" id="btnLogin" onclick="check();">로그인</button></td>
			</tr>
		</table>
	</form>
	</div>
	<div data-role='footer' class='footer'>
		<%@ include file='footer.inc'%>
	</div>
</div>
</body>
</html>