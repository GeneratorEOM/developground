<%@page import="mail.EmailDAO"%>
<%@page import="mail.MailServlet"%>
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

String email = request.getParameter("email");

String emailkey= "";

// 이메일인증 랜덤문자 추출
for(int i=0; i<6; i++) {
	
	int key = (int)(Math.random() * 62);

		if(key < 10) {
	
			emailkey += key;

		} else if(key > 35) {
	
			emailkey += (char)(key + 61);

		} else {
	
			emailkey += (char)(key + 55);

	}
}
// 메일, 인증키 디비저장
EmailDAO edao = new EmailDAO();

edao.insertEmail(email, emailkey);

// 인증키를 입력메일로 보내기
String[] mailArr = {email, "<DevelopGrounds> 이메일 인증번호입니다.", "<h3><DevelopGrounds> 회원가입 이메일 인증번호 </h3> "+emailkey};

MailServlet.main(mailArr);
%>

</body>
</html>