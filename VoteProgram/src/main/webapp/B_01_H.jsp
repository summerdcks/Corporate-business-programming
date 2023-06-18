<%@page import="java.util.ArrayList"%>
<%@page import="kr.ac.kopo.ctc.kopo36.domain.Vote"%>
<%@page import="java.util.List"%>
<%@page import="kr.ac.kopo.ctc.kopo36.dao.VoteSystemDaoImpl"%>
<%@page import="kr.ac.kopo.ctc.kopo36.dao.VoteSystemDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html> <!-- 문서형식 html -->
<html> <!-- html언어로 작성 시작 -->
<head> <!-- 머릿말 끝 -->
	<meta charset="UTF-8">
	<!--html 메타태그: 문서의 문자 인코딩을 utf-8로 설정한다-->
	<title>투표 B_01_H.jsp</title> <!--타이틀에 새겨질 글자-->
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
    	select { /*select태그 셀렉터*/
	        width: 100px; /*너비 100픽셀*/
	        height: 30px; /*높이 30픽셀*/
	        font-size: 20px; /*글자크기 20픽셀*/
	    }
    	 
	</style><!-- 스타일시트 끝 -->
<%
	VoteSystemDao voteSystemDao = new VoteSystemDaoImpl();
	//VoteSystemDao 인터페이스를 구현한 VoteSystemDaoImpl 클래스의 인스턴스를 생성하여 voteSystemDao변수에 할당
	List<Vote> votes = new ArrayList<>();
	//Vote형식의 객체배열 votes 생성
	votes = voteSystemDao.selectAll();
	//VoteSystemDaoImpl클래스의 selectAll함수를 호출하여 리턴값을 객체배열 votes로 받음
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
</table> <!-- 테이블 끝 -->

<table class='tt' cellspacing=3 width=1200>
<!-- 테이블 시작, tt클래스, 셀간격 3픽셀, 너비 1200픽셀 -->
	<tr> <!-- 행 시작 -->
		<form method="get" action="B_02_H.jsp"> <!-- get속성을 가진 폼 시작 해당 경로로 제출 -->
			<td width=400><p align=right> <!-- 열 너비 400픽셀, p태그 글자 오른쪽 정렬 -->
			<select name=kiho> <!-- 선택한 값을 kiho로 대입하는 select태그 설정 -->
<%
			for(int i = 0; i < votes.size(); i++) { //votes객체배열의 크기만큼 반복문 실행
				Vote vote = new Vote(); //Vote형태의 vote변수 생성 
				vote = votes.get(i); //votes객체배열의 i번째 객체를 vote변수에 대입
				out.println("<option value="+ vote.getKiho() +">"+ vote.getKiho() +" "+ vote.getName() +"");
				//vote의 kiho와 name을 출력하고 클릭하면 value값인 vote의 kiho값이 kiho변수로 전달
			}			
%>
			</select></p></td> <!-- select태그, p태그, 열 끝 -->
			<td width=400><p align=center> <!-- 열 너비 400픽셀, p태그 글자 오른쪽 정렬 -->
			<select name=age> <!-- 선택한 값을 age로 대입 -->
				<option value=1> 10대 <!-- 해당 문자열을 선택하면 value값이 age로 전달 -->
				<option value=2> 20대 <!-- 해당 문자열을 선택하면 value값이 age로 전달 -->
				<option value=3> 30대 <!-- 해당 문자열을 선택하면 value값이 age로 전달 -->
				<option value=4> 40대 <!-- 해당 문자열을 선택하면 value값이 age로 전달 -->
				<option value=5> 50대 <!-- 해당 문자열을 선택하면 value값이 age로 전달 -->
				<option value=6> 60대 <!-- 해당 문자열을 선택하면 value값이 age로 전달 -->
				<option value=7> 70대 <!-- 해당 문자열을 선택하면 value값이 age로 전달 -->
				<option value=8> 80대 <!-- 해당 문자열을 선택하면 value값이 age로 전달 -->
				<option value=9> 90대 <!-- 해당 문자열을 선택하면 value값이 age로 전달 -->
			</select></p></td> <!-- select태그, p태그, 열 끝 -->
			<td><p align=left> <!-- 열 시작 p태그 글자 왼쪽정렬 -->
				<input type=submit value="투표하기"> <!-- 클릭하면 해당 경로로 폼을 제출하는 투표버튼 생성 -->
			</p></td> <!-- 열 끝 -->
		</form> <!-- 폼 끝 -->
	</tr> <!-- 행 끝 -->
</table> <!-- 테이블 끝 -->
</body> <!-- 본문 끝 -->
</html> <!-- html언어로 작성 끝 -->




