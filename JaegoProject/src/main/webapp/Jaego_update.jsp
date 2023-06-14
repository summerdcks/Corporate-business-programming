<%@page import="java.text.DecimalFormat"%>
<%@page import="kr.ac.kopo.ctc.kopo36.domain.Jaego"%>
<%@page import="kr.ac.kopo.ctc.kopo36.dao.JaegoDaoImpl"%>
<%@page import="kr.ac.kopo.ctc.kopo36.dao.JaegoDao"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!--utf-8 문자 인코딩으로 html콘텐츠를 생성할 것을 지정한다-->
<!DOCTYPE html> <!-- html로 작성된 문서 -->
<html> <!--html언어로 작성 시작-->
<head> <!--머릿말 시작-->
	<meta charset="UTF-8"> <!-- utf-8 문자 인코딩 -->
	<title>jaego_update</title> <!--타이틀에 새겨질 글자-->
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
		.custom-button { /*type10클래스의 테이블의 even클래스 셀렉터*/
            font-size: 15px;
            font-weight: bold;
            color: white;
            background-color: #e7708d;
            padding: 10px 15px;
            border: none;
        }
         img { /*img 태그 셀렉터*/
        	width: 200px;
        }
	</style> <!-- CSS스타일시트 끝 -->
	<script> //자바 스크립트 시작
		function submitForm() {
			const fm = document.getElementById('fm'); 
	        //id가 fm인 html요소를 선택하고 변수 fm에 할당
	        const inStock = fm.elements.inStock.value; 
	        //html폼 내의 이름이 inStock인 입력값을 가져와 변수 inStock에 할당
	        const pattern1 = /^(?!\s+$).+$/; //공백을 허용하지 않는 정규식
	        const pattern2 = /^[0-9]\d*$/; //숫자만 입력받는 정규식
			if (!pattern1.test(inStock)) { //해당 변수가 정규식을 만족하지 않으면
				alert("재고현황을 입력해주세요");	//알림창 띄움
			} else if (!pattern2.test(inStock)) { //해당 변수가 정규식을 만족하지 않으면
				alert("0 이상의 숫자만 입력해주세요"); //알림창 띄움
			} else {
				fm.action = "Jaego_write.jsp"; //폼의 action 설정
				fm.submit(); //해당 경로로 폼을 제출함
			}
		}
	</script> <!-- 자바 스크립트 끝 -->
<%	 //scriptlet시작
	request.setCharacterEncoding("UTF-8");   //request의 문자 인코딩 utf-8 지정
	String itemNumber = request.getParameter("id"); //id를 파라미터로 받아와 문자열 변수 itemNumber에 담음
	JaegoDao jaegoDao = new JaegoDaoImpl();
	//JaegoDao 인터페이스를 구현한 JaegoDaoImpl 클래스의 인스턴스를 생성하여 jaegoDao 변수에 할당
	Jaego jaego = new Jaego(); //jaego객체 생성
	jaego = jaegoDao.OneView(itemNumber);
	//JaegoDaoImpl클래스에서 OneView메서드를 호출하여 db에서 해당itemNumber를 가진 자료를 조회하고 jaego객체에 대입함
	String title = jaego.getItem().replaceAll("<", "&lt;").replaceAll(">", "&gt;");
	//괄호를 이스케이프하여 HTML이나 XML 태그의 일부로 해석되지 않고 문자 그대로 처리하기 위해 변형하여 문자열형 변수에 대입
	String ex = jaego.getExplanation().replaceAll("<", "&lt;").replaceAll(">", "&gt;");
	//괄호를 이스케이프하여 HTML이나 XML 태그의 일부로 해석되지 않고 문자 그대로 처리하기 위해 변형하여 문자열형 변수에 대입
%> <!--scriptlet 끝-->
</head> <!--머릿말 끝-->
<body> <!--본문 시작-->
<h1>(주)트와이스 재고 현황 -재고수정</h1> <!-- 표제 -->
	<form method=post enctype="multipart/form-data" id='fm'>
	<!--데이터가 HTTP post 메소드를 사용하여 제출되도록 지정, 양식 필드에 입력된 데이터가 쿼리 매개변수로 URL에 추가된다
    식별자 "fm"을 양식 요소에 할당하며 JavaScript 또는 CSS에서 양식을 참조하는 데 사용할 수 있게 한다-->   
	<table class="type10" width=650 border=1 cellspacing=0 cellpadding=5>
	 <!-- 테이블 시작, 클래스 type10지정, 너비 650픽셀, 테두리 1픽셀, 셀간격 없음, 셀여백 5픽셀 -->
		<tr> <!-- 행 시작 -->
			<th width=100px><b>상품 번호</b></th> <!-- 헤더셀 너비100픽셀, 굵은글씨 -->
			<td width=500px><input type=hidden name=itemNumber value='<%=jaego.getItemNumber()%>' maxlength=20><%=jaego.getItemNumber() %></td>
			<!-- 셀너비 500픽셀, 해당 변수값 출력, 해당 value를 itemNumber라는 파라미터로 폼에 전달하기 위한 hidden입력창 생성 -->
		</tr> <!-- 행 끝 -->
		<tr> <!-- 행 시작 -->
			<th><b>상품명</b></th> <!-- 헤더셀, 굵은글씨 -->
			<td><input type=hidden name=itemName value='<%=jaego.getItem()%>' maxlength=20><%=title%></td>
			<!-- 셀 안에 해당 변수값 출력, 해당 value를 itemName이라는 파라미터로 폼에 전달하기 위한 hidden입력창 생성 -->
		</tr> <!-- 행 끝 -->
		<tr> <!-- 행 시작 -->
			<th><b>재고 현황</b></th> <!-- 헤더셀, 굵은글씨 -->
			<td><input type=text name=inStock value='<%=jaego.getInStock() %>' maxlength=9></td>
			<!-- 셀 안에 입력창 생성, 최대 9문자 입력가능, 해당변수값을 출력하고 inStock이라는 파라미터로 폼에 전달 -->
		</tr> <!-- 행 끝 -->
		<tr> <!-- 행 시작 -->
			<th><b>상품등록일</b></th> <!-- 헤더셀, 굵은글씨 -->
			<td><%=jaego.getItemRegisteredDate() %></td> <!-- 셀 안에 해당 변수값 출력 -->
		</tr> <!-- 행 끝 -->
		<tr> <!-- 행 시작 -->
			<th><b>재고등록일</b></th> <!-- 헤더셀, 굵은글씨 -->
			<td><%=jaego.getInvenRegisteredDate() %></td> <!-- 셀 안에 해당 변수값 출력 -->
		</tr> <!-- 행 끝 -->
		<tr> <!-- 행 시작 -->
			<th><b>상품설명</b></th> <!-- 헤더셀, 굵은글씨 -->
			<td><textarea style='width:500px; height:50px; resize: none; overflow: auto;' name=content cols=5 row=200 maxlength=1000 readonly><%=ex %></textarea></td>
			 <!-- 셀 안에 텍스트 입력창 생성, 읽기 전용, 사이즈 고정, 오토포커스, 최대 1000문자, 해당 변수값을 출력해준다-->
		</tr> <!-- 행 끝 -->
		<tr> <!-- 행 시작 -->
			<th><b>상품사진</b></th> <!-- 헤더셀, 굵은글씨 -->
			<td><img alt="" src="<%=jaego.getImageName() %>"></td> <!-- 셀 안에 해당 변수값 출력 -->
		</tr> <!-- 행 끝 -->
	</table> <!-- 테이블 끝 -->
	<table width=650> <!-- 테이블 너비 650픽셀 -->
		<tr> <!-- 행 시작 -->
			<td width=600></td> <!-- 셀 너비 600픽셀 -->
			<td><input type=button class="custom-button" value="재고수정" OnClick="submitForm()"></td>
			<!-- 클릭하면 해당 함수가 호출되는 버튼 생성 -->
		</tr> <!-- 행 끝 -->
	</table> <!--테이블 끝-->
	</form> <!--form 끝-->
</body> <!--본문 끝-->
</html> <!--html언어로 작성 끝-->