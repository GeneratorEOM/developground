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

<style type="text/css">



.table01 {

	border-color: gray;
	border: 1px solid;
	width: 700px;
    margin:20px; auto 0 auto;
    margin-bottom: 20px;
    line-height: 30px;
    padding: 10px;
}
textarea {
	margin: 0;
	padding: 10px;
	font-size: 10pt;
	resize: none;
}
.table01 th {
	text-align: left;
}
.table01 td.tboard {
	text-align: left;
}
.table01 td.tdate {
	font-size: 0.9em;
	text-align: right;
}

.table01 td.tname {
	font-size: 0.9em;
}
.table01 td.tread {
	width: 80px;
	border-spacing: 0;
	margin-left: 100px;
	font-weight: bold;
	font-size: 0.9em;
	border-right: 1px dotted;
	padding: 0;
	margin: 0;
}
.table01 td.tup {
	
	padding: 0;
	padding-left: 13px;;
	margin-right: 500px;;
	font-weight: bold;
	color: red;
	font-size: 0.9em;
	
}
.table01 td input {
	width: 400px;
	font-size: 16px;
	border: none;
	border-bottom: 1px solid;
	outline: none;


	
}
#buttons .submit,#buttons .cancel{
	height: 30px; width: 120px; border: 1px solid;
	font-size: 17px;
	font-weight: bold;
	margin-top: 20px;
	margin-left: 270px;
	margin-bottom: 100px;
}
#buttons .submit{
	
background-repeat: repeat-x;
background-position: center center;
}
#buttons .cancel{margin: 0 0 0 20px;
background-repeat: repeat-x;
background-position: center center;
}

</style>
<script type="text/javascript">
function fun1() {
	
	if(document.fr.file.value=="") {
		alert("파일을 첨부해주세요.")
		return false
	}
	if(document.fr.subject.value.length>11) {
		alert("제목은 10자 이내로 작성해주세요")
		return false
	}
	
}
</script>
<!--[if IE 6]><link href="default_ie6.css" rel="stylesheet" type="text/css" /><![endif]-->

</head>

<body>
<%
String id = (String)session.getAttribute("id");

if(id==null) {
	
	response.sendRedirect("../member/login.jsp");
}
%>
<div id="page" class="container">
<jsp:include page="../inc/top.jsp" />
	<div id="main">
		<div id="banner">
			<img src="../images/main2.png" alt="" class="image-full" />
		</div>
		<div id="welcome">
			<div class="title">
				<h2 style="margin-bottom: 20px;">글쓰기</h2>
				<span class="byline">다양한 개발자들과 자유롭게 소통할 수 있습니다 :)</span>
			</div>
		</div>
		

<%
request.setCharacterEncoding("utf-8");

MemberDAO mdao = new MemberDAO();
MemberBean mb = mdao.getMember(id);

%>
<form action="writePro.jsp" method="post" name="fr" enctype="multipart/form-data" onsubmit="return fun1()">
<input type="hidden" value="<%=mb.getId()%>" name="name">
<table class="table01">
	<tr class="tr01">
		<th>작성자</th>
		<td colspan="2" class="tname" ><%=mb.getId()%></td>
	</tr>
	<tr>
		<th class="ttitle">제목</th>
		<td><input type="text" name="subject"></td>
	</tr>
	<tr>
		<th>파일첨부</th>
		<th><input type="file" name="file"></th>
	</tr>
	<tr>
	<tr class="tr03">
		<td colspan="2" class="content"><textarea name="content" rows="30" cols="100"></textarea></td>		
	</tr>

</table>
<div id="buttons">
<input type="submit" value="확인" class="submit" onclick="return fun1()">
<input type="button" value="취소" onclick="location.href='list.jsp'" class="cancel">
</div>
</form>



<jsp:include page="../inc/bottom.jsp"/>
	</div>
</div>
</body>
</html>