<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/login.css" rel="stylesheet">
<script type="text/javascript">
function login() {
	
	if(document.fr.id.value=="") {
		alert("아이디를 입력하세요.")
		return false
	}
	if(document.fr.pass.value=="") {
		alert("비밀번호를 입력하세요.")
		return false
	}
}

</script>
</head>
<body>

<form action="loginPro.jsp" id="login-form" method="post" name="fr" onsubmit="return login()">
<div id="img">
	<a href="../main/main.jsp"><img src="../images/logo.png" width="140" alt=""></a>
</div>
<label class="legend">아이디</label>
<input type="text" name="id" style="font-size:20px;">
<label class="legend">비밀번호</label> 
<input type="password" name="pass" style="font-size:20px;">
<div id="sub">
<input type="submit" value="로그인" style="font-size: 20px;">
</div>
<div id="join">
<a href="join.jsp" class="join" style="margin-left: 120px;">회원가입</a> ㅣ <a href="../main/main.jsp" class="join" style="margin: 0;">취소</a>
</div>
</form>

</body>
</html>