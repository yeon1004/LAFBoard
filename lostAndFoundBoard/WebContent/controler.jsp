<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="board.*" %>
<%@ page import="user.*" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" errorPage="error.jsp"%>
<jsp:useBean id="boardDao" class="board.BoardDAO"/>
<jsp:useBean id="userDao" class="user.UserDAO"/>

<%
String action = request.getParameter("action");

//로그인
if(action.equals("login"))
{
	String userid = request.getParameter("userid");
	String userpw = request.getParameter("userpw");
	String uname = userDao.Login(userid, userpw);
	
	if(!uname.equals(""))
	{
		//로그인 성공
		session.setAttribute("userid", userid); //세션 등록
		out.println("<script> alert('로그인 되었습니다!'); location.href='controler.jsp?action=list';</script>");
	}
	else
	{
		//로그인 실패
		out.println("<script> alert('아이디 또는 비밀번호를 확인해주세요!'); history.go(-1); </script>");
	}
}
//로그아웃
if(action.equals("logout"))
{
	session.invalidate(); //세션 종료
	out.println("<script> alert('로그아웃 되었습니다!'); location.href='controler.jsp?action=list';</script>");
}
//회원가입
if(action.equals("join"))
{
	UserDTO udto = new UserDTO();
	udto.setUserid(request.getParameter("userid"));
	udto.setUserpw(request.getParameter("userpw"));
	udto.setUname(request.getParameter("uname"));
	udto.setUphone(request.getParameter("uphone"));
	udto.setUemail(request.getParameter("uemail"));
	
	if(userDao.Join(udto))
	{
		session.setAttribute("userid", request.getParameter("userid")); //세션 등록
		out.println("<script>alert('가입 완료!'); location.href='controler.jsp?action=list';</script>");
	}
	else
	{
		throw new Exception("회원가입 오류");
	}
}
//리스트
if(action.equals("list"))
{
	pageContext.forward("board_list.jsp");
}
//글쓰기
if(action.equals("write"))
{
	//upload폴더에 파일 업로드
		String uploadPath=request.getRealPath("/upload");
		out.print("realPath : "+uploadPath);
		int size = 10 * 1024 * 1024;
		String writer="";
		String title="";
		String cont="";
		
		String fileName1="";
		String fileName2="";
		String fileName3="";
		
		String bQuiz="";
		String bAnswer1="";
		String bAnswer2="";
		String bAnswer3="";
		
		MultipartRequest multi = null;
		
		try{
			multi = new MultipartRequest(
					request,
					uploadPath,
					size,
					"utf-8",
					new DefaultFileRenamePolicy()
					);
			writer = multi.getParameter("writer");
			title = multi.getParameter("title");
			cont = multi.getParameter("cont");
			bQuiz = multi.getParameter("bquiz");
			bAnswer1 = multi.getParameter("banswer1");
			bAnswer2 = multi.getParameter("banswer2");
			bAnswer3 = multi.getParameter("banswer3");
			
			//첨부파일 여러개 가져온다.
			Enumeration files = multi.getFileNames();
			
			//파일의 이름만 가져온다. ->전송받은 이름
			String file3=(String)files.nextElement();
			//multi에서 해당 이름을 알려주고 실제 시스템상의 이름을 알아낸다.
			fileName3 = multi.getFilesystemName(file3);
			
			String file2=(String)files.nextElement();
			fileName2 = multi.getFilesystemName(file2);
			
			String file1=(String)files.nextElement();
			fileName1 = multi.getFilesystemName(file1);
			
		}catch(Exception e){
			throw new Exception("파일 업로드 문제 발생");
		}
		
		BoardDTO bdto = new BoardDTO();
		bdto.setBtitle(title);
		bdto.setBwriter(writer);
		bdto.setBcont(cont);
		bdto.setBfile1(fileName1);
		bdto.setBfile2(fileName2);
		bdto.setBfile3(fileName3);
		bdto.setBquiz(bQuiz);
		bdto.setBanswer1(bAnswer1);
		bdto.setBanswer2(bAnswer2);
		bdto.setBanswer3(bAnswer3);
		if(boardDao.insertWrite(bdto)) {
			out.println("<script>alert('등록되었습니다!'); location.href='controler.jsp?action=list';</script>");
		}
		else {
			throw new Exception("디비 등록 중 문제 발생");
		}
}
if(action.equals("quiz"))
{
	int bid = Integer.parseInt(request.getParameter("bid"));
	String quiz = boardDao.getQuiz(bid);
	out.println("<script> var answer = prompt('"+quiz+"'); location.href='controler.jsp?action=quizcheck&answer='+answer+'&bid="+ bid +"';</script>");
}
if(action.equals("quizcheck"))
{
	String answer = request.getParameter("answer");
	int bid = Integer.parseInt(request.getParameter("bid"));
	if(boardDao.checkAnswer(answer, bid)){
		String phone = boardDao.getWriterPhone(bid);
		out.println("<script>alert('정답입니다! 작성자의 연락처는 " + phone + " 입니다! '); location.href='controler.jsp?action=list';</script>");
	}
	out.println("<script>alert('답이 틀립니다!'); location.href='controler.jsp?action=list';</script>");
}
%>