<%@page import="kr.ac.kopo.ctc.kopo36.dao.VoteSystemDaoImpl"%>
<%@page import="kr.ac.kopo.ctc.kopo36.dao.VoteSystemDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html> <!-- 문서형식 html -->
<html> <!-- html언어로 작성 시작 -->
<head> <!-- 머릿말 끝 -->
	<meta charset="UTF-8">
	<!--html 메타태그: 문서의 문자 인코딩을 utf-8로 설정한다-->
	<title>투표 B_02_H.jsp</title> <!--타이틀에 새겨질 글자-->
	<style> /*스타일시트 시작*/
	 	a { /*a태그 셀렉터*/
	        text-decoration: none; /* 밑줄 제거 */
	        font-weight: bold; /* 굵은 글꼴 */
	        color: black; /* 검정색 글자색 */
	    }    	
		 .tt { /*tt클래스 셀렉터*/
     		background-color: #FDEBD0; /* 배경색을 #FDEBD0으로 설정 */
     		box-shadow: inset 0 0 8px #deb13a; /*안쪽으로 8px 범위에 #deb13a 색상의 그림자를 추가 */
    	}
    	h1 { /*h1태그 셀렉터*/
        	text-align: center; /*글자 가운데 정렬*/
    	}
	</style><!-- 스타일시트 끝 -->
<%
	Integer kiho =0; //정수형 kiho변수에 0값 대입	
	try{ //오류를 잡기 위해 try-catch 사용	    
		kiho = Integer.parseInt(request.getParameter("kiho")); //kiho파라미터를 받아와 정수형변환 후 변수 kiho에 대입 
	}catch(Exception e) { //오류가 있으면
		e.printStackTrace(); //콘솔창에 오류메시지 출력
	}

	Integer age =0; //정수형 age변수에 0값 대입	
	try{ //오류를 잡기 위해 try-catch 사용	    
		age = Integer.parseInt(request.getParameter("age")); //age파라미터를 받아와 정수형변환 후 변수 age에 대입 
	}catch(Exception e) { //오류가 있으면
		e.printStackTrace(); //콘솔창에 오류메시지 출력
	}
		
	VoteSystemDao voteSystemDao = new VoteSystemDaoImpl();
	//VoteSystemDao 인터페이스를 구현한 VoteSystemDaoImpl 클래스의 인스턴스를 생성하여 voteSystemDao변수에 할당
	voteSystemDao.insertIntoTupyo(kiho, age);
	//VoteSystemDaoImpl클래스의 insertIntoTupyo함수에 kiho와 age를 매개변수로 입력하여 호출
%>
</head> <!-- 머릿말 끝 -->
<body> <!-- 본문 시작 -->
	<table class='tt' cellspacing=3 width=1200>
	<!-- 테이블 시작, tt클래스, 셀간격 3픽셀, 너비 1200픽셀 -->
		<tr> <!-- 행 시작 -->
			<td width=400 height=50 align="center"><a href="A_01_H.jsp"><h1>후보등록</h1></a></td>
			<td width=400 height=50 align="center" bgcolor=yellow><a href="B_01_H.jsp"><h1>투표</h1></a></td>
			<td width=400 height=50 align="center"><a href="C_01_H.jsp"><h1>개표결과</h1></a></td>
			<!-- 너비 400픽셀 높이 50픽셀 글자 가운데 정렬 셀을 생성 -->
			<!-- h1태그로 표시된 굵은 문자열을 a태그로 해당 경로에 하이퍼링크 연결 -->
			<!-- 현재 페이지에 해당하는 셀을 배경 노란색으로 설정하여 구분 -->
		</tr> <!-- 행 끝 -->
	</table> <!-- 테이블 끝 -->
	<table width=1200><!-- 테이블 시작, 너비 1200픽셀 -->
			<tr><td><h1>투표하기</h1></td></tr> <!-- 행 열 표제 설정 -->
			<tr><td><h1>투표를 완료하셨습니다.</h1></td></tr> <!-- 행 열 표제 설정 -->
	</table> <!-- 테이블 끝 -->
</body> <!-- 본문 끝 -->
</html> <!-- html언어로 작성 끝 -->