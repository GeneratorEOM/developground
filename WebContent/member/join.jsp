<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/join.css" rel="stylesheet">
<script src="http://code.jquery.com/jquery-1.12.1.js"></script>

<script type="text/javascript">
function fun1() {
	
	var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;

	if(document.fr.id.value=="") {
		alert("아이디를 입력하세요.")			
		document.fr.id.focus()
		return false		
	}
	if(document.fr.hid.value!=document.fr.id.value) {
		alert("중복확인을 진행해주세요.")
		return false
	
	}
	if(document.fr.pass.value=="") {
		alert("비밀번호를 입력하세요.")
		document.fr.pass.focus()
		return false
	}
	if(document.fr.pass.value!=document.fr.pass2.value) {
		alert("비밀번호가 일치하지 않습니다.")
		document.fr.pass2.focus()
		return false
	}
	if(document.fr.name.value=="") {
		alert("이름을 입력하세요.")
		document.fr.name.focus()
		return false
	}
	if(document.fr.email.value=="") {
		alert("이메일을 입력하세요.")
		document.fr.email.focus()
		return false
	}
	if(exptext.test(document.fr.email.value)==false) {
		alert("이메일을 양식에 맞게 작성하세요.")
		document.fr.email.focus()
		return false
	}
	if(document.fr.emailkey.value=="") {
		document.fr.emailkey.focus()
		alert("이메일 인증문자를 입력하세요.")
		document.fr.email.focus()
		return false
	}
	if(document.fr.hemailcheck.value=="") {
		alert("이메일 인증을 진행해주세요.")
		return false
	}
	if(document.fr.hemailkey.value!=document.fr.emailkey.value || document.fr.hemailcheck.value==0) {
		alert("잘못된 인증문자입니다.")
		document.fr.emailkey.focus()
		return false	
	}
	if(document.fr.postcode.value=="") {
		alert("우편번호을 입력하세요.")
		document.fr.postcode.focus()
		return false
	}
	if(document.fr.address.value=="") {
		alert("주소를 입력하세요.")
		document.fr.address.focus()
		return false
	}
	if(document.fr.address2.value=="") {
		alert("상세주소를 입력하세요.")
		document.fr.address2.focus()
		return false
	}
	if(document.fr.address3.value=="") {
		alert("참고항목을 입력하세요.")
		document.fr.address2.focus()
		return false
	}

}

function dup() {
	
	var url = "idCheck.jsp"
	var test = "id="+$("#id").val()
		
if(document.fr.id.value=="") {
	  
	  alert("아이디를 입력하세요")
	  return false
	  
}else {
	

//    alert("데이터 요청!> <");   //서버로부터 데이터 요청
	    $.ajax({    //ajax함수 안에 객체의 형태로 실행명령을 넣는다. 
	         url: url,  //가져오고자하는 서버페이지 주소를 넣는다.
	         type: 'get',  //데이터를 가져온다는 뜻의 get
	         data: test,
	         success : function(t){ 
	        	
	        	 if($(t).text()==0) {
	        		 
	        		 $('input[name=hid]').attr('value',$("#id").val());
	        		 $("#sp1").text("아이디 사용가능").css("color","#9BFF94");
	        		 	        		    		 
	        	 }else if($(t).text()==1) {
	        		 $("#sp1").text("아이디 중복").css("color","#FF0000");
	        		 
	        	 }
	        		
	           },
	          error : function(request,status,error){
	          alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

	          }
	    });		  
  }
	
	
}
function test(t) {

	alert(t)
}
   

var click = false
function fun2() {
	
	var email = "email="+$("#email").val()
	var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
	
	if($("#email2").val()=="") {
		
		alert("이메일을 입력하세요.")
		return false
		
		
	}else if(exptext.test($("#email").val())==false){
		alert("이메일 양식에 맞게 작성하세요.");
		document.fr.email.focus()
		return false
		
	}else{
		
		if(click) {
			alert("메일 전송중입니다.")
			return
		}
		
		click=true
		
		var url = "emailKey.jsp"
	  
// 	        alert("데이터 요청!> <");   //서버로부터 데이터 요청
			    $.ajax({    //ajax함수 안에 객체의 형태로 실행명령을 넣는다. 
			         url: url,  //가져오고자하는 서버페이지 주소를 넣는다.
			         type:'post',  //데이터를 가져온다는 뜻의 get
			         data: email,
			         success : function(t){ 	
			        	 	 click = false
			        	     alert("이메일로 인증문자가 발송되었습니다.")		        				        		
			           },
			          error : function(){
			          alert('연결실패 ㅠㅠ');
			          }
			    });	
	}
}
function fun3() {
	
	var email = "email="+$("#email").val()+"&emailkey="+$("#emailKey").val()
	
	
	if($("#emailKey").val()=="") {
		alert("인증문자를 입력하세요.")
		return false

	}else{
		
		var url = "emailCheck.jsp"
			  
// 	        alert("데이터 요청!> <");   //서버로부터 데이터 요청
			    $.ajax({    //ajax함수 안에 객체의 형태로 실행명령을 넣는다. 
			         url: url,  //가져오고자하는 서버페이지 주소를 넣는다.
			         type:'post',  //데이터를 가져온다는 뜻의 get
			         data: email,
			         success : function(t){ 
			      	        	
			        	 if($(t).text()==0) {
			        		 $('input[name=hemailcheck]').attr('value',1);
			        		 $('input[name=hemailkey]').attr('value',$("#emailKey").val());
			        		 $("#sp2").text("인증되었습니다.").css("color","#9BFF94");
				        	   
			        		 
			        	 }else if($(t).text()==1) {
			        		 $('input[name=hemailcheck]').attr('value',0);
			        		 $("#sp2").text("잘못된 인증문자입니다.").css("color","#FF0000");
			        	 }
			        	  
			        				        		
			           },
			          error : function(){
			          alert('연결실패 ㅠㅠ');
			          }
			    });	
	}
}
</script>
</head>
<body>

<article >
<a href="../main/main.jsp"><img src="../images/logo.png" width="140" alt=""></a>
<h1>회원가입</h1>
<form action="joinPro.jsp" method="post" id="join" name="fr" onsubmit="return fun1()">
<fieldset>
<legend>필수입력사항</legend>
<label >아이디</label>
<input type="hidden" name="hid" id="hid">
<input type="text" name="id" id="id">
<input type="button" value="중복확인" onclick="return dup()"><br>

<label></label>
<span id="sp1"></span><br>

<label>비밀번호</label>
<input type="password" name="pass"><br>
<label>비밀번호 재확인</label>
<input type="password" name="pass2"><br>
<label>이름</label>
<input type="text" name="name"><br>
<label>이메일</label>
<input type="email" name="email" id="email">
<input type="button" value="인증문자받기" onclick="return fun2()"><br>
<label>이메일 인증문자</label>
<input type="hidden" name="hemailcheck"  id="hemailcheck">
<input type="hidden" name="hemailkey"  id="hemailKey">
<input type="text" name="emailkey" id="emailKey">
<input type="button" value="인증문자확인" onclick="return fun3()"><br>
<label></label>
<span id="sp2"></span><br>
<label>주소</label>
<input type="text" id="sample6_postcode" placeholder="우편번호" name="postcode">
<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="dup"><br>
<label></label>
<input type="text" id="sample6_address" placeholder="주소" name="address"><br>
<label></label>
<input type="text" id="sample6_detailAddress" placeholder="상세주소" name="address2" >
<input type="text" id="sample6_extraAddress" placeholder="참고항목" name="address3"><br>
</fieldset>

<fieldset >
<legend>선택입력사항</legend>

<jsp:include page="post.jsp"/>
<label>휴대전화</label>
<input type="text" name="phone"><br>
<label>집전화</label>
<input type="text" name="mobile"><br>
</fieldset>
<div class="clear"></div>
<div id="buttons">
<input type="submit" value="완료" id="submit" class="submit">
<input type="button" value="취소" class="cancel" onclick="location.href='login.jsp'">
</div>
</form>
</article>
</body>
</html>