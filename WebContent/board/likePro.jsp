
<%@page import="like.LikeBean"%>
<%@page import="like.LikeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<%
String id = (String)session.getAttribute("id");
int board = Integer.parseInt(request.getParameter("board"));

LikeDAO ldao = new LikeDAO();

int check = ldao.likeCheck(id, board);

if(check==0) {
	
	ldao.deleteBoard(id, board);
	ldao.downLike(board);
	out.print(check+"/"+ldao.getLike(board));

	
}else if(check==1){
	
	ldao.insertLike(id, board);
	ldao.upLike(board);
	out.print(check+"/"+ldao.getLike(board));

	
}

%>

</body>
</html>