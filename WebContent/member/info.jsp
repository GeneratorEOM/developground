<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>

<!--
Design by TEMPLATED
http://templated.co
Released for free under the Creative Commons Attribution License

Name       : Skeleton 
Description: A two-column, fixed-width design with dark color scheme.
Version    : 1.0
Released   : 20130902

-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="http://fonts.googleapis.com/css?family=Source+Sans+Pro:200,300,400,600,700,900" rel="stylesheet" />
<link href="../css/default.css" rel="stylesheet" type="text/css" media="all" />
<link href="../css/fonts.css" rel="stylesheet" type="text/css" media="all" />
<link href="../css/info.css" rel="stylesheet" type="text/css" media="all" />

<script type="text/javascript">


function fun1(a) {
	
	if(a==1) {
		
		if(document.fr.pass.value=="") {
			alert("비밀번호를 입력하세요.")
			return false
		}
		document.fr.action='update.jsp'
		
	}else if(a==2) {
		
		c=confirm("삭제된 회원정보는 복구되지 않습니다. 삭제하시겠습니까?")
		
		if(c) {
			document.fr.action='delete.jsp'	
		}
		
	}
}
</script>

<!--[if IE 6]><link href="default_ie6.css" rel="stylesheet" type="text/css" /><![endif]-->

</head>

<body>
<%
String id = (String)session.getAttribute("id");

if(id==null) {
	response.sendRedirect(request.getHeader("referer"));
}	
%>
<div id="page" class="container">
<jsp:include page="../inc/top.jsp" />
	<div id="main">
		<div id="banner">
			<img src="../images/main2.png" alt="" class="image-full" /></div>
		<div id="welcome">
			<div class="title">
				<h2 style="margin: 20px;">내 정보</h2>
				<span class="byline"><b>내 정보를 확인하고 수정할 수 있습니다 :)</b></span>
			</div>
		</div>
		

<%


MemberDAO md = new MemberDAO();

MemberBean mb = md.getMember(id);

String div_add[] =  mb.getAddress().split(" / ");

%>
<article>
<form method="post" id="join" name="fr">
<fieldset>
<legend>필수입력사항</legend>
<label >아이디</label>
<input type="text" name="id" value="<%=mb.getId()%>"><br>
<label>비밀번호</label>
<input type="password" name="pass" ><br>
<label>이름</label>
<input type="text" name="name" value="<%=mb.getName()%>"><br>
<label>이메일</label>
<input type="email" name="email" value="<%=mb.getEmail()%>"><br>
</fieldset>

<fieldset>
<legend>선택입력사항</legend>
<label>주소</label>
<%
if(div_add.length==0) {
	
	
	
	%>
	<input type="text" id="sample6_postcode" placeholder="우편번호" name="postcode" value="">
<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="dup" ><br>
<label></label>
<input type="text" id="sample6_address" placeholder="주소" name="address" value=""><br>
<label></label>
<input type="text" id="sample6_detailAddress" placeholder="상세주소" name="address2" value="">
<input type="text" id="sample6_extraAddress" placeholder="참고항목" name="address3" value=""><br>
	
	
	<%

}else {
		
	%>
	<input type="text" id="sample6_postcode" placeholder="우편번호" name="postcode" value="<%=div_add[0]%>">
<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="dup" ><br>
<label></label>
<input type="text" id="sample6_address" placeholder="주소" name="address" value="<%=div_add[1]%>"><br>
<label></label>
<input type="text" id="sample6_detailAddress" placeholder="상세주소" name="address2" value="<%=div_add[2]%>">
<input type="text" id="sample6_extraAddress" placeholder="참고항목" name="address3" value="<%=div_add[3]%>"><br>
	
	<%

	
	
	
	
}


%>

<jsp:include page="post.jsp"/>
<label>휴대전화</label>
<input type="text" name="phone" value="<%=mb.getPhone()%>"><br>
<label>집전화</label>
<input type="text" name="mobile" value="<%=mb.getMobile()%>"><br>
</fieldset>
<div class="clear"></div>
<div id="buttons">
<input type="submit" value="정보수정" class="submit2" onclick="return fun1(1)">
<input type="submit" value="회원탈퇴" class="cancel" onclick="return fun1(2)">
<input type="button" value="취소"  class="cancel"  onclick="location.href='../main/main.jsp'">
</div>
</form>
</article>



<jsp:include page="../inc/bottom.jsp"/>
	</div>
</div>
</body>
</html>