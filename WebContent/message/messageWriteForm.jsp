<%@page import="member.MemberBean"%>
<%@page import="java.util.List"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    request.setCharacterEncoding("utf-8");
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>



<script src="http://code.jquery.com/jquery-1.12.1.js"></script>
<script>
function back() {
	history.back()
}
function check() {
	
	if(document.fr.id.value == document.fr.hid.value) {
		
		alert("자신에게는 보낼 수 없습니다.")
		return false
	}

}

$(function(){
   
 $('#dup').on('click',function(){
	  
	  if($("#id").val()=="") {
		  
		  alert("아이디 입력하세요")
		  
	  }else {
		  	var url = "search.jsp"
//        alert("데이터 요청!> <");   //서버로부터 데이터 요청
		    $.ajax({    //ajax함수 안에 객체의 형태로 실행명령을 넣는다. 
		         url: url,  //가져오고자하는 서버페이지 주소를 넣는다.
		         type:'get',  //데이터를 가져온다는 뜻의 get
		         data: {id:$("#id").val()},
		         success : function(t){ 
		        	 
		        	 if($(t).text()==0) {
		        		 
		        		 $("span").text("존재하지 않는 사용자입니다.").css("color","#FF0000");		        		
		        		    		 
		        	 }else if($(t).text()==1) {
		        		 $("span").text("존재하는 사용자입니다.").css("color","#088A08");
		        		 
		        	 }
		        		
		           },
		          error : function(){
		          alert('연결실패 ㅠㅠ');
		          }
		    });		  
	  }
   });
});
function change(a) {
	
	sel = a[a.selectedIndex].value;
	document.fr.receive_id.value = sel; 

}
</script>
</head>
<body style="background-color: #f2f5ce">
<%
String replyId = request.getParameter("replyId");


%>

<fieldset style="margin-top: 30px; background-color:  white;">
<legend style="text-align: center; color: black; font-size: 16pt; margin-bottom: 5px;">쪽지 보내기</legend>

<form action="messageWritePro.jsp" method="get" name="fr" onsubmit="return check()">
<input type="hidden" name="hid" value="<%=session.getAttribute("id")%>">
<table style="margin-top: 10px; margin-bottom: 20px;">

	<tr><th align="left">받는 이</th>
	<td>
	<%

if(replyId==null) {
	
	%><input type="text" id="id" name="receive_id" value=""><%
}else {
	
	%><input type="text" id="id" name="receive_id" value="<%=replyId %>" ><%
}
	%>
	<input type="button" value="확인" id="dup">
	<select name="sel" style="height: 20px;" onchange="change(this)">
	<option selected="selected">찾아보기</option>
	<%
	MemberDAO mdao = new MemberDAO();

	List idList = mdao.getIdList();
	
	for(int i=0;i<idList.size();i++) {
		MemberBean mb = (MemberBean)idList.get(i);
		%><option value="<%=mb.getId()%>"><%=mb.getId()%></option><%		
	}	
	%>
	</select>
	</td>
	</tr>
	<tr><td colspan="2" style="padding-left: 65px;"><span></span></td></tr>
	
	<tr><th align="left">제목 </th><td><input type="text" name="subject"></td></tr>
	<tr>
		<th align="left">내용 </th>
		<td><textarea name="content" cols=35 rows=15></textarea></td>
	</tr>	
</table>
<input type="submit" value="보내기" class="submit" style="margin-left: 150px;">
<input type="button" value="뒤로가기" id="write" onclick="back()" style="margin-bottom: 10px;">
</form>
</fieldset>

</body>
</html>