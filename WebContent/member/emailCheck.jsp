<%@page import="mail.EmailDAO"%>
<%@page import="mail.EmailBean"%>
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
request.setCharacterEncoding("utf-8");
String email = request.getParameter("email");
String emailkey = request.getParameter("emailkey");
int check = 0;
EmailBean eb = new EmailBean();

eb.setEmail(email);
eb.setEmail_key(emailkey);

EmailDAO edao = new EmailDAO();

check = edao.getEmail(eb);

if(check==0) {
	
	
	out.write(check+"");
	
}else{
	check = 1;
	out.write(check+"");
}
%>

</body>
</html>