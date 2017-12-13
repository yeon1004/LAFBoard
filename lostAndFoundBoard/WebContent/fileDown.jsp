<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE unspecified PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
<%
	//파일을 다운로드 할 때 파일의 제목 인코딩에 따라 제목이 깨질 수 있다. 따라서 제목 인코딩 필요
	//유형 파악
	//FileInputStream : byte Stream-여러 유형의 byte 단위 읽기 전송
	//FileReader: char Stream-문자 최적화
	
	String fileName = request.getParameter("file_name");

	//업로드 폴더 위치와 업로드 폴더의 이름을 알아야 한다.
	String savePath = "upload";
	ServletContext context = getServletContext();
	
	//갖고 온 위치에 연결해서 파일을 다운로드 받으면 된다.
	String sDownPath = context.getRealPath(savePath);
	
	System.out.print("다운로드 위치 : "+sDownPath);
	
	String sFilePath = sDownPath+"\\"+fileName;
	
	//위 문자열을 파일로 인식해야 한다.
	File oFile = new File(sFilePath);
	
	//읽어와야 할 용량은 최대 업로드 용량을 초과하지 않는다.
	byte[] b = new byte[10*1024*1024];
	
	FileInputStream in = new FileInputStream(oFile);
	
	//유형 확인 - 읽어올 경로의 파일의 유형 -> 페이지 생성할 때 타입을 설정해야 한다.
	String sMimeType = getServletContext().getMimeType(sFilePath);
	
	System.out.print("유형 : "+sMimeType);
	
	//지정되지 않은 유형 예외처리
	if(sMimeType==null){
		//관례적인 표현
		sMimeType="application.octec-stream";//일련된 8bit 스트림 형식
		//유형이 알려지지 않은 파일에 대한 읽기 형식 지정
	}
	
	//파일 다운로드 시작
	//유형을 알려준다.
	response.reset();
	response.setContentType("application/octet-stream"); //text/html; charset=utf-8을 대체
	
	//업로드 파일의 제목이 깨질 수 있다. URLEncode
	//String A = new String(fileName.getBytes("euc-kr"),"8859_1");
	//String B = "UTF-8";
	//String sEncoding = URLEncoder.encode(A,B);
	
	String sEncoding = URLEncoder.encode(fileName,"UTF-8");
	
	//기타 내용을 헤더에 올려야 한다.
	//기타 내용을 보고 브라우저에서 다운로드 시 화면에 출력시켜 준다.
	response.setHeader("Content-Disposition", "attachment; filename = " + sEncoding);
	
	String AA="Content-Disposition";
	String BB="attachment; filename="+sEncoding;
	 
	//브라우저에 쓰기
	ServletOutputStream out2 = response.getOutputStream();
	
	int numRead=0;
	
	//바이트 배열 b의 0번부터 numRead번까지 브라우저로 출력
	while((numRead=in.read(b,0,b.length))!=-1){
		out2.write(b,0,numRead);
	}
	out2.flush();
	out2.close();
	in.close();
%>
<script>
self.close();
</script>
</body>
</html>