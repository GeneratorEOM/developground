
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

int check = ldao.likeCheckF(id, board);

if(check==0) {
	
	ldao.deleteBoardF(id, board);
	ldao.downLikeF(board);
	out.print(check+"/"+ldao.getLikeF(board));

	
}else if(check==1){
	
	ldao.insertLikeF(id, board);
	ldao.upLikeF(board);
	out.print(check+"/"+ldao.getLikeF(board));

	
}

%>

</body>
</html>