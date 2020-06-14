<%@page import="board.file.FileBoardBean"%>
<%@page import="board.file.FileBoardDAO"%>
<%@page import="board.photo.PhotoBoardDAO"%>
<%@page import="board.photo.PhotoBoardBean"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

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


<!--[if IE 6]><link href="default_ie6.css" rel="stylesheet" type="text/css" /><![endif]-->
<style type="">
#sec_news, #news_notice{ float: left; width: 320px;
margin: 15px 0 0 20px}
/*정렬 왼쪽 너비 420px 밖여백 15px 0 0 20px */
#sec_news h3,#news_notice h3{font-family: seo;
font-size: 14px;font-style: italic;font-weight: normal;
width: 420px;height: 24px;
background-image: url("../images/h3_back.jpg");
background-repeat: no-repeat;padding: 5px 0 0 22px;}
/*글자체 seo 크기 14px
스타일 italic 굵기 normal 너비 420px 높이 24px
배경이미지h3_back.jpg 반복no-repeat 안여백 5px 0 0 22px*/
#sec_news dl{margin-left: 6px}/*밖왼쪽여백 6px*/
#sec_news dt{
border-bottom-style: dotted;
font-size: 16px; margin: 5px 0; color: #F00}
/*글자체 Times New roman 글자크기 16px
 밖여백 5px 0 글자색 #F00*/
#sec_news dd{margin-left: 0;color: #333;}
/*밖왼쪽 여백 0 글자색 #333*/
#news_notice table{width: 350px;
border-collapse: collapse; text-align: center;}
/*너비 400px 여백없애기 글자정렬 가운데*/
#news_notice td{padding: 6px 4px;
border-bottom-width: 1px; border-bottom-style: dotted;
border-bottom-color: #999}
/*안여백 6px 4px 
테두리아래너비 1px 테두리아래스타일 dotted
테두리아래색 #999 */
#news_notice td.contxt{
	background-image: url("../images/tr_back.gif");
	background-repeat: no-repeat;
	background-position: left center;
	padding-left: 30px; text-align: left;color: #333}
/*배경이미지 tr_back.gif
반복 no repeat 위치 left center 안왼쪽여백 15px
글자정렬 왼쪽 글자색 #333*/
#news_notice a{color: #333;text-decoration: none;}
/*글자색 #333 밑줄 없음*/
#news_notice a:hover{color: #F90;
text-decoration: none;}/*글자색 #F90 밑줄 none*/
#sec_news h3,#news_notice h3{
font-size: 14px;font-style: italic;font-weight: normal;
width: 420px;height: 24px;
background-image: url("../images/h3_back.jpg");
background-repeat: no-repeat;padding: 5px 0 0 22px;}

</style>

</head>
<body>
<div id="page" class="container">
<jsp:include page="../inc/top.jsp" />
	<div id="main">
	<img src="../images/main2.png" alt="" class="image-full" />
				<div id="welcome">
			<div class="title">
				<h2 style="margin-bottom: 20px;">개발자 커뮤니티</h2>
				<span class="byline"><b>다양한 개발자들과 자유롭게 소통할 수 있습니다 :)</b></span>
			</div>
			
		</div>
		
		
<div id="sec_news">
<h3><span>사진게시판</span></h3>
				
		
<%
// 1행 5개 가져오기
int pageSize = 4;
//BoardDAO bdao 객체생성
PhotoBoardDAO bdao = new PhotoBoardDAO();
//전체 글 개수 설정
int count = bdao.getBoardCount();
//페이지 번호가 없으면 무조건 1

String pageNum = request.getParameter("pageNum");
if(pageNum==null) {
pageNum = "1";
}
//pageNum 정수로 변경
int currentPage = Integer.parseInt(pageNum);
//10개씩 잘라서 시작하는 행번호 구하기
int startRow = (currentPage-1)*pageSize+1;
//BoardList 호출

List boardList = bdao.getBoardList(startRow, pageSize);
	//5단계 rs첫행으로 이동 "num" 열 "subject" "name" "readcount" "date" 출력
// while(rs.next()) {
	
	for(int i=0;i<boardList.size();i++ ) {
		// 한칸의 정보 가져오기
			
		PhotoBoardBean bb = (PhotoBoardBean)boardList.get(i);
		
		if(i%2==0) {
%>
			
			<div style=" float: left; margin: 40px 5px 0px -20px; padding: 0;">
			<table>		
			<tr>
			<td colspan="2" style="width: 140px; height: 120px;"><a href="../board_photo/content.jsp?num=<%=bb.getNum()%>"><img src="../upload/<%=bb.getFile()%>"  width="100%" height="100%"/></a></td>
			</tr>
			<tr>
			<td colspan="2" style="font-size: 11pt;"><%=bb.getSubject() %></td>
			</tr>
			</table>
			</div>
			

			<%
		}else if(i%2==1) {
			
			%>
			<div style="float: left; margin: 40px 0px 0px 5px; ">
			<table>	
			<tr>
			<td colspan="2" style="width: 140px; height: 120px;"><a href="../board_photo/content.jsp?num=<%=bb.getNum()%>"><img src="../upload/<%=bb.getFile()%>"  width="100%" height="100%" /></a></td>
			</tr>
			<tr>
			<td colspan="2" style="font-size: 11pt;"><%=bb.getSubject() %></td>
			</tr>
			</table>
			</div>
			<%	
			

		}
	}

	%>
</div>		
		
		
<div id="news_notice">
<h3><span>자료게시판</span></h3>
<table style="border-collapse: collapse; ">
<%
FileBoardDAO bdao2 = new FileBoardDAO();
pageSize = 5;
List boardList2 = bdao2.getBoardList(startRow, pageSize);
%>

   <%
   	// bb.getNum() 실제 게시판번호 -> 가상카운트 부여
      // 전체 글개수 count    pageNum       pageSize =>     num
      //               30     	  1               10          30-0      
      //               30     	  2               10          30-10
      //               30     	  3               10          30-20
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
      for(int i=0;i<boardList2.size();i++) {
   	   FileBoardBean bb = (FileBoardBean)boardList2.get(i);
   %>	
   <tr>
   <td style="text-align: left; font-size: 11pt; width: 180px;"><a href="../board_file/content.jsp?num=<%=bb.getNum()%>" style="text-align: left;"><%=bb.getSubject() %></a></td>
   <td style=" text-align: right;"><%=bb.getDate()%></td>
   </tr><%
   }
   
   %>
</table>

</div>



<div id="news_notice">
<h3>자유게시판</h3>
<table style=" font-size: 11pt;line-height: 20px; margin-right: 50px; margin-bottom: 100px;"  >

<%
BoardDAO bdao3 = new BoardDAO();

List boardList3 = bdao3.getBoardList(startRow, pageSize);
	for(int i=0;i<boardList3.size();i++ ) {
		// 한칸의 정보 가져오기
		BoardBean bb = (BoardBean)boardList3.get(i);
%>
		<tr>
		<td style="text-align: left;"><a href="../board/content.jsp?num=<%=bb.getNum()%>"><%=bb.getSubject()%></a> </td>
		<td style=" text-align: right;"><%=bb.getDate()%></td>
		</tr>
		<%
		
	
	}

	
%>

</table>
</div >
<jsp:include page="../inc/bottom.jsp" />
	</div>
</div>

</body>
</html>
