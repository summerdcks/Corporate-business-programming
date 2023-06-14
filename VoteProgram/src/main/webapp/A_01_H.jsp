<%@page import="kr.ac.kopo.ctc.kopo36.service.VoteSystemServiceImpl"%>
<%@page import="kr.ac.kopo.ctc.kopo36.service.VoteSystemService"%>
<%@page import="kr.ac.kopo.ctc.kopo36.dao.VoteSystemDaoImpl"%>
<%@page import="kr.ac.kopo.ctc.kopo36.dao.VoteSystemDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="kr.ac.kopo.ctc.kopo36.domain.Vote"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html> <!-- 문서형식 html -->
<html> <!-- html언어로 작성 시작 -->
<head> <!-- 머릿말 끝 -->
	<meta charset="UTF-8">
	<!--html 메타태그: 문서의 문자 인코딩을 utf-8로 설정한다-->
	<title>후보등록 A_01_H.jps</title> <!--타이틀에 새겨질 글자-->
	<style>  /*스타일시트 시작*/
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
	    input[type="text"] { /*input타입 텍스트 셀렉터*/
	        width: 100px; /*너비 100픽셀*/
	        height: 30px; /*높이 30픽셀*/
	        font-size: 20px; /*글자크기 20픽셀*/
	    }
	</style> <!-- 스타일시트 끝 -->
<%
	VoteSystemDao voteSystemDao = new VoteSystemDaoImpl();
	//VoteSystemDao 인터페이스를 구현한 VoteSystemDaoImpl 클래스의 인스턴스를 생성하여 voteSystemDao변수에 할당
	List<Vote> votes = new ArrayList<>(); //Vote형식의 객체배열 votes 생성
	votes = voteSystemDao.selectAll(); //VoteSystemDaoImpl클래스의 selectAll함수를 호출하여 리턴값을 객체배열 votes로 받음
%>
<script> //자바스크립트 시작
	function confirmAndDelete(index) { //index값을 매개변수로 받는 함수 confirmAndDelete 생성
		const form = document.getElementById('formDelete'+ index);
		//id가 'formDelete + index' 인 html을 받아와 form에 할당한다
		var confirmed = confirm("후보등록을 철회하시겠습니까?"); //해당 문자열을 띄우는 확인창을 생성한다
	    if (confirmed) { //확인버튼을 누르면
	       	form.action = 'A_02_H.jsp';  //form의 action요소를 A_02_H.jsp로 지정해준다
	        form.submit(); //form의 데이터를 해당 경로로 제출한다 
	    }	
	}

	function confirmAndInsert() { //함수 confirmAndInsert 생성
        const form = document.getElementById('formInsert');
         //id가 formInsert인 html을 받아와 form에 할당한다
		const n1 = form.elements.name.value;
        //form html에서 name으로 입력된 값을 받아와 username에 할당한다
        const pattern1 = /^([a-zA-Z]|[가-힣])+$/; //한글,영어만 입력받는 정규식1 생성
        const pattern2 = /^.{1,20}$/; //20자 이내만 입력받는 정규식2 생성
        if(!pattern1.test(n1)) { //username값이 정규식1을 만족하지 않으면 
            alert("이름에 한글, 영어를 입력해주세요"); //해당문구를 알림창에 띄워준다
        } else if (!pattern2.test(n1)) { //username값이 정규식2을 만족하지 않으면 
            alert("이름은 20자 이내로 입력해주세요"); //해당문구를 알림창에 띄워준다
        } else { //변수값들이 모두 위의 정규식들을 만족하면       	
        	 var confirmed = confirm("후보를 등록하시겠습니까?"); //해당 문자열을 띄우는 확인창을 생성한다
             if (confirmed) { //확인버튼을 누르면
            	 form.action = 'A_03_H.jsp';  //form의 action요소를 A_03_H.jsp로 지정해준다
                 form.submit(); //form의 데이터를 해당 경로로 제출한다 
             }
        }        
	}
</script> <!-- 자바스크립트 끝 -->
</head> <!-- 머릿말 끝 -->
<body> <!-- 본문 시작 -->
	<table class='tt' cellspacing=3 width=1200 > <!-- 테이블생성 -->
	<!-- tt클래스, 셀 간격 3픽셀, 너비 1200픽셀-->
		<tr> <!-- 행 시작 -->
			<td width=400 height=50 align="center" bgcolor=yellow><a href="A_01_H.jsp"><h1>후보등록</h1></a></td>
			<td width=400 height=50 align="center"><a href="B_01_H.jsp"><h1>투표</h1></a></td>
			<td width=400 height=50 align="center"><a href="C_01_H.jsp"><h1>개표결과</a></td>
			<!-- 너비 400픽셀 높이 50픽셀 글자 가운데 정렬 셀을 생성 -->
			<!-- h1태그로 표시된 굵은 문자열을 a태그로 해당 경로에 하이퍼링크 연결 -->
			<!-- 현재 페이지에 해당하는 셀을 배경 노란색으로 설정하여 구분 -->
		</tr> <!-- 행 끝 -->
	</table> <!-- 테이블 끝 -->
	
	<table width=1200> <!-- 테이블 시작 너비 1200픽셀 -->
		<tr><td><h1>후보 등록</h1></td></tr> <!-- 해당 행열의 표제를 굵은글씨로 표현 표제-->
	</table> <!-- 테이블 끝 -->
	
	<table class='tt' cellspacing=3 width=1200 border-collapse=collapse>
	<!-- 테이블 시작, tt클래스, 셀 간격 3픽셀, 너비 1200픽셀, 테두리 연결-->
<%		
		for(int i = 0; i < votes.size(); i++) { //votes객체배열의 객체수만큼 반복문 실행
			Vote vote = new Vote(); //Vote형식의 변수 vote 생성
			vote = votes.get(i); //votes객체배열의 i번째 객체를 vote에 대입
%>
			<tr height=50><td align='center'> <!-- 행 높이 50픽셀, 열 글자 가운데정렬 -->
				<form method='get' id='formDelete<%= i %>'>
				<!-- get속성의 form생성, 각 반복문의 i에 따라 고유한 id를 생성한다 -->
				기호 : <input type='text' name='kiho' value='<%=vote.getKiho() %>' readonly>
				<!-- 텍스트 입력창 생성, vote의 kiho값을 출력하고 kiho속성으로 지정, 편집불가-->
				이름 : <input type='text' name='name' value='<%=vote.getName() %>' readonly>
				<!-- 텍스트 입력창 생성, vote의 name값을 출력하고 name속성으로 지정, 편집불가-->
				<input type='button' value='삭제' onclick='confirmAndDelete(<%= i %>)'>	
				<!-- 클릭하면 confirmAndDelete함수가 호출되는 삭제버튼 생성 -->
				</form> <!-- form 끝 -->
			</td></tr> <!-- 행렬 끝 -->
<%
		}
		VoteSystemService voteSystemService = new VoteSystemServiceImpl();
		//VoteSystemService 인터페이스를 구현한 VoteSystemServiceImpl 클래스의 인스턴스를 생성하여 voteSystemService변수에 할당
		int kiho2 = voteSystemService.getAvailableKiho();
		//VoteSystemServiceImpl클래스의 getAvailableKiho함수를 호출하여 리턴값을 정수형변수 kiho2로 받음
%>		
		<tr height=50><td align='center'><!-- 행 높이 50픽셀, 열 글자 가운데정렬 -->
			<form method='get' id='formInsert'>
			<!-- get속성의 form생성, id는 formInsert 설정 -->
			기호 : <input type='text' name='id' value='<%=kiho2 %>' readonly>
			<!-- 텍스트 입력창 생성, vote의 kiho2값을 출력하고 id속성으로 지정, 편집불가-->
			이름 : <input type='text' name='name' value='' > 
			<!-- 텍스트 입력창 생성, 입력받은 값을 name속성으로 지정, 편집불가-->
			<input type="button" value="입력" onclick='confirmAndInsert()'>
			<!-- 클릭하면 confirmAndInsert함수가 호출되는 입력버튼 생성 -->
			</form> <!-- form 끝 -->
		</td></tr> <!-- 행렬 끝 -->
	</table> <!-- 테이블 끝 -->
</body> <!-- 본문 끝 -->
</html> <!-- html언어로 작성 끝 -->