<%@page import="kr.ac.kopo.ctc.kopo36.service.JaegoServiceImpl"%>
<%@page import="kr.ac.kopo.ctc.kopo36.service.JaegoService"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="kr.ac.kopo.ctc.kopo36.domain.Jaego"%>
<%@page import="kr.ac.kopo.ctc.kopo36.dao.JaegoDaoImpl"%>
<%@page import="kr.ac.kopo.ctc.kopo36.dao.JaegoDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!--utf-8 문자 인코딩으로 html콘텐츠를 생성할 것을 지정한다-->
<!DOCTYPE html> <!-- html로 작성된 문서 -->
<html> <!--html언어로 작성 시작-->
<head> <!--머릿말 시작-->
	<meta charset="UTF-8"> <!-- utf-8 문자 인코딩 -->
	<title>jaego_view</title> <!--타이틀에 새겨질 글자-->
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
        img { /*img 태그 셀렉터*/
        	width: 200px;
        }
		.custom { /*costom class 셀렉터*/
        	height: 30px;
        	font-size: 18px;
        }
	</style> <!-- 스타일시트 끝 -->
	<script> //자바스크립트 시작
		function deleteItem() { //해당 함수가 호출되면
			fm.action='Jaego_delete.jsp?key=id'; // 폼의 action을 해당경로로 설정
			fm.submit();	//폼을 해당경로로 제출해줌
		}
		function updateItem() { //해당 함수가 호출되면
			fm.action='Jaego_update.jsp?key=id';// 폼의 action을 해당경로로 설정
			fm.submit();	//폼을 해당경로로 제출해줌
		}
		function press(event, input){ //event가 발생하면 해당 함수가 호출
			if(event.keyCode === 13){ // 자바스크립트에서 13은 enter를 의미한다
			    event.preventDefault(); // 자동으로 submit되는 것을 방지한다
			    var key = input.value; // 입력란에 받은 값을 key로 받는다
			    var regex1 = /^\S+$/; // 공백을 입력받지 않는 정규식
			    var regex2 = /^(?=.*[0-9])[A-Za-z0-9]+$/; //숫자 또는 영어+숫자만 입력받는 정규식
			    if (!regex1.test(key)) { //해당 정규식을 만족하지 않으면
			      alert("재고번호를 입력해주세요. 재고번호에는 공백이 포함되지 않습니다."); //알림창을 띄운다
			      return;
			    } else if (!regex2.test(key)) { //해당 정규식을 만족하지 않으면
			      alert("숫자 또는 영어와 숫자로 이루어진 바코드 번호를 입력해주세요."); //알림창을 띄운다
			      return;
				}
			    location.href = "Jaego_view.jsp?key=" + key; // 해당경로로 이동한다
			}
		}
		function searchJaego() {
			    var key = document.getElementsByName("key")[0].value; //key파라미터값을 받아와 변수로 선언
			    var regex1 = /^\S+$/; // 공백을 입력받지 않는 정규식
			    var regex2 = /^(?=.*[0-9])[A-Za-z0-9]+$/; //숫자 또는 영어+숫자만 입력받는 정규식
			    if (!regex1.test(key)) { //해당 정규식을 만족하지 않으면
				      alert("재고번호를 입력해주세요. 재고번호에는 공백이 포함되지 않습니다."); //알림창을 띄운다
				      return;
			    } else if (!regex2.test(key)) { //해당 정규식을 만족하지 않으면
				      alert("숫자 또는 영어와 숫자로 이루어진 바코드 번호를 입력해주세요."); //알림창을 띄운다
				      return;
				}
			    window.location = 'Jaego_view.jsp?key=' + encodeURIComponent(key); //해당경로로 이동한다
		}
	</script> <!--자바 스크립트 끝-->
<%	//scriptlet시작 
	request.setCharacterEncoding("UTF-8");  //request의 문자 인코딩 utf-8 지정
	String itemNumber = request.getParameter("key");//key값을 파라미터로 받아 문자열형 변수 itemNumber에 할당
	JaegoDao jaegoDao = new JaegoDaoImpl();
	//JaegoDao 인터페이스를 구현한 JaegoDaoImpl 클래스의 인스턴스를 생성하여 jaegoDao 변수에 할당
	Jaego jaego = new Jaego(); //jaego 객체 생성
	jaego = jaegoDao.OneView(itemNumber);
	//JaegoDaoImpl 클래스의 OneView메서드를 호출하여 해당 itemNumber의 자료를 리턴값으로 받아 jaego객체에 할당
	
	if(jaego == null || jaego.getItem() == null) { //해당 객체가 null값이거나 해당 객체의 item이 null값이면 
%>	
	<h1>존재하지 않는 재고번호입니다.</h1> <!-- 표제 -->
	<h1>다시 검색해주세요.</h1> <!-- 표제 -->
		<table width=650> <!-- 테이블 너비 650픽셀 -->
		<tr> <!-- 행 시작 -->
			<td width=20></td> <!-- 셀 너비 20픽셀 -->
			<form action="Jaego_view.jsp" method="post" name="formname">
			<!-- formname폼 시작, 해당 경로로 정보를 제출 -->
	  			<td width="550"><input type="text" class="custom" name="key" value="" onkeydown="press(event, this)" maxlength=30 placeholder="바코드 입력" autofocus>
	  			<!-- 셀 너비 550픽셀, 입력창 생성, 특정 이벤트가 발생하면 함수 호출, 최대길이 30문자 -->
	  			<input type=button class="custom-button" value="검색" onclick="searchJaego()"></td>
	  			<!-- 클릭하면 해당 함수가 호출되는 버튼을 생성 -->
			</form> <!--form 끝-->
			<td><input type=button class="custom-button" value="목록으로 돌아가기" OnClick="location.href='Jaego_list.jsp'"></td>
			<!-- 클릭하면 해당 페이지로 이동하는 버튼 생성 -->
		</tr> <!-- 행 끝 -->
	</table> <!-- 테이블 끝 -->
<% //scriptlet 시작
	} else { //해당 객체에 값이 있으면
	DecimalFormat formatter = new DecimalFormat("#,###"); //DecimalFormat클래스를 이용하여 숫자를 뒤에서 세자리마다 쉼표처리 해주는 formatter 생성
	String formattedInStock = formatter.format(jaego.getInStock()); //재고수에 해당 formatter를 적용하여 문자열형 변수 formattedInStock에 할당
	
	JaegoService jaegoService = new JaegoServiceImpl();
	//JaegoService 인터페이스를 구현한 JaegoDaoImpl 클래스의 인스턴스를 생성하여 jaegoService 변수에 할당
	int C = jaegoService.currentPageNumber(jaego.getItemNumber(), 20);
	//JaegoDaoImpl클래스의 currentPageNumber메서드를 호출하여 해당 재고번호가 존재하는 페이지번호를 리턴값으로 받아 정수형 변수 C에 대입
	
	String title = jaego.getItem().replaceAll("<", "&lt;").replaceAll(">", "&gt;");
	//괄호를 이스케이프하여 HTML이나 XML 태그의 일부로 해석되지 않고 문자 그대로 처리하기 위해 변형하여 문자열형 변수에 대입
  	String explanation = jaego.getExplanation().replaceAll("<", "&lt;").replaceAll(">", "&gt;");
  	//괄호를 이스케이프하여 HTML이나 XML 태그의 일부로 해석되지 않고 문자 그대로 처리하기 위해 변형하여 문자열형 변수에 대입
%> <!-- scriptlet 끝 -->
</head> <!-- 머릿말 끝 -->
<body> <!-- 본문 시작 -->
<h1>(주)트와이스 재고 현황 -상품상세</h1> <!-- 표제 -->
	<form method=post name='fm'>
	<!--데이터가 HTTP post 메소드를 사용하여 제출되도록 지정, 양식 필드에 입력된 데이터가 쿼리 매개변수로 URL에 추가된다
	식별자 "fm"을 양식 요소에 할당하며 JavaScript 또는 CSS에서 양식을 참조하는 데 사용할 수 있게 한다-->   
	<table class="type10" width=650 border=1 cellspacing=0 cellpadding=5>
	<!-- 테이블 시작, 클래스 type10지정, 너비 650픽셀, 테두리 1픽셀, 셀간격 없음, 셀여백 5픽셀 -->
		<tr> <!-- 행 시작 -->
			<th width=100><b>상품 번호</b></th> <!-- 헤더셀 너비 100픽셀, 굵은 글씨로 출력 -->
			<td width=500><%=jaego.getItemNumber()%><input type=hidden name=id value='<%=jaego.getItemNumber() %>'></td>
			<!-- 셀 너비 500픽셀, 해당값을 출력해줌, id라는 파라미터로 해당 값을 폼에 전달 -->
		</tr> <!-- 행 끝 -->
		<tr> <!-- 행 시작 -->
			<th><b>상품명</b></th> <!-- 헤더셀 굵은 글씨로 출력 -->
			<td><input type=text name=itemName value='<%=title %>' readonly></td>
			<!-- 셀 안에 해당값 출력, itemName이라는 파라미터로 해당 값을 폼에 전달 -->
		</tr> <!-- 행 끝 -->
		<tr> <!-- 행 시작 -->
			<th><b>재고 현황</b></th> <!-- 헤더셀 굵은 글씨로 출력 -->
			<td><%=formattedInStock%></td> <!-- 셀 안에 해당값 출력 -->
		</tr> <!-- 행 끝 -->
		<tr> <!-- 행 시작 -->
			<th><b>상품등록일</b></th> <!-- 헤더셀 굵은 글씨로 출력 -->
			<td><%=jaego.getItemRegisteredDate() %></td> <!-- 셀 안에 해당값 출력 -->
		</tr> <!-- 행 끝 -->
		<tr> <!-- 행 시작 -->
			<th><b>재고등록일</b></th> <!-- 헤더셀 굵은 글씨로 출력 -->
			<td><%=jaego.getInvenRegisteredDate() %></td> <!-- 셀 안에 해당값 출력 -->
		</tr> <!-- 행 끝 -->
		<tr> <!-- 행 시작 -->
			<th><b>상품설명</b></th> <!-- 헤더셀 굵은 글씨로 출력 -->
			<td><textarea style='width:500px; height:50px; resize: none; overflow: auto;' name=content cols=5 row=200 maxlength=1000 readonly><%=explanation %></textarea></td>
			<!-- 셀 안에 텍스트 입력창 생성, 크기 고정, 오토포커스, 최대 1000자, 읽기 전용, 해당 변수값을 출력해준다 -->
		</tr> <!-- 행 끝 -->
		<tr> <!-- 행 시작 -->
			<th><b>상품사진</b></th> <!-- 헤더셀 굵은 글씨로 출력 -->
			<td><img alt="" src="<%=jaego.getImageName()%>"></td> <!-- 셀 안에 해당값 출력 -->
		</tr> <!-- 행 끝 -->
	</table> <!-- 테이블 끝 -->
	<table width=650> <!-- 테이블 너비 650픽셀 -->
		<tr> <!-- 행 시작 -->
			<td width=600></td> <!-- 셀 너비 600픽셀 -->
			<td><input type=button class="custom-button" value="상품삭제" OnClick="deleteItem()"></td>
			<!-- 클릭하면 해당 함수를 호출하는 버튼 생성 -->
			<td><input type=button class="custom-button" value="재고수정" OnClick="updateItem()"></td>
			<!-- 클릭하면 해당 함수를 호출하는 버튼 생성 -->
			<td><input type=button class="custom-button" value="목록" OnClick="location.href='Jaego_list.jsp?pageNo=<%=C%>'"></td>
			<!-- 클릭하면 해당 경로로 이동하는 버튼 생성 -->
		</tr> <!-- 행 끝 -->
	</table> <!-- 테이블 끝 -->
	</form> <!-- 폼 끝 -->
<% } %>
</body> <!-- 본문 끝 -->
</html> <!-- html언어로 작성 끝 -->