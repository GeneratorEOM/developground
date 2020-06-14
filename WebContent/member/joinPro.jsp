
<%@page import="mail.EmailDAO"%>
<%@page import="mail.EmailBean"%>
<%@page import="mail.MailServlet"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="mail.GoogleAuthentication"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Session"%>
<%@page import="com.sun.net.httpserver.Authenticator"%>
<%@page import="java.util.Properties"%>
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
<!-- member/joinPro.jsp-->
<%
// request 한글처리
request.setCharacterEncoding("utf-8");
// request 저장된 파라미터 값 가져와서 변수에 저장
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String name = request.getParameter("name");
Timestamp reg_date = new Timestamp(System.currentTimeMillis());
String email = request.getParameter("email");
String emailkey = request.getParameter("emailkey");
String postcode = request.getParameter("postcode");
String address = request.getParameter("address");
String address2 = request.getParameter("address2");
String address3 = request.getParameter("address3");
String phone = request.getParameter("phone");
String mobile = request.getParameter("mobile");

// 패키지 member 파일이름 memberBean
// 파라미터 값을 저장하는 변수 만들고 set, get 메서드 만들기
// MemberBean mb 객체 생성 => 기억장소 만들기
MemberBean mb = new MemberBean();
// mb 에 파라미터값 저장
mb.setId(id);
mb.setPass(pass);
mb.setName(name);
mb.setReg_date(reg_date);
mb.setEmail(email);
mb.setAddress(postcode+" / "+address+" / "+address2+" / "+address3);
mb.setPhone(phone);
mb.setMobile(mobile);

// 패키지 member 파일이름 MemberDAO	  리턴값 없음 insertMember(자바빈) 메서드 만들기


// MemberDAO mdao 객체 생성
MemberDAO mdao = new MemberDAO();
// insertMember() 메서드 호출
mdao.insertMember(mb);

// "회원가입성공" 메일보내고 login.jsp 이동
String[] mailArr = {email, "<DevelopGrounds> 회원가입을 축하합니다", "<DevelopGrounds> 회원가입을 축하합니다"};

MailServlet.main(mailArr);

EmailDAO edao = new EmailDAO();
EmailBean eb = new EmailBean();

eb.setEmail(email);
eb.setEmail_key(emailkey);
edao.deleteEmail(eb);

%>
<script type="text/javascript">
	alert("회원가입을 축하합니다.")
	location.href="login.jsp";
</script>
<%
%>
</body>
</html>