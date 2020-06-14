<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
 

<!DOCTYPE html>
<html>
<head>
  <script src="http://code.jquery.com/jquery-latest.js"></script>
      <script>
    
      $(function(){
    	   
    	  $('#upd').on('click',function(){
    	 	  
					var param = "num="+${param.num}+"&content="+$("#content").val()
    	 		  	var url = "commentUpdatePro.jsp"
//    	         alert("데이터 요청!> <");   //서버로부터 데이터 요청
    	 		    $.ajax({    //ajax함수 안에 객체의 형태로 실행명령을 넣는다. 
    	 		         url: url,  //가져오고자하는 서버페이지 주소를 넣는다.
    	 		         type:'get',  //데이터를 가져온다는 뜻의 get
    	 		         data: param,
    	 		         success : function(t){ 
    	 		        	    	 		        		 
    	 		        		alert("수정되었습니다.")	
    	 		        		window.opener.document.location.reload();
    	 		        		window.close()
    	 		        	
    	 		           },
    	 		          error : function(){
    	 		          alert('연결실패 ㅠㅠ');
    	 		          }
    	 		    });		  
    	 	  
    	    });
    	 });
    </script>
<meta charset="UTF-8">
    <title> 댓글 답변 </title>

  

    
</head>
<body onresize="parent.resizeTo(500,400)" onload="parent.resizeTo(800,800)">
<fieldset style="margin-top: 30px; margin-bottom: 30px;">
<legend style="text-align: center; font-size: 16pt; margin-top: 20px; margin-bottom: 20px;">댓글수정</legend>
<textarea rows="8" cols="60" name="comment_content" id="content"></textarea>
<input style="margin-left: 170px; margin-top: 20px;" type="button" value="수정" id="upd">
<input type="button" value="창닫기" onclick="window.close()">
</fieldset>

</body>
</html>