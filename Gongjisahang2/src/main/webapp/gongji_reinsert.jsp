<%@page import="kr.ac.kopo.ctc.kopo36.dao.GongjiDao"%>
<%@page import="kr.ac.kopo.ctc.kopo36.dao.GongjiDaoImpl"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--utf-8 문자 인코딩으로 html콘텐츠를 생성할 것을 지정한다-->
<!DOCTYPE html> <!-- html로 작성된 문서 -->
<html> <!--html언어로 작성 시작-->
<head> <!--머릿말 시작-->
	<meta charset="UTF-8"> <!-- utf-8 문자 인코딩 -->
	<title>gongji_reinsert</title> <!--타이틀에 새겨질 글자-->
	<style> /*CSS 스타일시트*/
		table.type10 { /*type10클래스의 테이블 셀렉터*/
		  border-collapse: collapse;
		  text-align: left;
		  line-height: 1.5;
		  border-top: 1px solid #ccc;
		  border-bottom: 1px solid #ccc;
		  margin: 20px 10px;
		}
		table.type10 th { /*type10클래스의 테이블의 th 셀렉터*/
		  padding: 10px;
		  font-weight: bold;
		  color: #fff;
		  background: #e7708d;
		}
		table.type10 td { /*type10클래스의 테이블의 td 셀렉터*/
		  padding: 10px;
		  vertical-align: top;
		}
		.custom-button { /*custom-button클래스의 버튼 셀렉터*/
            font-size: 15px;
            font-weight: bold;
            color: white;
            background-color: #e7708d;
            padding: 10px 15px;
            border: none;
        }
	</style> <!-- CSS스타일시트 끝 -->
	<script> //자바스크립트 시작
		function submitForm() { //버튼을 클릭하면 함수 실행
			const fm = document.getElementById('fm'); 
	        //id가 fm인 html요소를 선택하고 변수 fm에 할당
	        const title = fm.elements.title.value; 
	        //html폼 내의 이름이 title인 입력값을 가져와 변수 title에 할당
	        const content = fm.elements.content.value; 
	      	//html폼 내의 이름이 content인 입력값을 가져와 변수 title에 할당
	        const pattern = /^(?! *$)(?! *\n$)[\s\S]*$/; //공백은 입력받지 않는 정규식
			if (!pattern.test(title)) { //제목이 공백이면
				alert("제목을 입력해주세요");	//해당 알림창 띄우기
			} else if (!pattern.test(content)) {	//내용이 공백이면
				alert("내용을 입력해주세요");	//해당 알림창 띄우기
			} else { //제목, 내용이 공백이 아니면
				fm.action = "gongji_write.jsp"; //폼의 action을 해당 경로로 설정
				fm.submit();	//폼을 해당경로로 제출해줌
			}
		}
	</script> <!--자바 스크립트 끝-->
	<%	 //scriptlet시작
		request.setCharacterEncoding("UTF-8"); //request의 문자 인코딩 utf-8 지정
		LocalDate currentDate = LocalDate.now(); //LocalDate클래스를 이용하여 현재시간을 구하고 변수currentDate에 할당
    	String formattedDate = currentDate.format(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		//currentDate를 DateTimeFormatter를 이용하여 원하는 형태로 format하고 문자열형 변수 formattedDate에 할당
		int rootid = Integer.parseInt(request.getParameter("rootid"));
		//매개변수로 전달받은 id값을 정수형변환하여 정수형변수 bunho에 대입한다
		int relevel = Integer.parseInt(request.getParameter("relevel"));
		//매개변수로 전달받은 id값을 정수형변환하여 정수형변수 bunho에 대입한다
		int recnt = Integer.parseInt(request.getParameter("recnt"));
		//매개변수로 전달받은 id값을 정수형변환하여 정수형변수 bunho에 대입한다
		GongjiDao gongjidao = new GongjiDaoImpl();
		//GongjiDao 인터페이스를 상속받는 GongjiDaoImpl클래스의 인스턴스를 생성하여 변수 gongjidao에 대입		
	%> <!--scriptlet 끝-->
</head> <!--머릿말 끝-->
<body> <!--본문 시작-->
<h1>답글 입력</h1> <!--표제-->
	<form method=post id='fm'>
	<!--데이터가 HTTP post 메소드를 사용하여 제출되도록 지정, 양식 필드에 입력된 데이터가 쿼리 매개변수로 URL에 추가된다
    식별자 "fm"을 양식 요소에 할당하며 JavaScript 또는 CSS에서 양식을 참조하는 데 사용할 수 있게 한다-->   
	<table class="type10" width=650 border=1 cellspacing=0 cellpadding=5>
	<!-- 테이블 시작, 클래스 type10지정, 너비 650픽셀, 테두리 1픽셀, 셀간격 없음, 셀여백 5픽셀 -->
		<tr> <!-- 행 시작 -->
			<th><b>번호</b></th> <!-- 헤더셀, 굵은글씨 -->
			<td colspan=3>NEW<input type=hidden name=id value=''></td> <!-- 셀 안에 문자열 출력 -->
		</tr> <!-- 행 끝 -->
		<tr> <!-- 행 시작 -->
			<th><b>제목</b></th> <!-- 헤더셀, 굵은글씨 -->
			<td colspan=3><input type=text name=title value='' size=70 maxlength=70></td>
			<!-- 셀 안에 입력창 생성, 입력받는 값을 title로 지정, 최대 70문자 가능 -->
		</tr> <!-- 행 끝 -->
		<tr> <!-- 행 시작 -->
			<th><b>일자</b></th> <!-- 헤더셀, 굵은글씨 -->
			<td colspan=3><%=formattedDate %></td> <!-- 셀 안에 해당 변수값 출력 -->
		</tr> <!-- 행 끝 -->
		<tr> <!-- 행 시작 -->
			<th><b>내용</b></th> <!-- 헤더셀, 굵은글씨 -->
			<td colspan=3><textarea style='width:500px; height:250px;' name=content cols=70 row=600 maxlength=10000></textarea></td>
			<!-- 셀 안에 텍스트 입력란 생성, 너비 500픽셀, 세로 250픽셀, content로 지정, 70열 600행까지 가능 -->
		</tr> <!-- 행 끝 -->
		<tr> <!-- 행 시작 -->
			<th><b>원글</b></th> <!-- 헤더셀, 굵은글씨 -->
			<td colspan=3><%=rootid%><input type=hidden name=rootid value='<%=rootid%>'></td> <!-- 셀 안에 해당값의 개행을 형변환하여 출력 -->
		</tr> <!-- 행 끝 -->
		<tr> <!-- 행 시작 -->
			<th><b>댓글수준</b></th> <!-- 헤더셀, 굵은글씨 -->
			<td width = 180><%=relevel + 1%><input type=hidden name=relevel value='<%=relevel + 1%>'></td>
			<!-- 셀 너비 180픽셀, 해당변수값 출력, 해당폼에 파라미터로 전달되는 값 -->
			<th width = 100><b>댓글내 순서</b></th> <!-- 헤더셀 너비 100픽셀, 굵은글씨 -->
			<td><%=recnt%><input type=hidden name=recnt value='<%=recnt%>'></td>
			<!-- 해당변수값 출력, 해당폼에 파라미터로 전달되는 값 -->
		</tr> <!-- 행 끝 -->
	</table> <!--테이블 끝-->
	<table width=650> <!-- 테이블 시작, 너비 650픽셀 -->
		<tr> <!-- 행 시작 -->
			<td width=600></td><!-- 셀 너비 600픽셀 -->
			<td><input type=button class="custom-button" value="취소" OnClick="location.href='gongji_list.jsp'"></td>
			<!-- 버튼 생성, 클래스 custon-button 지정, 클릭하면 해당 페이지로 이동 -->
			<td><input type=button class="custom-button" value="쓰기" OnClick="submitForm()"></td>
			<!-- 버튼 생성, 클래스 custon-button 지정, 클릭하면 함수 실행 -->
		</tr> <!-- 행 끝 -->
	</table> <!--테이블 끝-->
	</form> <!--form 끝-->
</body> <!--본문 끝-->
</html> <!--html언어로 작성 끝-->