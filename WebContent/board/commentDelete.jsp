<%@page import="board.CommentDAO"%>
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
CommentDAO cdao = new CommentDAO();

cdao.deleteComment(num);

%>
</body>
</html>