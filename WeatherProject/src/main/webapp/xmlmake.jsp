<?xml version="1.0" encoding="UTF-8"?>
<!-- XML 버전 및 인코딩을 지정하는 XML 선언, XML 버전 1.0과 UTF-8 인코딩을 사용 -->
<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- jsp페이지가 java언어로 작성됨, 페이지 컨텐츠 유형은 xml, 페이지 인코딩 utf-8 -->
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*" %>
<!-- JSP 페이지에서 사용할 Java 패키지를 import -->
<% //scriptlet으로 작성 시작
	Class.forName("com.mysql.jdbc.Driver");
	//데이터베이스와 통신하는데 사용되는 클래스를 호출한다
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.103:33060/kopo36", "root", "0000");
	// jdbc를 이용하여 mysql데이터베이스에 대한 연결을 설정한다
	Statement stmt = conn.createStatement();
	// 데이터베이스에 대해 sql문을 실행하는데 사용할 statement객체를 생성한다
	ResultSet rset = stmt.executeQuery("select * from examtable");
	//examtable 테이블의 모든 자료를 조회하여 ResultSet에 담아준다
	out.println("<datas>"); //datas 태그를 가진 부모 요소를 출력하여 XML 형식의 출력을 시작
	while (rset.next()) { //ResultSet을 한 행씩 반복하며 데이터를 처리
		out.println("<data>"); //data 태그를 가진 요소를 출력
		out.println("<name>"+rset.getString(1)+"</name>"); 
		//name태그를 가진 요소를 출력, ResultSet의 1번째 값을 가져와 출력
		out.println("<studentid>"+Integer.toString(rset.getInt(2))+"</studentid>");
		//studentid태그를 가진 요소를 출력, ResultSet의 2번째 정수값을 가져와 출력
		out.println("<kor>"+rset.getString(3)+"</kor>"); 
		//kor태그를 가진 요소를 출력, ResultSet의 3번째 값을 가져와 출력
		out.println("<eng>"+rset.getString(4)+"</eng>"); 
		//eng태그를 가진 요소를 출력, ResultSet의 4번째 값을 가져와 출력
		out.println("<mat>"+rset.getString(5)+"</mat>"); 
		//mat태그를 가진 요소를 출력, ResultSet의 5번째 값을 가져와 출력
		out.println("</data>"); //data 태그를 가진 요소를 출력 끝
	}
	out.println("</datas>"); //datas태그를 가진 요소 출력 끝
	stmt.close();	//Statement개체를 닫는다
	conn.close();	//데이터베이스 연결을 닫는다
%> <!-- scriplet으로 작성 끝 -->
