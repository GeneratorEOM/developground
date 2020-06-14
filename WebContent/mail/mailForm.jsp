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
<link href="https://fonts.googleapis.com/css?family=East+Sea+Dokdo&display=swap" rel="stylesheet">
<link href="../css/default.css" rel="stylesheet" type="text/css" media="all" />
<link href="../css/fonts.css" rel="stylesheet" type="text/css" media="all" />
<!-- <link href="../css/info.css" rel="stylesheet" type="text/css" media="all" /> -->

<style>
	table{
		border: 1px solid;
		width : 500px;
		margin : auto;
		margin-bottom: 50px;
	}
	h2{
		text-align: center;
		margin-bottom: 20px;]
	}
	td{
		border : 1px solid gray;
		
	}
	th{
		border : 1px solid gray;
		text-align: left;
	}
	input {
		border: none;
		outline:none;
	}
	textarea {
 		resize: none; 
 		border: none; 
 		outline:none; 
	}
	#buttons .submit{

	height: 30px; width: 110px; border: 1px solid;
	font-size: 15px;
	font-weight: bold;
	margin-top: 0;
	margin-left: 350px;
	margin-bottom: 100px;
	background-repeat: repeat-x;
	background-position: center center;
}
</style>
<!--[if IE 6]><link href="default_ie6.css" rel="stylesheet" type="text/css" /><![endif]-->
<script type="text/javascript">

var click = true
function fun1() {
	
	var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
	
	if(<%=session.getAttribute("id")%>==null) {
		//alert("로그인 후 이용하실 수 있습니다.")
		//return false
	}
	if(document.fr.sender.value=="") {
		
		alert("이메일을 입력하세요.")
		document.fr.sender.focus()
		return false		
	}
	if(exptext.test(document.fr.sender.value)==false){
		alert("이메일 양식에 맞게 작성해주세요.");
		document.fr.sender.focus()
		return false
	}
	if(document.fr.content.value="") {
		document.fr.content.focus()
		alert("내용을 입력하세요")
		return false
	}
	if(!click) {
		alert("메일 전송중입니다.")
	}
	if(click) {
		
		click = false		
		setTimeout(function () {
                click = true;
            }, 5000)
	}

	
}

</script>
</head>

<body>
<%

String id = (String)session.getAttribute("id"); 

MemberDAO md = new MemberDAO();

MemberBean mb = md.getMember(id);

%>
<div id="page" class="container">
<jsp:include page="../inc/top.jsp" />
	<div id="main">
			<img src="../images/main2.png" alt="" class="image-full" />
			<div class="title">
				<h2 style="margin-bottom: 20px;">건의사항</h2>
				<span class="byline"><b>우리 커뮤니티에 대한 의견을 자유롭게 보내주세요 :)</b></span>
			</div>
	
<form action="mailSend.jsp" method="post" name="fr" onsubmit="return fun1()">
<table style="border: 1px solid; line-height: 30px; font-size: 14pt; width: 700px; height: 200px; margin: 50px;">
	<tr><th style="text-align: center;">메일주소</th><td style="margin: 0; padding: 0;"><input type="text" name="sender" placeholder="입력하신 메일로 답변을 받아보실 수 있습니다" style="padding-left: 5px; width: 550px; font-size: 12pt;"></td></tr>
	<tr>
		<th width="100" style="text-align: center;">내용</th>
		<td><textarea name="content" cols=60 rows=15 style="padding: 5px; font-size: 12pt;"></textarea></td>
	</tr>

</table>
	<div id="buttons">
	<input type="submit" value="보내기" class="submit" >
	</div>
</form>

<jsp:include page="../inc/bottom.jsp"/>
	</div>
</div>
</body>
</html>