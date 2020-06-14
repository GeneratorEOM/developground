<%@page import="member.MemberDAO"%>
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

String id = request.getParameter("id");
String pass = request.getParameter("pass");


MemberDAO md = new MemberDAO();

int check = md.usercheck(id, pass);

if(check==1) {
	
	session.setAttribute("id", id);
	
	response.sendRedirect("../main/main.jsp");
	
}else if(check==0) {
	
	%><script type="text/javascript">			
	alert("비밀번호가 일치하지 않습니다.")
	history.back();
	</script><%
	
	
}else{
	
	%><script type="text/javascript">
	alert("아이디가 존재하지 않습니다.")
	history.back();
	</script><%
}
%>



</body>
</html>