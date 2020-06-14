<%@page import="board.file.FileCommentDAO"%>
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
String id = (String)session.getAttribute("id");

int num = Integer.parseInt(request.getParameter("num"));
FileCommentDAO cdao = new FileCommentDAO();

cdao.deleteComment(num);

%>
</body>
</html>