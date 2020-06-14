<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
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

int check=0;

MemberDAO mdao = new MemberDAO();

MemberBean mb = mdao.getMember(id); 

try{
	
	if(mb.getId()==null) {
		
		check=0;
		out.write(check+"");
		
	}else {
		check=1;
		out.write(check+"");
	}
	
}catch(Exception e){
	
}

%>


</body>
</html>