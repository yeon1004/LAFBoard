<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
	//request.setCharacterEncoding("utf-8");

    String userid = (String)session.getAttribute("userid");
	
	boolean bLogin = !(userid==null || userid.equals(""));
	if(!bLogin)
	{
		%>
		<script>
		alert('글쓰기는 로그인 후 가능합니다!');
		location.href('login.jsp');
		</script>
		<%
	}
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="board.css" type="text/css" media="screen"/>
<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/earlyaccess/notosanstc.css">
<script src="//cloud.tinymce.com/stable/tinymce.min.js?apiKey=jgx3m403p91k541qpbvlh0tues68ae14wc229t7md008fhsl"></script>
<script>
	tinymce.init({ selector:'textarea' });
	function check(){
		var f = document.writeForm;
		if(!f.title.value){
			alert("제목을 입력하세요.");
			return;
		}
		if(!f.bquiz.value){
			alert("질문을 입력하세요.");
			return;
		}
		if(!f.banswer1.value){
			alert("답변1을 입력하세요.");
			return;
		}
		if(!f.banswer2.value){
			alert("답변2을 입력하세요.");
			return;
		}
		if(!f.banswer3.value){
			alert("답변3을 입력하세요.");
			return;
		}
		if(!f.filename1.value){
			f.filename1.value="";
		}
		if(!f.filename2.value){
			f.filename2.value="";
		}
		if(!f.filename3.value){
			f.filename3.value="";
		}
		f.submit();
	}
</script>
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
		<form name="writeForm" action="controler.jsp?action=write" method="post" enctype="multipart/form-data">
		<table id="tbWrite">
			<tr>
				<td id="writeTitle" colspan="2">주인을 찾습니다!</td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" id="txtTitle" name="title"></td>
			</tr>
			<tr>
				<td colspan="2"> 		  
					<!-- 내용 -->	
					<textarea id='tacont' name="cont"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					첨부파일<br>
					<font style="color: #FC4349; font-size: 12px;">(파일 당 최대 크기: 10MB)</font><br><br>
					<input type="file" name="filename1"/>&nbsp;&nbsp;&nbsp;
					<input type="file" name="filename2"/>&nbsp;&nbsp;&nbsp;
					<input type="file" name="filename3"/>
				</td>
			</tr>
			<tr>
			<td colspan="2">
				<font style="color: #FC4349; font-size: 12px;">
				아래에 예/아니오가 아닌 단답으로 대답할 수 있는 질문을 입력해주세요.<br>
				또한 원활한 확인 작업을 위해 같은 의미의 답 3가지를 입력해주세요.</font>
			</td>
			</tr>
			<tr>
			<td>확인 질문</td>
			<td style="text-align:left;">
				<input type="text" name="bquiz" style="width: 70%;">
			</td>
			</tr>
			<tr>
			<td>답1</td>
			<td style="text-align:left;"><input type="text" name="banswer1"></td>
			</tr>
			<tr>
			<td>답2</td>
			<td style="text-align:left;"><input type="text" name="banswer2"></td>
			</tr>
			<tr>
			<td>답3</td>
			<td style="text-align:left;"><input type="text" name="banswer3"></td>
			</tr>
		</table><br>
		<button type="button" onclick="check();" style="width: 200px; height: 60px; background-color: #6DBCDB; color: white; font-size: 15px; border: 0;">등록</button>
		<button type="reset" style="width: 200px; height: 60px; background-color: #2C3250; color: white; font-size: 15px; border: 0;">취소</button>
		<input type="hidden" name="writer" value="<%=userid%>"/>
		</form>
	</div>
	<div data-role='footer' class='footer'>
		<%@ include file='footer.inc'%>
	</div>
</div>
</body>
</html>