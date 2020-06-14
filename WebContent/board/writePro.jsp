<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
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

//한글설정
request.setCharacterEncoding("utf-8");

String id = (String)session.getAttribute("id");
String subject = request.getParameter("subject");
String content = request.getParameter("content");
int readcount = 0;
Timestamp date = new Timestamp(System.currentTimeMillis());
//업로드된 파일이름

//패키지 board 파일이름 BoardBean 멤버변수 set() get()
//BoardBean bb 객체 생성
BoardBean bb = new BoardBean();
//자바빈 멤버변수에 파라미터값 저장
BoardDAO bdao = new BoardDAO();
int num = bdao.getNum();

bb.setNum(num);
bb.setId(id);
bb.setSubject(subject);
bb.setContent(content);
bb.setReadcount(readcount);
bb.setReg_date(date);
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