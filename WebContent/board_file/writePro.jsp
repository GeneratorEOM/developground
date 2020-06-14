<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="board.file.FileBoardDAO"%>
<%@page import="board.file.FileBoardBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	//한글처리 필요X
//파일업로드 프로그램 설치
//첨부파일 파일업로드
//1. 서버안에 폴더 만들어서 파일을 넣고 파일이름을 디비에 저장
//데이터베이스 열이름 file 추가
//2. 파일을 데이터베이스에 저장
//WebContent - WEB-INF - lib - cos.jar 넣기
//설치파일을 객체생성 => 파일업로드, 정보를 저장
//MultipartRequest multi = new MultipartRequest
//			(request, 업로드할 폴더(물리적경로), 파일최대크기, 한글처리, 이름이 동일할때 파일이름바꾸기);
String uploadPath = request.getRealPath("/upload");
System.out.println(uploadPath);
//파일최대크기설정
int maxSize=5*1024*1024; // 5M
//한글설정
//이름이 동일할때 파일이름 바꾸기
MultipartRequest multi= new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());

String id = (String)session.getAttribute("id");
String subject = multi.getParameter("subject");
String content = multi.getParameter("content");
int readcount = 0;
Timestamp date = new Timestamp(System.currentTimeMillis());
//업로드된 파일이름
String file = multi.getFilesystemName("file");

//패키지 board 파일이름 BoardBean 멤버변수 set() get()
//BoardBean bb 객체 생성
FileBoardBean bb = new FileBoardBean();
//자바빈 멤버변수에 파라미터값 저장
FileBoardDAO bdao = new FileBoardDAO();
int num = bdao.getNum();

bb.setNum(num);
bb.setId(id);
bb.setSubject(subject);
bb.setContent(content);
bb.setReadcount(readcount);
bb.setReg_date(date);
bb.setFile(file);
//패키지 board 파일이름 BoardDAO 리턴값 없음 insertBoard(자바빈 주소)

//BoardDAO bdao 객체 생성

//insertBoard(자바빈 주소) 메서드 호출



bdao.insertBoard(bb);
%>
<script type="text/javascript">
alert("게시글이 작성되었습니다.")
location.href="list.jsp"
</script>
<%

%>


</body>
</html>