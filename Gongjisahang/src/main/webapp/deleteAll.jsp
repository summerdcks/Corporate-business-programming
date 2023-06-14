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
		stmt.execute("drop table gongji;"); //공지 테이블이 있으면 삭제하는 쿼리 실행
		stmt.execute("create table gongji(id INT not null primary key AUTO_INCREMENT, title varchar(70), date date, content text,"
		    		+ " rootid int, relevel int, recnt int, viewcnt int)DEFAULT CHARSET=utf8;");
		//테이블 생성 쿼리 실행
		stmt.close(); //Statement개체를 닫는다
		conn.close();	//데이터베이스 연결을 닫는다				
		out.println("테이블 재생성, 데이터 입력 완료");
%>	 <!--scriptlet 끝-->
</body> <!--본문 끝-->
</html><!--html언어로 작성 끝-->
