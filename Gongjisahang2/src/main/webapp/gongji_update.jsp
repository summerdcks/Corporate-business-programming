<%@page import="kr.ac.kopo.ctc.kopo36.domain.Gongji"%>
<%@page import="kr.ac.kopo.ctc.kopo36.dao.GongjiDaoImpl"%>
<%@page import="kr.ac.kopo.ctc.kopo36.dao.GongjiDao"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--utf-8 문자 인코딩으로 html콘텐츠를 생성할 것을 지정한다-->
<!DOCTYPE html> <!-- html로 작성된 문서 -->
<html> <!--html언어로 작성 시작-->
<head> <!--머릿말 시작-->
	<meta charset="UTF-8"> <!-- utf-8 문자 인코딩 -->
	<title>gongji_update</title> <!--타이틀에 새겨질 글자-->
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
		function submitForm(msg){
			const fm = document.getElementById('fm');
			//id가 fm인 html요소를 선택하고 변수 fm에 할당
			if(msg == "수정") {	//매개변수가 해당값을 가지면
		        const title = fm.elements.title.value; 
		        //html폼 내의 이름이 username인 입력값을 가져와 변수 username에 할당
		        const content = fm.elements.content.value; //해당 폼에서 content
		        const pattern = /^(?! *$)(?! *\n$)[\s\S]*$/; //공백은 입력받지 않는 정규식 선언
				if (!pattern.test(title)) { //제목이 정규식을 만족하지 못하면
					alert("제목을 입력해주세요");	//알림창 띄우기
				} else if (!pattern.test(content)) {	//내용이 정규식을 만족하지 못하면
					alert("내용을 입력해주세요");	//알림창 띄우기
				} else {	//위의 정규식을 모두 만족하면
					fm.action = "gongji_write.jsp"; //action값을 해당 페이지로 설정
					fm.submit(); //해당 페이지로 폼 제출
				}	
			} else if(msg == "삭제") {	//매개변수가 해당값을 가지면
				fm.action = "gongji_delete.jsp"; //action값을 해당 페이지로 설정
				fm.submit(); //해당 페이지로 폼 제출
			}
		}
	</script> <!--자바 스크립트 끝-->
<%	 //scriptlet시작
	request.setCharacterEncoding("UTF-8"); //request의 문자 인코딩 utf-8 지정
	LocalDate currentDate = LocalDate.now(); //LocalDate클래스를 이용하여 현재시간을 변수에 대입
	String formattedDate = currentDate.format(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd"));
	//DateTimeFormatter를 이용하여 현재시간을 원하는 형태로 변환하여 formattedDate문자열에 대입

	int bunho = Integer.parseInt(request.getParameter("id"));
	//id값을 파라미터로 받아와 정수형변환하고 정수형 변수인 bunho에 대입
	GongjiDao gongjiDao = new GongjiDaoImpl();
	//GongjiDao 인터페이스를 구현한 GongjiDaoImpl 클래스의 인스턴스를 생성하여 gongjiDao 변수에 할당
	Gongji gongji = new Gongji();
	//gongji객체 생성
	gongji = gongjiDao.OneView(bunho);
	//해당글번호를 매개변수로 받는 OneView함수를 호출하여 리턴값을 gongji객체에 할당
%> <!--scriptlet 끝-->
</head> <!--머릿말 끝-->
<body> <!--본문 시작-->
<h1>공지사항 수정</h1> <!--표제-->
	<form method=post id='fm'>
	<!--데이터가 HTTP post 메소드를 사용하여 제출되도록 지정, 양식 필드에 입력된 데이터가 쿼리 매개변수로 URL에 추가된다
    식별자 "fm"을 양식 요소에 할당하며 JavaScript 또는 CSS에서 양식을 참조하는 데 사용할 수 있게 한다-->   
	<table class="type10" width=650 border=1 cellspacing=0 cellpadding=5>
	 <!-- 테이블 시작, 클래스 type10지정, 너비 650픽셀, 테두리 1픽셀, 셀간격 없음, 셀여백 5픽셀 -->
		<tr> <!-- 행 시작 -->
			<th><b>번호</b></th> <!-- 헤더셀, 굵은글씨 -->
			<td><input type=text name=id size=70 maxlength=70 value='<%=gongji.getBunho() %>' readonly></td>
			<!-- 셀 안에 최대 70문자 입력 가능한 입력창 생성, 해당 객체의 번호값을 출력, 읽기 전용 -->
		</tr> <!-- 행 끝 -->
		<tr> <!-- 행 시작 -->
			<th><b>제목</b></th> <!-- 헤더셀, 굵은글씨 -->
			<td><input type=text name=title size=70 maxlength=70 value='<%=gongji.getJemok() %>'></td>
			<!-- 셀 안에 최대 70문자 입력 가능한 입력창 생성, 해당 객체의 제목값을 출력, title이라는 파라미터 값으로 폼에 전달-->
		</tr> <!-- 행 끝 -->
		<tr> <!-- 행 시작 -->
			<th><b>일자</b></th> <!-- 헤더셀, 굵은글씨 -->
			<td><%=formattedDate %></td> <!-- 셀 안에 해당 변수값 출력 -->
		</tr> <!-- 행 끝 -->
		<tr> <!-- 행 시작 -->
			<th><b>내용</b></th> <!-- 헤더셀, 굵은글씨 -->
			<td><textarea style='width:500px; height:250px;' name=content cols=70 row=600 maxlength=10000><%=gongji.getNaeyong() %></textarea></td>
			<!-- 셀 안에 너비 500픽셀, 세로 250픽셀, 최대 70줄, 줄마다 600자까지 입력 가능한 입력창 생성, 해당 객체의 내용값을 출력, content이라는 파라미터 값으로 폼에 전달-->
		</tr> <!-- 행 끝 -->
	</table> <!--테이블 끝-->
	<table width=650> <!-- 테이블 시작, 너비 650픽셀 -->
		<tr> <!-- 행 시작 -->
			<td width=600></td>
			<td><input type= button class="custom-button" value="취소" OnClick="location.href='gongji_list.jsp'"></td>
			<!-- 클릭하면 해당 페이지로 이동하는 취소버튼 생성 -->
			<td><input type= button class="custom-button" value="수정" OnClick="submitForm('수정')"></td>
			<!-- 클릭하면 해당 함수가 호출되는 수정버튼 생성 -->
			<td><input type= button class="custom-button" value="삭제" OnClick="submitForm('삭제')"></td>
			<!-- 클릭하면 해당 함수가 호출되는 삭제버튼 생성 -->
		</tr> <!-- 행 끝 -->
	</table> <!--테이블 끝-->
	</form> <!--form 끝-->
</body> <!--본문 끝-->
</html> <!--html언어로 작성 끝-->