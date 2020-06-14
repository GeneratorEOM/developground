<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
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
request.setCharacterEncoding("utf-8");
int num = Integer.parseInt(request.getParameter("num"));
String id = (String)session.getAttribute("id");
String subject = request.getParameter("subject");
String content = request.getParameter("content");


BoardBean bb = new BoardBean();

bb.setNum(num);
bb.setId(id);
bb.setSubject(subject);
bb.setContent(content);

BoardDAO bdao = new BoardDAO();

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