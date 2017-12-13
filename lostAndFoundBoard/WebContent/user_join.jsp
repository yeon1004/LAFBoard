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
function check()
{
	var f = document.joinForm;
	if(!f.userid.value){
		alert("아이디를 입력하세요.");
		return;
	}
	if(!f.userpw.value){
		alert("비밀번호를 입력하세요.");
		return;
	}
	if(!f.uname.value){
		alert("이름을 입력하세요.");
		return;
	}
	f.uphone.value = f.uphone1.value + "-" + f.uphone2.value + "-" + f.uphone3.value;
	f.uemail.value = f.uemail1.value + "@" + f.uemail2.value;
	
	f.submit();
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
	<h1 style="color: #999999;">Welcome!</h1><br>
	<form name='joinForm' action='controler.jsp?action=join' method='post'>
	<table id='tbJoin'>
		<tr>
		<th>ID<br><font style="color: #6DBCDB; font-style:bold; line-height: 80%;">&nbsp;&nbsp;&nbsp;&nbsp;아이디</font></th>
		<td><input type='text' name='userid'/></td>
		</tr>
		<tr>
		<th>Password<br><font style="color: #6DBCDB; font-style:bold; line-height: 80%;">&nbsp;&nbsp;&nbsp;&nbsp;비밀번호</font></th>
		<td><input type='password' name='userpw'/></td>
		<tr>
		<th>Name<br><font style="color: #6DBCDB; font-style:bold; line-height: 80%;">&nbsp;&nbsp;&nbsp;&nbsp;이름</font></th>
		<td>
			<input type='text' name='uname'/>
		</td>
		</tr>
		<tr>
		<th>Phone<br><font style="color: #6DBCDB; font-style:bold; line-height: 80%;">&nbsp;&nbsp;&nbsp;&nbsp;연락처</font></th>
		<td><input type='text' maxlength='3' size='3' name='uphone1'/>-
			<input type='text' maxlength='4' size='4' name='uphone2'/>-
			<input type='text' maxlength='4' size='4' name='uphone3'/>
			<input type='hidden' name='uphone'/>
		</td>
		</tr>
		<tr>
		<th>Email<br><font style="color: #6DBCDB; font-style:bold; line-height: 80%;">&nbsp;&nbsp;&nbsp;&nbsp;이메일</font></th>
		<td>
			<input type='text' maxlength='15' size='15' name='uemail1'/>@
			<input type='text' maxlength='15' size='15' name='uemail2'/>
			<input type='hidden' name='uemail'/>
		</td>
		</tr>
		<tr>
		<td style="text-align: center;" colspan='2'><input id="btnJoin" type='button' onclick='check();' value='회원가입'/></td>
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