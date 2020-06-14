<%@page import="java.text.SimpleDateFormat"%>
<%@page import="message.MessageBean"%>
<%@page import="message.MessageDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title></title>
	<style>
		#container {
			width:460px;
			height: 500px;
			margin:0 auto;
			text-align:center;
		}
		.tab {
			list-style: none;
			margin: 0;
			padding: 0;
			overflow: hidden;
		}
		/* Float the list items side by side */
		.tab li {
			float: left;
		}
		/* Style the links inside the list items */
		.tab li a {
			display: inline-block;
			color: #000;
			text-align: center;
			text-decoration: none;
			padding: 14px 16px;
			font-size: 17px;
			transition:0.3s;
		}
		/* Style the tab content */
		.tabcontent {
			display: none;
			background-color: #FAE0D4;
			height: 440px;
			padding: 6px 12px;
			color:#fff;
		}
		ul.tab li.current{
			background-color: #FAE0D4;
			color: #222;
		}
		.tabcontent.current {
			display: block;
		}
		a:link { color: black; text-decoration: none;}
 		a:visited { color: black; text-decoration: none;}
 		a:hover { color: blue; text-decoration: underline;}
 		tr:hover {background-color: #FAE0D4;}
	</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
		$(function() {
			$('ul.tab li').click(function() {
				var activeTab = $(this).attr('data-tab');
				$('ul.tab li').removeClass('current');
				$('.tabcontent').removeClass('current');
				$(this).addClass('current');
				$('#' + activeTab).addClass('current');
			})
		})

function allCheck(obj){
	
	 var chkObj = document.getElementsByName("rowCheck");
	 var rowCnt = chkObj.length - 1;
	 var check = obj.checked;
	 
	      if (check) {﻿
	          for (var i=0; i<=rowCnt; i++){
	           if(chkObj[i].type == "checkbox")
	               chkObj[i].checked = true;
	          }
	      } else {
	          for (var i=0; i<=rowCnt; i++) {
	           if(chkObj[i].type == "checkbox"){
	               chkObj[i].checked = false;
	           }
	          }
	      }
	  } 
function messageDel() {

	var message = "";
	var messageChk = document.getElementsByName("rowCheck");
	var check = false;
	var indexMessage = false;
	var url = "messageReceiveDelete.jsp";
	
	for(i=0;i<messageChk.length;i++) {
		if(messageChk[i].checked) {
			if(indexMessage) {
				message = message + "-";
			}
			message = message + messageChk[i].value;
			indexMessage = true;
		}
	}	
	if(!indexMessage) {
		alert("삭제할 쪽지를 선택하세요.");
		return
	}
	
	var messageList = "message="+message
//     alert("데이터 요청!> <");   //서버로부터 데이터 요청
    $.ajax({    //ajax함수 안에 객체의 형태로 실행명령을 넣는다. 
         url: url,  //가져오고자하는 서버페이지 주소를 넣는다.
         type:'post',  //데이터를 가져온다는 뜻의 get
         data: messageList,
         success : function(t){ 
      	      
      	        location.reload();
      				        		
           },
          error : function(){
          alert('연결실패 ㅠㅠ');
          }
    });	
}
</script>
</head>
<body onload="parent.resizeTo(500,600)">

	<div id="container">
	
		<ul class="tab">
			<li  data-tab="tab1"><a href="messageSendList.jsp">보낸쪽지함</a></li>
			<li class="current" data-tab="tab2"><a href="#">받은쪽지함</a></li>
		</ul>
		



<div id="tab2" class="tabcontent current" >
<fieldset style="margin-top: 20px; background-color: white;">
<legend style="text-align: center; color: black; font-size: 16pt; margin-bottom: 10px;">받은 쪽지</legend>
<table border="1" class="table_wrap" style="border-collapse: collapse; line-height: 30px; text-align: center; color: black; margin-bottom: 10px; margin-top: 20px;">
<tr style="background-color: #FAE0D4;" ><th colspan="5" width="30" style="border-right: 2px; text-align: left; "><input type="checkbox" id="allCheck"  style="margin-left: 8px; margin-right: 7px;" onclick="allCheck(this)"><input type="button" value="삭제" onclick="return messageDel()"></th></tr>    
<%

MessageDAO mdao = new MessageDAO();

String id = (String)session.getAttribute("id");

String pageNum = request.getParameter("pageNum");

int pageSize = 5;



if(pageNum==null) {
	pageNum = "1";
}

int currentPage = Integer.parseInt(pageNum);

int startRow = (currentPage-1)*pageSize+1;
int endRow = currentPage*pageSize;


int count = mdao.getReceiveMessageCount(id);
List boardList = mdao.getReceiveMessageList(id, startRow, pageSize);
SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");

if(boardList.size()==0) {
	
	%>
	 <tr><th colspan="4" width="430">받은 쪽지가 없습니다</th></tr>

	<%
	
}else {

	int num = count-((currentPage-1)*pageSize);

	for(int j=0;j<boardList.size();j++ ) {
		MessageBean mb = (MessageBean)boardList.get(j);
		%>
		
		<tr>
		<td width="30"><input type="checkbox" name="rowCheck" value="<%=mb.getNum()%>"></td>
		<%
		if(mb.getReceive_read()!=0) {
			
			%><td width="40"><%=num-- %> </td><%
		}else{
			
			%><td width="40"><img src="../images/santa.PNG" width="25" height="25" style="text-align: left; padding-top: 5px;"></td><%
		}
		
		%>
		<td width="180" class="left01"><a href="messageContent.jsp?num=<%=mb.getNum()%>&send=1"><%=mb.getSubject()%></a></td>
		<td width="90" class="left01"><%=mb.getSend_id()%></td>
		<td width="90"><%=sdf.format(mb.getDate())%></td>
		</tr>
		
		<%
		
	
	}

}	
%>

</table>

 <input type="submit" value="글쓰기" onclick="location.href='messageWriteForm.jsp'" style="margin-left: 330px; margin-bottom: 10px; margin-top: 10px;"/>
        &nbsp;&nbsp;
<%


pageSize = 5;

int pageBlock=5;

currentPage = Integer.parseInt(pageNum);

int pageCount = count/pageSize + (count%pageSize == 0 ? 0 : 1);
// 한화면에 보여줄 페이지 개수

int startPage = (currentPage-1)/pageBlock*pageBlock+1;


int endPage2 = startPage+pageBlock-1;
//  endPage 10  <=  전체 페이지수 5페이지
if(endPage2 > pageCount){
	endPage2=pageCount;
	
}
%>
<%

if(startPage > pageBlock){
	%>
	<a href="messageReceiveList.jsp?pageNum=<%=startPage-pageBlock%>">[이전]</a> <%
}

//1~ 10  11~20   startPage  ~ endPage
for(int j=startPage;j<=endPage2;j++){
	%> <a href="messageReceiveList.jsp?pageNum=<%=j%>"><%=j%></a> <%
}

//[다음] 10페이지 다음
if(endPage2 < pageCount){
	%> <a href="messageReceiveList.jsp?pageNum=<%=startPage+pageBlock%>">[다음]</a> <%
}
%>

 </fieldset>
		</div>
	</div>


</body>
</html>