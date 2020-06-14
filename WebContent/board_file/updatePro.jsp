<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="board.file.FileBoardDAO"%>
<%@page import="board.file.FileBoardBean"%>
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
//세션값 가져오기
FileBoardDAO bdao = new FileBoardDAO();
if(file==null) {
	FileBoardBean bb = bdao.getBoard(num);
	file = bb.getFile();
}
FileBoardBean bb = new FileBoardBean();

bb.setNum(num);
bb.setSubject(subject);
bb.setContent(content);
bb.setFile(file);



bdao.updateBoard(bb);
%>
	<script type="text/javascript">
	alert("게시글이 수정되었습니다.")
	location.href="content.jsp?num=<%=num%>"
	</script>
	<%

%>
</body>
</html>