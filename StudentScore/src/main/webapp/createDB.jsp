<%@page import="kr.ac.kopo.ctc.kopo36.dao.StudentScoreDaoImpl"%>
<%@page import="kr.ac.kopo.ctc.kopo36.dao.StudentScoreDao"%>
<meta http-equiv="Content-Type" content="text/html; charset-utf-8"/>
<!--html 메타태그: 문서의 문자 인코딩을 utf-8로 설정한다-->
<%@ page contentType="text/html; charset=utf-8" %>
<!--utf-8 문자 인코딩으로 html콘텐츠를 생성할 것을 지정한다-->
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>
<!--java.sql과 javax.sql 패키지를 가져와 데이터베이스 접근과 조작을 위한 클래스와
인터페이스를 제공한다. java.io패키지를 가져와 입력 및 출력 작업에 사용되는 클래스를 제공한다-->
<html> <!--html언어로 작성 시작-->
<head> <!--머릿말 시작-->
</head> <!--머릿말 끝-->
<body> <!--본문 시작-->
<h1>테이블 만들기</h1> <!--표제-->
<% //scriptlet 시작
	StudentScoreDao studentScoreDao = new StudentScoreDaoImpl();
	//StudentScoreDao 인터페이스를 구현한 StudentScoreDaoImpl 클래스의 인스턴스를 생성하여 studentScoreDao 변수에 할당
	String msg = studentScoreDao.createTable(); //StudentScoreDaoImpl 클래스의 createTable 메서드 호출
	//테이블을 생성하고 문자열을 리턴하는 함수
	out.println(msg); //생성여부를 메시지 출력
%> <!--scriptlet 끝-->
</body> <!--본문 끝-->
</html> <!--html언어로 작성 끝-->
