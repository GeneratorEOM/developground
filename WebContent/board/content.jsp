<%@page import="board.CommentBean"%>
<%@page import="board.CommentDAO"%>
<%@page import="board.CommentDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
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

	border-color: red;
	border: 1px solid;
	width: 700px;
    margin:20px; auto 0 auto;
    margin-bottom: 50px;
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
.table01 th.title {
	width: 150px;
}
.tdate {
	
	font-size: 0.9em;
	text-align: right;
}
.table01 tr.tr01 {
	border-bottom: 1px solid;
}
.table01 td.tname {
	font-size: 0.9em;
	border-top: 1px solid;
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
.table01 tr.comment_tr {
	border: 1px solid;
}
#buttons .submit,#buttons .cancel{
	height: 30px; width: 120px; border: 1px solid;
	font-size: 17px;
	font-weight: bold;
	margin-top: 20px;
	margin-left: 200px;
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


<script src="http://code.jquery.com/jquery-1.12.1.js"></script>

<script type="text/javascript">

function like(id) {

	var board = "board="+${param.num}
	var url = "likePro.jsp"
		
	if(id=='null') {
		alert("로그인 후 이용하세요.")
		return false
		
	}else{
				
// 	 	alert("데이터 요청!");   //서버로부터 데이터 요청
	 	$.ajax({    //ajax함수 안에 객체의 형태로 실행명령을 넣는다. 
	 		url: url,  //가져오고자하는 서버페이지 주소를 넣는다.
	        type:'get',  //데이터를 가져온다는 뜻의 get
	        data: board,
	        success : function(t){ 
				    
	        	 var textString = $(t).text().split("/");
				 		
	        		 if(textString[0]==0) {
				        		 
				     	 alert("취소!!");
				  		 $("#like2").text(textString[1]).css("color", "red");
				        		 
			       	 }else{
		        		 alert("추천!!");
		        		 $("#like2").text(textString[1]).css("color", "red");
				        		 
			     	 }				        	
		          },
		          
	         error : function(){
				          alert('연결실패 ㅠㅠ');
			          }
		});
		
	}
}
function del(num) {
	
	var num = "num="+num
 	var url = "commentDelete.jsp"	
 	 	
// 	 	alert("데이터 요청!");   //서버로부터 데이터 요청
	 	$.ajax({    //ajax함수 안에 객체의 형태로 실행명령을 넣는다. 
	 		url: url,  //가져오고자하는 서버페이지 주소를 넣는다.
	        type:'get',  //데이터를 가져온다는 뜻의 get
	        data: num,
	        success : function(t){ 
	        		a = confirm("삭제하시겠습니까?")
	        		if(a) {
	        			 location.reload();
	        		}
				    
			        	
		          },
	         error : function(){
				          alert('연결실패 ㅠㅠ');
			          }
		});
}

	   



function upd(num) {
window.open("commentUpdateForm.jsp?num="+num,"scrollbars=no","resizable=no");

}

function writeCmt() {
	
	var param = "num="+$('#comment_board').val()+"&content="+$('#comment_content').val();
 	var url = "commentPro.jsp"	
 	 	
 		if($('#comment_content').val()=="") {
 			
 			alert("내용을 입력하세요.")
 			return false
 			
 		}else{
 			
//  			$("#comment").click(function(){
 			 	
// 		 	 	alert("데이터 요청!");   //서버로부터 데이터 요청
 			 	$.ajax({    //ajax함수 안에 객체의 형태로 실행명령을 넣는다. 
 			 		url: url,  //가져오고자하는 서버페이지 주소를 넣는다.
 			        type:'get',  //데이터를 가져온다는 뜻의 get
 			        data: param,
 			        success : function(t){ 
 			        	       		 
 				     	 alert("댓글이 입력되었습니다.");
 				     		location.reload();
					        	
 				          },
 			         error : function(){
 						          alert('연결실패 ㅠㅠ');
 					          }
 				});
 			
 		}

 }
function delboard(num) {
	
	a = confirm("삭제된 게시글을 복구되지 않습니다.\n삭제하시겠습니까?")
	if(a) {
		location.href='deletePro.jsp?num='+num;
	}
		
}

</script>
</head>

<body>

<div id="page" class="container">
<jsp:include page="../inc/top.jsp" />
	<div id="main">
		<div id="banner">
		<img src="../images/main2.png" alt="" class="image-full" />
		</div>
		<div id="welcome">
			<div class="title">
				<h2 style="margin-bottom: 20px;">게시글</h2>
				<span class="byline">다양한 개발자들과 자유롭게 소통할 수 있습니다 :)</span>
			</div>
		</div>
		

<%
request.setCharacterEncoding("utf-8");
int num = Integer.parseInt(request.getParameter("num"));
String id = (String)session.getAttribute("id");
BoardDAO bdao = new BoardDAO();
Cookie[] cookies = request.getCookies();
if(cookies==null){
					
	Cookie cookie = new Cookie("cook", id+num);
	cookie.setMaxAge(86400);
	response.addCookie(cookie);
	bdao.getReadcount(num);
						
}else {
					
	int check = 0;
					
	for(int i=0;i<cookies.length;i++){
						
		if(cookies[i].getValue().equals(id+num)){
							
			check = 1;		
		}
	}
					
	if(check==0) {
						
		Cookie cookie = new Cookie("cook", id+num);
		cookie.setMaxAge(86400);
		response.addCookie(cookie);
		bdao.getReadcount(num);
	}			
}

BoardBean bb = bdao.getBoard(num);
				

%>
<table class="table01">
	<tr class="tr01">
		<th class="ttitle" colspan="2"><%=bb.getSubject()%></th>
		<td class="tdate"><%=bb.getReg_date()%></td>
	</tr>
	
	<tr class="tr02">
		<td colspan="3" class="tname"><%=bb.getId()%></td>
	</tr>
	
	<tr class="tr03">
		<td colspan="3" class="content"><textarea name="content" rows="25" cols="100" readonly="readonly"><%=bb.getContent()%></textarea></td>		
	</tr>

	<tr class="tr04">
		<td class="tread" >조회수  <%=bb.getReadcount()%> </td> 
		<td class="tup" colspan="2"><span id="like2" style="font-size: 18px;"><%=bb.getBoard_like() %></span><a  href="javascript:void(0); onclick=like('<%=id %>')" style="text-decoration:none; "><img src="../images/like.PNG" width="55" height="55"></a></td>
	</tr>
 
<%

 CommentDAO cdao = new CommentDAO();

 //게시판글개수 getBoardCount() count(*) 호출
 //int count = getBoardCount();

 int count = cdao.getCommentCount(num);

 //한 화면에 보여줄 가져올 글 개수 설정
 int pageSize = 5;

 //현 페이지 번호 가져오기 pageNum 파라미터 가져오기

 String pageNum = request.getParameter("pageNum");
 //현페이지 번호가 없으면 "1" 페이지로 설정

 if(pageNum==null) {
 	pageNum = "1";
 }

 //10개씩 잘라서 1페이지 시작하는 행번호 구하기

 int currentPage = Integer.parseInt(pageNum);
 //10개씩 잘라서 1페이지 시작하는 행번호 구하기
 //pageNum(currentPage) 		pageSize		startRow 시작행번호
 //			1						10				1
 //			2						10				11
 //			3						10				21
 //			4						10				31
 int startRow = (currentPage-1)*pageSize+1;
 int endRow = currentPage*pageSize;


 //List boardList = bdao.getBoardList(시작하는행번호, 글개수);
 //select * from board order by num desc limit 시작하는행번호-1, 글개수

 

 int pageCount = count/pageSize + (count%pageSize == 0 ? 0 : 1);

 int pageBlock=10;

 int startPage = (currentPage-1)/pageBlock*pageBlock+1;


 int endPage=startPage+pageBlock-1;

 if(endPage > pageCount){
 	endPage=pageCount;
 	
 }
 %>

    <!--             로그인 했을 경우만 댓글 작성가능 -->
<% if(id!=null) {
            	
                    	
	%>

    <tr bgcolor="#E4E4E4">        

    <td width="150"><%=id %>     <input type="hidden" name="comment_board" id="comment_board" value="<%=bb.getNum()%>">
    <input type="hidden" name="comment_id" value="<%=id%>">     </td>
    
    <td width="450"><textarea name="comment_content" id="comment_content" rows="5" cols="70"  ></textarea></td>           
    <td width="400">
        <div id="btn" style="text-align:center;">
       		 <p><input type="button" value="댓글" id="comment" onclick="return writeCmt()" style="width: 95px; height: 98px; font-size: 20px;"></p>    
        </div>
    </td>
    </tr>
  
<%           	           	
}           
%>
<tbody id="tbody">
<%

List commentList = cdao.getCommentList(startRow, pageSize, num);

for(int i=0;i<commentList.size();i++) {
	CommentBean cb = (CommentBean)commentList.get(i);
	
	%>

<tr  bgcolor="#F6F6F6">
<td  width="150" height="40">
<div>&nbsp;&nbsp;<%=cb.getId() %><br></div>
</td>

<td width="550">
<div class="text_wrapper">&nbsp; &nbsp;<%=cb.getContent() %></div>
</td>

<td width="100">
<div id="btn" style="width: 100px; text-align: center; font-size: 11pt; "> 
 	<%
 	if(cb.getId().equals(id)) {
 		
 		
 		%>
		<input type="button" value="수정" id="up" onclick="return upd(<%=cb.getNum() %>)">                	    
		<input type="button" value="삭제" id="del" onclick="return del(<%=cb.getNum() %>)"> 		
 		<%
 		
 		
 	}
 	%>                
</div>
</td>
</tr>

		
	<%	
}
%> 
</tbody>
        
<tr>
<td colspan="3" style="text-align: center;">

 <%

if(startPage > pageBlock){
	%>
	<a href="content.jsp?num=<%=bb.getNum()%>&pageNum=<%=startPage-pageBlock%>">[이전]</a>
	<%
}

//1~ 10  11~20   startPage  ~ endPage
for(int i=startPage;i<=endPage;i++){
	%> 
	<a href="content.jsp?num=<%=bb.getNum()%>&pageNum=<%=i%>"><%=i%></a> 
	<%
}

//[다음] 10페이지 다음
if(endPage < pageCount){
	%> 
	<a href="content.jsp?num=<%=bb.getNum()%>&pageNum=<%=startPage+pageBlock%>">[다음]</a>
	 <%
}
%>

</td>

</tr>

</table>
<div id="buttons">
<%
if(bb.getId().equals(id)) {
	
	%>
	<input type="button" value="글수정" onclick="location.href='updateForm.jsp?num=<%=bb.getNum()%>'" class="submit">
	<input type="button" value="글삭제" onclick="return delboard(<%=bb.getNum()%>)" class="cancel">	
	<input type="button" value="글목록" onclick="location.href='list.jsp'" class="cancel" style="text-align: center;  margin-bottom: 50px;">
	
	<%
}else{
	
	%>
		<input type="button" value="글목록" onclick="location.href='list.jsp'" class="cancel" style="text-align: center;  margin-bottom: 50px; margin-left: 340px;">
	
	<%
}
 %>
</div>

<jsp:include page="../inc/bottom.jsp"/>
</div>       
</div>


</body>
</html>