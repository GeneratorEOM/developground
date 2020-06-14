<%@page import="board.file.FileBoardBean"%>
<%@page import="board.file.FileBoardDAO"%>
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
String pass = request.getParameter("pass");

FileBoardBean bb = new FileBoardBean();
bb.setNum(num);
bb.setPass(pass);

FileBoardDAO bdao = new FileBoardDAO();
	
	bdao.deleteBoard(num);
	%>
	<script type="text/javascript">
	alert("게시글이 삭제되었습니다.")
	location.href="list.jsp"
	</script>
	<%


%>
</body>
</html>