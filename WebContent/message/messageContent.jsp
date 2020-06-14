<%@page import="message.MessageBean"%>
<%@page import="message.MessageDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
td {
	width: 90px;
	line-height: 30px;
}
</style>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body style="background-color: #f2f5ce">

<%
int num = Integer.parseInt(request.getParameter("num"));
int send = Integer.parseInt(request.getParameter("send"));

MessageDAO mdao = new MessageDAO();

MessageBean mb = mdao.getSendMessage(num);
if(send==0) {
	mdao.getSendRead(num);
}else{
	mdao.getReceiveRead(num);
}
%>
<fieldset style="margin-top: 35px;   margin-left: 20px; background-color: white; width: 400px;">
<legend style="text-align: center; color: black; font-size: 16pt; margin-bottom: 5px;">쪽지</legend>
<table border="1" style="border-collapse: collapse; margin-left: 10px; margin-bottom: 20px; width: 380px;" >

<%
if(send==0) {
	%>
	<tr><td>보낸날짜</td><td width="300"><%=mb.getDate() %></td>
	<%
}else{
	%>
	<tr><td>받은날짜</td><td width="300"><%=mb.getDate() %></td>
	<%
}
%>

<%
if(send==0) {
	
	%>	
	<tr><td>받는이</td><td><%=mb.getReceive_id()%></td></tr>
	<%
}else {
	
	%>
	<tr><td>보낸이</td><td><%=mb.getSend_id()%></td></tr>
	<%
}

%>

<tr><td>제목</td><td><%=mb.getSubject() %></td></tr>
<tr><td style="height: 250px;">내용</td><td style="width: 300px;"><%=mb.getContent() %></td></tr>
</table>
<%
if(send==1) {
	%><input  type="button" value="답장" onclick="location.href='messageWriteForm.jsp?replyId=<%=mb.getSend_id() %>'" style="margin-left: 270px; left;"><%
}
%>
<%
if(send==0) {
	%><input  type="button" value="뒤로가기" onclick="location.href='messageSendList.jsp'" style="float: right; margin-right: 10px;"><%
}else{
	
	%><input  type="button" value="뒤로가기" onclick="location.href='messageReceiveList.jsp'" style="float: right; margin-right: 10px;"><%
}

%>
</fieldset>
</body>
</html>