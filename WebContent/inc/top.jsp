<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



			<div id="header">
		<div id="logo">
			<a href="../main/main.jsp"><img src="../images/logo.png" width="170" alt="" /></a>
			
			<%
			
			
			if(session.getAttribute("id")==null) {
				%>
				<h2><a href="../member/login.jsp">Login</a></h2>
				
				<%
			}else{
				
				%>
				<h1><a href="../member/info.jsp"><%=session.getAttribute("id") %></a></h1>
				&nbsp;&nbsp;&nbsp;&nbsp;<span><a href="../member/info.jsp">내정보</a></span><span>I</span>
				<span><a href="#" rel="nofollow" onclick="return fun2()">쪽지함</a></span>
				<span>I</span> <span><a href="../member/logout.jsp" rel="nofollow">로그아웃</a></span> 
				<%
			}
			%>
			
		</div>
		<div id="menu">
			<ul>
				<li><a href="../board_photo/list.jsp"  title=""> 사진게시판</a></li>
				<li><a href="../board_file/list.jsp"  title="">자료게시판</a></li>
				<li><a href="../board/list.jsp" title="">자유게시판</a></li>
				<li><a href="../mail/mailForm.jsp"  title="">건의사항</a></li>
				<li><a href="" onclick="fun4()" title=""><img alt="" src="../images/chat.PNG" style="width: 120px; height: 120px; border-radius: 60px;"></a></li>
			</ul>
		<script type="text/javascript">
		
		function fun2() {
			
			window.open("../message/messageSendList.jsp","Message","scrollbars=no,resizable=no")
		}
		function fun4() {
			
			window.open("http://localhost:3000","chat","scrollbars=no,resizable=no")
		}
		</script>
		</div>
		
	</div>
	
    

