<%@page import="java.util.ArrayList"%>
<%@page import="kr.ac.kopo.ctc.kopo36.domain.StudentScore"%>
<%@page import="java.util.List"%>
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
<h1>조회</h1> <!--표제-->
<button onclick="history.back()">뒤로가기</button>
<!--클릭하면 해당경로로 이동하는 버튼을 생성한다-->
<%//scriptlet 시작
	int id = Integer.parseInt(request.getParameter("id"));
	//파라미터 id을 받아와 정수 id에 대입한다
	StudentScoreDao studentScoreDao = new StudentScoreDaoImpl();
	//StudentScoreDao 인터페이스를 구현한 StudentScoreDaoImpl 클래스의 인스턴스를 생성하여 studentScoreDao 변수에 할당
	StudentScore studentScore = new StudentScore();
	//StudentScore클래스의 인스턴스를 생성하여 studentScore변수에 할당
	studentScore = studentScoreDao.selectOne(id);
	//StudentScoreDaoImpl클래스의 id를 매개변수로 받는 selectOne메서드를 호출하여 리턴값을 studentScore변수에 할당
%> <!--scriptlet 끝-->
<table cellspacing=1 width=600 border=1> <!--셀 사이 간격 1픽셀, 셀 너비 600px, 테두리 1px-->
        <tr> <!--행 시작-->
            <td width=50><p align=center>이름</p></td> <!--셀너비 50픽셀, 글자 가운데 정렬-->
            <td width=50><p align=center>학번</p></td> <!--셀너비 50픽셀, 글자 가운데 정렬-->
            <td width=50><p align=center>국어</p></td> <!--셀너비 50픽셀, 글자 가운데 정렬-->
            <td width=50><p align=center>영어</p></td> <!--셀너비 50픽셀, 글자 가운데 정렬-->
            <td width=50><p align=center>수학</p></td> <!--셀너비 50픽셀, 글자 가운데 정렬-->
            <td width=50><p align=center>합계</p></td> <!--셀너비 50픽셀, 글자 가운데 정렬-->
            <td width=50><p align=center>평균</p></td> <!--셀너비 50픽셀, 글자 가운데 정렬-->
            <td width=50><p align=center>등수</p></td> <!--셀너비 50픽셀, 글자 가운데 정렬-->
        </tr> <!--행 끝-->
<% //scriptlet 시작
    	    out.println("<td width=50><p align=center>" + studentScore.getName()+"</p></td>");
			//studentScore에서 이름을 가져와 테이블의 셀에 대입하여 출력해준다
    	    out.println("<td width=50><p align=center>" + Integer.toString(studentScore.getStudentId())+"</p></td>");
		    //studentScore에서 학번을 정수값으로 가져와 문자열로 변환하여 테이블의 셀에 대입하여 출력해준다
		    out.println("<td width=50><p align=center>" + Integer.toString(studentScore.getKor())+"</p></td>");
		    //studentScore에서 국어점수를 정수값으로 가져와 문자열로 변환하여 테이블의 셀에 대입하여 출력해준다
		    out.println("<td width=50><p align=center>" + Integer.toString(studentScore.getEng())+"</p></td>");
		    //studentScore에서 영어점수를 정수값으로 가져와 문자열로 변환하여 테이블의 셀에 대입하여 출력해준다
		    out.println("<td width=50><p align=center>" + Integer.toString(studentScore.getMat())+"</p></td>");
		    //studentScore에서 수학점수를 정수값으로 가져와 문자열로 변환하여 테이블의 셀에 대입하여 출력해준다
		    out.println("<td width=50><p align=center>" + Integer.toString(studentScore.getSum())+"</p></td>");
		    //studentScore에서 합계를 정수값으로 가져와 문자열로 변환하여 테이블의 셀에 대입하여 출력해준다
		    out.println("<td width=50><p align=center>" + Integer.toString(studentScore.getAve())+"</p></td>");
		    //studentScore에서 평균을 정수값으로 가져와 문자열로 변환하여 테이블의 셀에 대입하여 출력해준다
		    out.println("<td width=50><p align=center>" + Integer.toString(studentScore.getRan())+"</p></td>");
		    //studentScore에서 등수를 정수값으로 가져와 문자열로 변환하여 테이블의 셀에 대입하여 출력해준다
		    out.println("</tr>"); //테이블 행 끝표시 출력
%> <!--scriptlet 끝-->
</table> <!--테이블 닫기-->
</body> <!--본문 끝-->
</html> <!--html언어로 작성 끝-->
