<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!--html 메타태그: 문서의 문자 인코딩을 utf-8로 설정한다-->
<!DOCTYPE html> <!-- html언어로 작성된 문서 -->
<html> <!--html언어로 작성 시작-->
<head> <!--머릿말 시작-->
	<meta charset="UTF-8"> <!-- 한글인코딩 -->
	<title>make data</title> <!--표제-->
</head> <!--머릿말 끝-->
<body> <!--본문 시작-->
<% //scriptlet 시작
		Class.forName("com.mysql.cj.jdbc.Driver");
		// 데이터베이스와 통신하는데 사용되는 클래스를 호출한다
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo36", "root", "0000");
		// jdbc를 이용하여 mysql데이터베이스에 대한 연결을 설정한다
		Statement stmt = conn.createStatement();
		//데이터베이스에 대해 sql문을 실행하는데 사용할 statement객체를 생성한다
		stmt.executeUpdate("drop table Jaego;");
		// DB에서 재고 테이블을 삭제
		stmt.execute("create table Jaego(id int not null auto_increment,"+
					"itemNumber varchar(70) not null,"+
					"item varchar(70),"+
                   "inStock int,"+
                   "itemRegisteredDate date,"+
					"invenRegisteredDate date,"+
                   "explanation text,"+
                   "imageUrl text,"+
                   "PRIMARY KEY (id, itemNumber))"+
                   "default CHARSET=utf8;");
		// DB에서 재고 테이블 생성				
		stmt.execute("insert into Jaego (itemNumber, item, inStock, itemRegisteredDate, invenRegisteredDate, explanation, imageUrl) values(122122, '딸기', 10, date(now()), date(now()), '맛있다', './image/122122.jpg');");
		stmt.execute("insert into Jaego (itemNumber, item, inStock, itemRegisteredDate, invenRegisteredDate, explanation, imageUrl) values(122123, '리치', 15, date(now()), date(now()), '맛있다', './image/122123.jpg');");
		stmt.execute("insert into Jaego (itemNumber, item, inStock, itemRegisteredDate, invenRegisteredDate, explanation, imageUrl) values(122125, '망고스틴', 20, date(now()), date(now()), '맛있다', './image/122125.jpg');");
		stmt.execute("insert into Jaego (itemNumber, item, inStock, itemRegisteredDate, invenRegisteredDate, explanation, imageUrl) values(122126, '메론', 10, date(now()), date(now()), '맛있다', './image/122126.jpg');");
		stmt.execute("insert into Jaego (itemNumber, item, inStock, itemRegisteredDate, invenRegisteredDate, explanation, imageUrl) values(122127, '바나나', 15, date(now()), date(now()), '맛있다', './image/122127.jpg');");
		stmt.execute("insert into Jaego (itemNumber, item, inStock, itemRegisteredDate, invenRegisteredDate, explanation, imageUrl) values(122128, '복숭아', 13, date(now()), date(now()), '맛있다', './image/122128.jpg');");
		stmt.execute("insert into Jaego (itemNumber, item, inStock, itemRegisteredDate, invenRegisteredDate, explanation, imageUrl) values(122129, '블루베리', 30, date(now()), date(now()), '맛있다', './image/122129.jpg');");
		stmt.execute("insert into Jaego (itemNumber, item, inStock, itemRegisteredDate, invenRegisteredDate, explanation, imageUrl) values(122130, '사과', 30, date(now()), date(now()), '맛있다', './image/122130.jpg');");
		stmt.execute("insert into Jaego (itemNumber, item, inStock, itemRegisteredDate, invenRegisteredDate, explanation, imageUrl) values(122131, '샤인머스켓', 10, date(now()), date(now()), '맛있다', './image/122131.jpg');");
		stmt.execute("insert into Jaego (itemNumber, item, inStock, itemRegisteredDate, invenRegisteredDate, explanation, imageUrl) values(122132, '수박', 15, date(now()), date(now()), '맛있다', './image/122132.jpg');");
		stmt.execute("insert into Jaego (itemNumber, item, inStock, itemRegisteredDate, invenRegisteredDate, explanation, imageUrl) values(122133, '오렌지', 7, date(now()), date(now()), '맛있다', './image/122133.jpg');");
		stmt.execute("insert into Jaego (itemNumber, item, inStock, itemRegisteredDate, invenRegisteredDate, explanation, imageUrl) values(122134, '자두', 20, date(now()), date(now()), '맛있다', './image/122134.jpg');");
		stmt.execute("insert into Jaego (itemNumber, item, inStock, itemRegisteredDate, invenRegisteredDate, explanation, imageUrl) values(122135, '참외', 10, date(now()), date(now()), '맛있다', './image/122135.jpg');");
		stmt.execute("insert into Jaego (itemNumber, item, inStock, itemRegisteredDate, invenRegisteredDate, explanation, imageUrl) values(122136, '토마토', 15, date(now()), date(now()), '맛있다', './image/122136.jpg');");
		// 테이블에 데이터 입력
		stmt.close(); //Statement개체를 닫는다
		conn.close();	//데이터베이스 연결을 닫는다				
		out.println("테이블 재생성, 데이터 입력 완료"); //해당 문구를 출력
%>	 <!--scriptlet 끝-->
</body> <!--본문 끝-->
</html><!--html언어로 작성 끝-->
