<%@page import="message.MessageDAO"%>
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
String message = request.getParameter("message"); // 123-123-123-123

String[] messageArr = message.split("-");

int[] messageNumArr = new int[messageArr.length];

MessageDAO mdao = new MessageDAO();

for(int i=0;i<messageArr.length; i++) {
	messageNumArr[i] = Integer.parseInt(messageArr[i]); 
	
}

for(int i=0;i<messageNumArr.length;i++) {
	
	mdao.deleteSendMessage(messageNumArr[i]);
	mdao.deleteMessage();

}

%>
</body>
</html>