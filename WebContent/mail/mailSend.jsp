<%@page import="mail.MailServlet"%>
<%@page import="mail.GoogleAuthentication"%>
<%@ page import="javax.activation.*"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.mail.*"%>
<%@ page import="javax.mail.internet.*"%>
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
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("id");
	String receiver = "imumdae@naver.com";
	String sender = request.getParameter("sender");
	String subject = "'"+id+"' 회원님의 메일";
	String content = request.getParameter("content");
	String content2 = "<h3>'"+id+"' 회원님의 메일주소</h3><br>- "+sender+"<br><br> <h3>내용</h3><br> - "+content;

String[] mailArr = {receiver, subject, content2};

MailServlet.main(mailArr);

%>
<script type="text/javascript">
alert("건의메일이 전송되었습니다.")
location.href="mailForm.jsp"
</script>
<%
%>
</body>
</html>
