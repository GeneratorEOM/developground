<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@page import="java.sql.Timestamp"%>
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
String name = request.getParameter("name");
Timestamp reg_date = new Timestamp(System.currentTimeMillis());
String email = request.getParameter("email");
String postcode = request.getParameter("postcode");
String address = request.getParameter("address");
String address2 = request.getParameter("address2");
String address3 = request.getParameter("address3");
String phone = request.getParameter("phone");
String mobile = request.getParameter("mobile");

MemberBean mb = new MemberBean();

mb.setId(id);
mb.setPass(pass);
mb.setName(name);
mb.setEmail(email);
mb.setAddress(postcode+" / "+address+" / "+address2+" / "+address3);
mb.setPhone(phone);
mb.setMobile(mobile);

MemberDAO md = new MemberDAO();

int check = md.usercheck(id, pass);

if(check==1) {
	
	md.updateMember(mb);		
	%><script type="text/javascript">			
	alert("회원정보가 수정되었습니다.")
	location.href='info.jsp'
	</script><%
	
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