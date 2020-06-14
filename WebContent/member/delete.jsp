<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
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
request.setCharacterEncoding("utf-8");
String id = (String)session.getAttribute("id");

if(id==null) {
	response.sendRedirect("login.jsp");
}

String pass = request.getParameter("pass");

MemberBean mb = new MemberBean();

mb.setId(id);
mb.setId(pass);

MemberDAO md = new MemberDAO();

int check = md.usercheck(id, pass);

if(check==1) {
	
	
	md.updateMember(mb);
	%><script type="text/javascript">			
	alert("회원정보가 삭제되었습니다.")
	location.href="../main/main.jsp"
	</script><%
// 	response.sendRedirect("../main/main.jsp");
	
}else if(check==0) {
	
	%><script type="text/javascript">			
	alert("비밀번호가 일치하지 않습니다.")
	history.back();
	</script><%
	
	
}else if(check==-1) {
	
	%><script type="text/javascript">
	alert("아이디가 존재하지 않습니다.")
	history.back();
	</script><%
}
%>
</body>
</html>