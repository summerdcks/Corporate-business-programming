<%@page import="kr.ac.kopo.ctc.kopo36.service.VoteSystemServiceImpl"%>
<%@page import="kr.ac.kopo.ctc.kopo36.service.VoteSystemService"%>
<%@page import="kr.ac.kopo.ctc.kopo36.dao.VoteSystemDaoImpl"%>
<%@page import="kr.ac.kopo.ctc.kopo36.dao.VoteSystemDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html> <!-- 문서형식 html -->
<html> <!-- html언어로 작성 시작 -->
<head> <!-- 머릿말 끝 -->
	<meta charset="UTF-8">
	<!--html 메타태그: 문서의 문자 인코딩을 utf-8로 설정한다-->
	<title>개표결과 C_02_H.jsp</title> <!--타이틀에 새겨질 글자-->
	<style> /*스타일시트 시작*/
		table{ /*테이블 셀렉터*/
			layout: fixed; /*레이아웃 고정*/
		}
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
    	.graghTD { /*해당 셀의 설정*/
			text-align: left; /*글자 왼쪽 정렬*/
		}	
		.graph { /* 그래프 스타일 설정*/
			background-color: red; /* 그래프의 배경색 */
			overflow: hidden; /*그래프가 크기를 벗어나면 보이지 않도록 설정*/
			text-overflow: ellipsis; /*글자가 짤리면 표시되도록 설정*/
			white-space: nowrap; /*글자가 셀 밖을 벗어나지 않도록 설정*/
		}	
		.graph-container { /* 그래프 + 숫자 스타일 설정 */
			width: 500x; /* 그래프 컨테이너의 고정 너비 */
			height: 20px; /* 그래프 컨테이너의 고정 높이 */
			display: flex; /*그래프 컨테이너 유동조절 설정*/
		}
		div { /*div 태그 셀렉터*/
			display: inline-block; /*인라인블록 설정*/
		}
	</style><!-- 스타일시트 끝 -->
<%
	Integer kiho =0; //정수형 kiho변수에 0값 대입	
	try{ //오류를 잡기 위해 try-catch 사용	    
		kiho = Integer.parseInt(request.getParameter("id")); //id파라미터를 받아와 정수형변환 후 변수 id에 대입 
	}catch(Exception e) { //오류가 있으면
		e.printStackTrace(); //오류내역 출력
	}
	
	String name = ""; //문자열형 name변수 선언	
	try{ //오류를 잡기 위해 try-catch 사용	    
		name = request.getParameter("name"); //name파라미터를 받아와 변수 name에 대입 
	}catch(Exception e) { //오류가 있으면
		e.printStackTrace(); //오류내역 출력
	}
	VoteSystemService voteSystemService = new VoteSystemServiceImpl();
	//VoteSystemService 인터페이스를 구현한 VoteSystemServiceImpl 클래스의 인스턴스를 생성하여 voteSystemService변수에 할당
	int total = voteSystemService.selectOne(kiho, 1) + voteSystemService.selectOne(kiho, 2) + voteSystemService.selectOne(kiho, 3) + 
			voteSystemService.selectOne(kiho, 4) + voteSystemService.selectOne(kiho, 5) + voteSystemService.selectOne(kiho, 6) + 
			voteSystemService.selectOne(kiho, 7) + voteSystemService.selectOne(kiho, 8) + voteSystemService.selectOne(kiho, 9);
	//해당 기호의 해당 연령대로부터의 득표수를 구하는 함수를 호출하여 리턴값을 모두 더하면 해당 기호의 총득표수가 된다
%>
</head> <!-- 머릿말 끝 -->
<body> <!-- 본문 시작 -->
	<table class='tt' cellspacing=3 width=1200>
	<!-- 테이블 시작, tt클래스, 셀간격 3픽셀, 너비 1200픽셀 -->
		<tr> <!-- 행 시작 -->
			<td width=400 height=50 align="center"><a href="A_01_H.jsp"><h1>후보등록</h1></a></td>
			<td width=400 height=50 align="center"><a href="B_01_H.jsp"><h1>투표</h1></a></td>
			<td width=400 height=50 align="center" bgcolor=yellow><a href="C_01_H.jsp"><h1>개표결과</h1></a></td>
			<!-- 너비 400픽셀 높이 50픽셀 글자 가운데 정렬 셀을 생성 -->
			<!-- h1태그로 표시된 굵은 문자열을 a태그로 해당 경로에 하이퍼링크 연결 -->
			<!-- 현재 페이지에 해당하는 셀을 배경 노란색으로 설정하여 구분 -->
		</tr> <!-- 행 끝 -->
	</table> <!-- 테이블 끝 -->
	
<table width=1200><!-- 테이블 시작, 너비 1200픽셀 -->
		<tr><td><h1><%=name %> 후보 득표 성향</h1></td></tr> <!-- 행 열 표제 설정 -->
</table> <!-- 테이블 끝 -->

<table class='tt' cellspacing=3 width=1200>
<!-- 테이블 시작, tt클래스, 셀간격 3픽셀, 너비 1200픽셀 -->
	<tr> <!-- 행 시작 -->
		<td width=200><p align=center>연령대</p></td> <!-- 셀 너비 200픽셀 글자 가운데 정렬 -->
		<td width=1000><p align=center>인기도</p></td> <!-- 셀 너비 1000픽셀 글자 가운데 정렬 -->
	</tr> <!-- 행 끝 -->
<%
	for(int i = 1; i < 10; i++) { //10대부터 90대까지 연령대별로 반복문 실행
		int count = voteSystemService.selectOne(kiho, i); 
		//해당 기호와 연령대를 매개변수로 입력받아 득표수를 리턴하는 함수를 호출하여 리턴값을 정수형 변수 count로 받음
		double percentage = ((double)count/total) * 100; //득표수를 총득표수로 나누고 100을 곱하여 득표율을 계산
		out.println("<tr>"); //행 시작 출력
		out.println("<td width=200><p align=center>"+(i*10)+"대</p></a>");
		//셀 너비 200픽셀, 글자 가운데 정렬, 해당 문구 출력
		out.println("</td>"); //셀 끝 출력
		out.println("<td class='graghTD'>"); //해당 클래스 설정의 셀 시작
		out.println("<div class='graph-container'>"); //해당 클래스 설정의 div 시작
		out.println("<div class='graph' style='width: " + (int)percentage + "%'></div>"); //해당 클래스 설정의 div 시작 너비 설정
		out.println("<span>" + count + "(" + (int)percentage + "%</span>)");
		out.println("</div>"); //div끝 출력
		out.println("</td>"); //셀 끝 출력
		out.println("</tr>"); //행 끝 출력
	}
%>
</table> <!-- 테이블 끝 -->
</body> <!-- 본문 끝 -->
</html> <!-- html언어로 작성 끝 -->