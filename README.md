# DEVELOPGROUNDS

> 개발자간 소통할 수 있는 커뮤니티 사이트

> [실행화면 유튜브로 보기](https://www.youtube.com/watch?v=3Z8ggiOaAOE)



## 개발 환경
**Front-end**
  * HTML5
  * CSS3
  * JavaSript
  
**Back-end**
  * Java1.8
  * MySQL5.7

**Tools**
  * Eclipse
  * apache/tomcat8.0
  * MySQL Workbench
 
 
## 핵심 기능 

### 프로젝트는 MVC1 패턴으로 개발  

> MVC1 패턴이란 ?   
> * JSP에서 Controller와 View 기능이 모두 처리된다.   
> * JSP 안에서 모든게 처리되다보니 그만큼 구현이 쉬운 장점이 있으나 유지보수가 어려울 수 있다.

**JDBC: DB 연결을 위해 공통적으로 사용된다**
``` java
<!-- context.xml -->
<Context>
	<Resource name="jdbc/MysqlDB"
	 		  auth="Container"
	 		  type="javax.sql.DataSource"
	 		  driverClassName="com.mysql.jdbc.Driver"
	 		  url="jdbc:mysql://localhost:3306/jspdb1?characterEncoding=utf8"
	 		  username="root"
	 		  password="1234"/>
</Context>

 ----------------------------------------------------------------------

// 커넥션 객체가 필요할 때 꺼내서 사용할 수 있다
private Connection getConnection() throws Exception{
 // 드라이버 로더
 Class.forName("com.mysql.jdbc.Driver");
 // 디비 연결정보를 담는다
 String dbUrl="jdbc:mysql://localhost:3306/jspdb1";
 String dbUser="root";
 String dbPass="1234";
 Connection con=DriverManager.getConnection(dbUrl, dbUser, dbPass);
 return con;
}

 ----------------------------------------------------------------------
 
try {	                        
 // 디비 연결 정보가 담긴 Connection 객체를 가져온다
 con = getConnection();
 // SQL 쿼리를 작성한다
 String sql = "???";
 // 쿼리를 실행할 Preparedstatement 객체에 담는다
 pstmt=con.prepareStatement(sql);
 // 쿼리에 들어갈 인자를 넣어준다
 pstmt.setString(1, ???);
 // 리턴값이 필요할 때 ResultSet 객체를 사용한다
 rs = pstmt.executeQuery();
			 
 // rs 가 select해온 값이 있는지 확인하거나 저장이 필요할 때 사용, rs.next() = true 행이 존재한다는 것
 if(rs.next()) {}
				
}catch (Exception e) {
 e.printStackTrace();
}finally {
 // 사용한 자원들을 해제해줘야 자원의 낭비가 없음
 if(pstmt!=null) try { pstmt.close();} catch (SQLException ex) {}
 if(con!=null) try {con.close();} catch (SQLException ex) {}
 if(rs!=null) try {rs.close();} catch (SQLException ex) {}
}		

```


**로그인**
* 아이디, 비번 일치하는지 체크  
아이디 먼저 일치하는지 체크하고 일치하면 비밀번호도 체크하는 방식으로 총 3가지 경우가 나온다.  
아이디 일치 & 비밀번호 일치: 1 / 아이디 일치 & 비밀번호 불일치: 0 / 아이디 불일치: -1
``` java
// 아이디 체크
String sql = "select * from member where id = ?";
				 
if(rs.next()) {
 // 아이디 일치 & 비밀번호 일치
 if(rs.getString("pass").equals(pass)) check = 1;
 // 아이디 일치 & 비밀번호 불일치
 else check = 0;
}else {
 // 아이디 불일치
 check = -1;
 }
```

**회원 CRUD**
 * 아이디 중복 체크
``` java
// 비동기처리를 위해 ajax를 사용한다
$.ajax({
 url: url,  
 type: 'GET',
 data: id, 
 success : function(t){ 	        	
  // 1 이면 중복
  // -1 이면 사용 가능
})
```
ajax 를 통해 보낸 id를 DAO 에서 아래 쿼리에 담아서 실행되고 아이디가 중복이면 1, 아니면 -1 이 리턴된다.
``` sql
SELECT * FROM member WHERE id = ?
```
* 이메일 인증  
구글 SMTP 를 사용해서 사용자에게 메일을 보내는 방식이다. 인증문자는 6자 랜덤문자를 발송하게 되고 디비에 저장되어 입력값과 비교하게 된다.
``` java
// 랜덤문자 6자리를 생성해서 키 변수에 담고 구글 SMTP 메일로 보낸다
for(int i=0; i<6; i++) {
 int key = (int)(Math.random() * 62);
 if(key < 10) emailkey += key;
 else if(key > 35) emailkey += (char)(key + 61);
 else emailkey += (char)(key + 55);
}
```
* 다음 주소 API
 <img src="https://user-images.githubusercontent.com/64389409/99147196-5fefe400-26c2-11eb-8e3c-0a37878b4051.PNG" width="50%" heigth="50%">

주소가 4칸..이다.. 디비 컬럼을 address 하나로 만들었는데 조합해서 넣어야할듯하다. 아니면 컬럼을 4개로 만들면? 편하겠지만 사양하겠다.
디비에서 꺼내올때는 .split('/') 으로 끊어서 각 필드에 넣어준다.
``` java
setAddress(postcode+" / "+address1+" / "+address2+" / "+address3);
getAddress().split(" / ");
```
* 그 외에 INSERT, SELECT, UPDATE, DELETE 쿼리문으로 CRUD 구현하였다.
``` sql
INSERT INTO member(id, pass, name, reg_date, email, address, phone, mobile) values(?, ?, ?, ?, ?, ?, ?, ?)
SELECT * from member WHERE id = ?
UPDATE member SET name = ?, email = ?, address = ?, phone = ?, mobile = ? WHERE id = ?
DELETE FROM member WHERE id = ?
```




**게시판 CRUD**

* 조회수 중복 방지  
게시글 화면에서 새로고침 시 계속적으로 조회수가 증가하는 현상을 방지하기 위함이다.
강의시간에 배운 쿠키를 복습하고자 사용해봤다. 
``` java
// 쿠키값을 가져온다.
Cookie cookies[]=request.getCookies();
// 쿠키값이 없으면
if(cookies==null){
 // "게시판성격" + "이름" + "글번호" 를 조합해서 게시판 글 별로 식별할 수 있는 쿠키값을 만든다? 			
 Cookie cookie = new Cookie("cook", "p"+name+num);
 // 24시간 뒤에 삭제된다. 그 전에 브라우저에서 쿠키삭제를 해도 삭제된다.
 cookie.setMaxAge(86400);
 response.addCookie(cookie);
				
}else {
 // 쿠키값이 있으면			
 int check = 0;
 // 키값으로 된 쿠키가 있는지 for 문을 돌린다.
 // 쿠키가 있다는건 이전에 게시글이 조회 했다는 뜻이다.
 for(int i=0;i<cookies.length;i++){				
  if(cookies[i].getValue().equals("p"+name+num)) check = 1;		
 }
 // 키값으로 된 쿠키가 없으면 처음 조회한다는 뜻이다.
 if(check==0) {
  // 키값으로 된 쿠키를 생성해줘서 다음에 접속할 때 조회수를 방지한다.
  Cookie cookie = new Cookie("cook", "p"+name+num);
  cookie.setMaxAge(86400);
  response.addCookie(cookie);
 }			
}

```
주석의 내용처럼 브라우저에서 쿠키를 삭제하고 조회수를 다시 증가시킬 수 있다.
구글링을 해보니 IP 로도 조회수 방지를 할수있는 듯 하다. 나중을 기약하자....

* 좋아요 기능
좋아요를 누르고 취소까지 가능하게 한다.
유저가 어느 게시글에 좋아요를 눌렀는지 확인할 수 있게 id와 글번호를 디비 컬럼에 저장하고 확인할 수 있게한다.

``` sql
좋아요를 누르면 id와 글번호로 이미 저장된 값이 있는지 확인한다
SELECT * FROM boardlike WHERE id = ? and board = ?

if) 값이 존재하면 이미 좋아요를 눌렀다는 뜻이고 행을 삭제하고 좋아요를 -1 한다.
 INSERT INTO boardlike(id, board) VALUES(?, ?)
 UPDATE board SET board_like = (board_like - 1) WHERE num = ?

else) 값이 존재하지 않으면 행을 추가하고 좋아요를 +1 한다.
 DELETE FROM boardlike WHERE id=? AND board=?
 UPDATE board SET board_like = (board_like + 1) WHERE num = ?

```
* 파일 업로드, 다운로드
학원에서 알려준 파일 업로드, 다운로드 로직이다. 
업로드는 어느정도 이해 되는데 다운로드는 아직 이해가 안된다....
``` java
// 업로드 처리
// 한글처리 필요
// 서버 안에 폴더 만들어서 파일을 넣고 파일 이름을 디비에 저장한다
// WebContent - WEB-INF - lib - cos.jar 넣기
// 설치파일을 객체생성 => 파일업로드, 정보를 저장
// MultipartRequest multi = new MultipartRequest
//			(request, 업로드할 폴더(물리적경로), 파일최대크기, 한글처리, 이름이 동일할때 파일이름바꾸기);
// 프로젝트 경로가 아닌 빌드되는 경로???
String uploadPath = request.getRealPath("/upload");
// 파일최대크기설정
int maxSize=5*1024*1024; // 5M
MultipartRequest multi = new MultipartRequest(request, uploadPath, maxSize, "utf-8", new DefaultFileRenamePolicy());
// 디비에 저장 되는  파일이름
String file = multi.getFilesystemName("file");

---------------------------------------------------------------------------------------------------------------------

// 다운로드 처리. 공부가 필요하다...

// file_name 파일이름 파라미터 가져오기
String fileName = request.getParameter( "file_name" );
// upload 폴더의 물리적인 경로 확인
String savePath = "upload";
ServletContext context = getServletContext();
String sDownloadPath = context.getRealPath(savePath);
String sFilePath = sDownloadPath + "\\" + fileName;
// upload 물리적 경로 // 파일이름 
		
byte b[] = new byte[4096];
// File 파일 객체 생성해서 파일정보 크기, 속성, 존재여부,.. 
File oFile = new File(sFilePath);
  
// 파일 입력받기
FileInputStream in = new FileInputStream(oFile);
// 파일 타입 확인
String sMimeType = getServletContext().getMimeType(sFilePath);
System.out.println("sMimeType>>>"+sMimeType );
// 파일 타입이 확인이 안되면 
// octet-stream은  8비트로 된 일련의 데이터를 뜻합니다. 지정되지 않은 파일 형식을 의미합니다.
 
if(sMimeType == null) sMimeType = "application/octet-stream";

response.setContentType(sMimeType);

// 브라우저별로 파일 한글처리
String userAgent = request.getHeader("User-Agent");
boolean ie = (userAgent.indexOf("MSIE") > -1)|| (userAgent.indexOf("Trident") > -1);
String sEncoding=null;
if(ie) {
 sEncoding = URLEncoder.encode(fileName, "utf-8").replaceAll("\\+", "%20");
 System.out.println(sEncoding);
}else{
 sEncoding = new String(fileName.getBytes("utf-8"),"8859_1");
 System.out.println(sEncoding);
}
   
// 한글 업로드 (이 부분이 한글 파일명이 깨지는 것을 방지해 줍니다.)
// String sEncoding = new String(fileName.getBytes("utf-8"),"8859_1");
// System.out.println(sEncoding);

// 서버 -> 클라이언트 설정 바꿈 => 파일첨부 다운
response.setHeader("Content-Disposition", "attachment; filename= " + sEncoding);
   
ServletOutputStream out2 = response.getOutputStream();
int numRead;
// 첨부파일을 입력받아서 파일다운 되게 설정변경 => 출력
// 바이트 배열b의 0번 부터 numRead번 까지 브라우저로 출력
while((numRead = in.read(b, 0, b.length)) != -1) {
 out2.write(b, 0, numRead);
}
out2.flush(); 
out2.close();
in.close();

out.clear();
out = pageContext.pushBody();
```

* 페이징 처리
페이징 처리를 위한 변수가 필요하다. 변수명이 헷갈릴 수 있다.  
한 화면에 보여줄 글 개수: pageSize / 현재 페이지 번호: currentPage / 시작 번호: startRow / 끝 번호: endRow / 전체 페이지 수: pageCount  
한 화면에 보여줄 페이지 개수: pageCount / 한 한 화면에 보여줄 시작페이지 번호: startPage / 한화면에 보여줄 끝페이지 번호 구하기: endPage
``` java
int pageSize = 10;
// currentPage는 파라미터(pageNum)로 계속 받으면서 유지시킨다. 없으면 1 이다
int currentPage = 1;
// 10개씩 잘라서 1페이지 시작하는 행번호 구하기
// pageNum(currentPage) 	   pageSize		 startRow 시작행번호 ~ endRow 끝행번호
//	1				10				1   ~  10
//	2				10				11  ~  20
//	3				10				21  ~  30
//	4				10				31  ~  40
int startRow = (currentPage-1)*pageSize+1;
int endRow = currentPage*pageSize;

// 전체 페이지수 구하기 전체 글 개수 50   :  한화면에 보여줄 글 개수 10 => 전체페이지수 5 + 나머지없으면 0 => 5
//				   59			        10 =>             5 +        있으면1 => 6
int pageCount = count/pageSize + (count % pageSize == 0 ? 0 : 1);
// 한화면에 보여줄 페이지 개수
int pageBlock=10;
// 한화면에 보여줄 시작페이지 번호 구하기
// 페이지번호 currentPage			pageBlock			시작페이지 번호 startPage
//	1~10					10		  =>			1
//	11~20					10		  =>			11
//	21~30					10		  =>			21
int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
// 한화면에 보여줄 끝페이지 번호 구하기
// startPage		pageBlock		endPage
//			1				10		=>	10
//			11				10		=>	20
//			21				10		=>	30
int endPage = startPage + pageBlock - 1;
//  endPage 10  <=  전체 페이지수 5페이지
// 끝 페이지가 전체 페이지보다 크면 같게 한다
if(endPage > pageCount){
 endPage = pageCount;
}

-----------------------------------------------------------------------------------------------
// View
if(startPage > pageBlock){
 // 이전
}
// 1~ 10  11~20   startPage  ~ endPage
for(int i=startPage;i<=endPage;i++){
  i 
}
if(endPage < pageCount){
 // 다음		
}


```




* 그 외에 INSERT, SELECT, UPDATE, DELETE 쿼리문으로 CRUD 구현하였다.

``` sql
INSERT INTO board(num, id, subject, content, readcount, date, board_like) values(?, ?, ?, ?, ?, ?, ?)
SELECT * FROM board ORDER BY num DESC LIMIT startRow, pageSize
UPDATE board SET subject=? , content=? WHERE num=?
DELETE FROM board WHERE num = ?
```

* ajax를 사용하여 댓글도 CRUD 구현하였다.  



**쪽지함**

이걸 구현하려고 잠도 못자고 코딩했는데 구현했을 때 뿌듯함이란.. :D  

받는 이와 보낸 이, _del 은 삭제를 위한 컬럼이고  _read 는 읽음처리를 위한 컬럼이다.  
철수와 영희의 액션에 의한 디비 컬럼 변화에 집중해서 봐보자  
시간이 지나고 봐도 다시 이해할 수 있으면 좋겠다 .... ㅋㅋㅋㅋ
  
철수가 영희한테 쪽지를 보낸다 -> INSERT 
  |num|send_id|receive_id|subject|content|date|send_del|receive_del|send_read|receive_read|
|------|---|---|------|---|---|------|---|---|------|
|1|철수|영희|안녕|안녕|2022|1|1|0|0|

영희가 받은 쪽지를 읽음 -> receive_read = 1 ( 철수도 보낸 쪽지를 읽으면? send_read = 1 )
  |num|send_id|receive_id|subject|content|date|send_del|receive_del|send_read|receive_read|
|------|---|---|------|---|---|------|---|---|------|
|1|철수|영희|안녕|안녕|2022|1|1|0|1|

영희가 받은 쪽지를 삭제 -> receive_del = 0 으로 하면 영희가 받은 쪽지를 가져올 때 reveive_del = 1 인 것만 가져오면 된다  
이러면 실제 디비에서 삭제된것은 아니지만 보이지 않기 때문에 삭제효과를 가져온다!  
( ※ 철수도 보낸 쪽지를 삭제한다면? send_del = 0 ->
둘 다 삭제했기 때문에 진짜 디비에서 삭제된다!! )

|num|send_id|receive_id|subject|content|date|send_del|receive_del|send_read|receive_read|
|------|---|---|------|---|---|------|---|---|------|
|1|철수|영희|안녕|안녕|2022|1|0|0|1|

내가 구현한 부분은 여기까지지만  _del 과 _read 를 조합해서 사용하면 보낸이가 메세지를 삭제할 때 받는 이가 읽지 않았으면 같이 삭제할수도 있을 것같다.

    
## 화면 캡처
<img src="https://user-images.githubusercontent.com/64389409/99144252-c0bdf300-26a7-11eb-8ea2-5ccf5e753aab.PNG" width="50%" heigth="50%"><img src="https://user-images.githubusercontent.com/64389409/99144330-3a55e100-26a8-11eb-8d9f-eaa5e857b83a.PNG" width="40%" heigth="40%"><img src="https://user-images.githubusercontent.com/64389409/99144333-3e81fe80-26a8-11eb-969e-fa88a6d0dd7e.PNG" width="50%" heigth="40%"><img src="https://user-images.githubusercontent.com/64389409/99144332-3cb83b00-26a8-11eb-99d7-17d4321edd75.PNG" width="40%" heigth="40%"><img src="https://user-images.githubusercontent.com/64389409/99144447-56a64d80-26a9-11eb-8033-f7d1b4e4dc25.PNG" width="60%" heigth="60%"><img src="https://user-images.githubusercontent.com/64389409/99144341-48a3fd00-26a8-11eb-992e-e97153a190b2.PNG" width="40%" heigth="40%"> 
  
  
         
