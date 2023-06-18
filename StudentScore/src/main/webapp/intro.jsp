<%@page import="kr.ac.kopo.ctc.kopo36.service.StudentScoreServiceImpl"%>
<%@page import="kr.ac.kopo.ctc.kopo36.service.StudentScoreService"%>
<%@page import="kr.ac.kopo.ctc.kopo36.dao.StudentScoreDaoImpl"%>
<%@page import="kr.ac.kopo.ctc.kopo36.dao.StudentScoreDao"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<!--html 메타태그: 문서의 문자 인코딩을 utf-8로 설정한다-->
<%@ page contentType="text/html; charset=utf-8" %>
<!--utf-8 문자 인코딩으로 html콘텐츠를 생성할 것을 지정한다-->
<%@ page import ="java.io.*, java.net.*" %>
<!--java.io, java.net패키지를 가져와 입력 및 출력 작업에 사용되는 클래스를 제공한다-->
<html> <!--html로 작성 시작-->
<head></head> <!--머릿말-->
<body> <!--본문 시작-->
<H1><center> JSP Database 실습 1</center></h1> <!--표제, 가운데정렬-->
<%  //scriptlet 시작
	StudentScoreService studentScoreService = new StudentScoreServiceImpl();
	//StudentScoreService 인터페이스를 구현한 StudentScoreServiceImpl 클래스의 인스턴스를 생성하여 studentScoreService 변수에 할당
	int count = studentScoreService.countVisitor();
	//StudentScoreServiceImpl클래스의 countVisitor 메서드를 호출하여 리턴값인 방문수를 정수형변수 count에 대입
	out.println("<br><br>현재 홈페이지 방문조회수는 ["+count+"] 입니다</br>");
	//업데이트된 방문 횟수를 웹페이지에 출력한다    
%> <!--scriptlet 끝 -->
</body> <!--본문 끝-->
</html> <!--html언어로 작성 끝-->