<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="board.photo.PhotoBoardDAO"%>
<%@page import="board.photo.PhotoBoardBean"%>
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
String uploadPath = request.getRealPath("/upload");
System.out.println(uploadPath);
//파일최대크기설정
int maxSize=5*1024*1024; // 5M
//한글설정
//이름이 동일할때 파일이름 바꾸기
MultipartRequest multi= new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());

int num = Integer.parseInt(multi.getParameter("num"));

String subject = multi.getParameter("subject");
String content = multi.getParameter("content");
String file = multi.getFilesystemName("file");

PhotoBoardDAO bdao = new PhotoBoardDAO();


if(file==null) {
	PhotoBoardBean bb = bdao.getBoard(num);
	file = bb.getFile();
}
//세션값 가져오기

PhotoBoardBean bb2 = new PhotoBoardBean();

bb2.setNum(num);
bb2.setSubject(subject);
bb2.setContent(content);
bb2.setFile(file);



bdao.updateBoard(bb2);
%>
	<script type="text/javascript">
	alert("게시글이 수정되었습니다.")
	location.href="content.jsp?num=<%=num%>"
	</script>
	<%

%>
</body>
</html>