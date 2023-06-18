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
	<meta http-equiv="Content-Type" content="text/html; charset-utf-8"/>    
	<title>후보등록 A_02_H.jsp</title> <!--타이틀에 새겨질 글자-->
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
		out.println(e); //화면에 오류메시지 출력
	}
	
	String name = ""; //문자열형 변수 name 선언
	try{ //오류를 잡기 위해 try-catch 사용	    
		name = request.getParameter("name"); //name파라미터를 받아와 변수 name에 대입 
	}catch(Exception e) { //오류가 있으면
		e.printStackTrace(); //콘솔창에 오류메시지 출력
		out.println(e); //화면에 오류메시지 출력
	}
	
	VoteSystemDao voteSystemDao = new VoteSystemDaoImpl();
	//VoteSystemDao 인터페이스를 구현한 VoteSystemDaoImpl 클래스의 인스턴스를 생성하여 voteSystemDao변수에 할당
	int ck = voteSystemDao.deleteHubo(kiho);
	//VoteSystemDaoImpl클래스의 deleteHubo함수에 매개변수 kiho를 입력하고 호출하여 리턴값을 정수형 변수 ck로 받음
	
%>
</head> <!-- 머릿말 끝 -->
<body> <!-- 본문 시작 -->
	<table class='tt' cellspacing=3 width=1200>
	<!-- 테이블 시작, tt클래스, 셀간격 3픽셀, 너비 1200픽셀 -->
		<tr> <!-- 행 시작 -->
			<td width=400 height=50 align="center" bgcolor=yellow><a href="A_01_H.jsp"><h1>후보등록</h1></a></td>
			<td width=400 height=50 align="center"><a href="B_01_H.jsp"><h1>투표</h1></a></td>
			<td width=400 height=50 align="center"><a href="C_01_H.jsp"><h1>개표결과</h1></a></td>
			<!-- 너비 400픽셀 높이 50픽셀 글자 가운데 정렬 셀을 생성 -->
			<!-- h1태그로 표시된 굵은 문자열을 a태그로 해당 경로에 하이퍼링크 연결 -->
			<!-- 현재 페이지에 해당하는 셀을 배경 노란색으로 설정하여 구분 -->
		</tr> <!-- 행 끝 -->
	</table> <!-- 테이블 끝 -->
<% if(ck == -1) { //ck가 -1이면 delete에 오류가 발생한 것이므로 아래의 문구를 출력
%>
	<table width=1200><!-- 테이블 시작, 너비 1200픽셀 -->
		<tr><td><h1>후보등록 삭제 실패</h1></td></tr> <!-- 행,열,표제설정 -->
		<tr><td><h1>이미 득표한 후보는 후보등록 철회를 권장하지 않습니다</h1></td></tr> <!-- 행,열,표제설정 -->	
<%
	VoteSystemService voteSystemService = new VoteSystemServiceImpl();
	//VoteSystemService 인터페이스를 구현한 VoteSystemServiceImpl 클래스의 인스턴스를 생성하여 voteSystemService변수에 할당
	int count = voteSystemService.countVotes(kiho);
	//VoteSystemServiceImpl 클래스의 countVotes함수에 매개변수 kiho를 입력해 호출하여 리턴값을 정수형변수 count로 받음
	out.println("<tr><td><h1>기호 "+kiho+"번 "+name+"님의 득표수는 "+count+"입니다</h1></td></tr>");
	//행,열,표제 태그로 감싸진 해당 문자열을 출력해줌

%>
		<tr><td><h1>계속 철회를 진행하시겠습니까?</h1></td></tr> <!-- 행,열,표제설정 -->
	</table> <!-- 테이블 끝 -->
	
	<table width=1200><!-- 테이블 시작, 너비 1200픽셀 -->
    	<tr><td style='text-align:center'> <!-- 행열 시작 글자 가운데 정렬 -->
	            <div style='width:600px;float: right;'> <!--div 설정, 너비 600픽셀, 오른쪽 유동정렬 -->
	            <form action="A_02_H2.jsp"><input type="submit" value="삭제"> <!-- 클릭하면 해당 경로로 폼을 제출하는 삭제버튼 폼 생성 -->
	            <input type='hidden' name='kiho' value=<%=kiho %>> <!-- hidden으로 노출되지 않음 해당경로로 kiho값을 제출함 -->
	            </form> <!-- 폼 끝 -->
	            </div> <!-- div끝 -->
	            <!--버튼을 생성, 클릭하면 수정 문자열을 매개변수로 받는 update함수를 호출한다-->
            </td> <!-- 열 끝 -->
        	<td style='text-align:center'> <!-- 행 시작, 글자 가운데 정렬 -->
        	<div style='width:600px;float: right;'><button onclick="history.back()">뒤로가기</button></div>
        	<!--div 너비 600픽셀 오른쪽 유동정렬 설정--><!-- 클릭하면 이전페이지로 이동하는 버튼 생성 -->
        </td></tr> <!-- 행열 끝 -->
     </table> <!-- 테이블 끝 -->

<%
} else {
%>
	<table width=1200><!-- 테이블 시작, 너비 1200픽셀 -->
		<tr><td><h1>후보등록 삭제 완료</h1></td></tr> <!-- 행 열 표제 설정 -->
	</table> <!-- 테이블 끝 -->
<%	
}
%>
</body> <!-- 본문 끝 -->
</html> <!-- html언어로 작성 끝 -->