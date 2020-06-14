<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="message.MessageDAO"%>
<%@page import="message.MessageBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

String send_id = (String)session.getAttribute("id");
String receive_id = request.getParameter("receive_id");
String subject = request.getParameter("subject");
String content = request.getParameter("content");
Timestamp date = new Timestamp(System.currentTimeMillis());

MemberDAO md = new MemberDAO();

MemberBean mb = md.getMember(receive_id);

if(mb.getId()==null) {
	
	%>
	<script type="text/javascript">
	alert("존재하지 않는 아이디")
	history.back()
	</script>
	<%
}else{
	
	MessageBean mb2 = new MessageBean();

	mb2.setSend_id(send_id);
	mb2.setReceive_id(receive_id);
	mb2.setSubject(subject);
	mb2.setContent(content);
	mb2.setDate(date);

	MessageDAO mdao = new MessageDAO();

	mdao.insertMessage(mb2);
	response.sendRedirect("messageSendList.jsp");
	
}


%>
</body>
</html>