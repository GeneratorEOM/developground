# DEVELOPGROUNDS

> 개발자간 소통할 수 있는 커뮤니티 사이트

[실행화면 유튜브로 보기](https://www.youtube.com/watch?v=3Z8ggiOaAOE)



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
 
 
## 상세 기능

> 프로젝트는 MVC1 패턴으로 개발  
> MVC1 패턴이란 ?   
> JSP에서 Controller와 View 기능이 모두 처리된다.   
> JSP 안에서 모든게 처리되다보니 그만큼 구현이 쉬운 장점이 있으나 유지보수가 어려울 수 있다.

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

**쪽지함**
  
  
  
  
  
  
  
  
  
  
  

## 화면 캡처
<img src="https://user-images.githubusercontent.com/64389409/99144252-c0bdf300-26a7-11eb-8ea2-5ccf5e753aab.PNG" width="50%" heigth="50%"><img src="https://user-images.githubusercontent.com/64389409/99144330-3a55e100-26a8-11eb-8d9f-eaa5e857b83a.PNG" width="40%" heigth="40%"><img src="https://user-images.githubusercontent.com/64389409/99144333-3e81fe80-26a8-11eb-969e-fa88a6d0dd7e.PNG" width="50%" heigth="40%"><img src="https://user-images.githubusercontent.com/64389409/99144332-3cb83b00-26a8-11eb-99d7-17d4321edd75.PNG" width="40%" heigth="40%"><img src="https://user-images.githubusercontent.com/64389409/99144447-56a64d80-26a9-11eb-8033-f7d1b4e4dc25.PNG" width="60%" heigth="60%"><img src="https://user-images.githubusercontent.com/64389409/99144341-48a3fd00-26a8-11eb-992e-e97153a190b2.PNG" width="40%" heigth="40%"> 
  
  
         
