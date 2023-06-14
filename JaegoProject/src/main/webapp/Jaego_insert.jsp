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
	<title>jaego_insert</title> <!--타이틀에 새겨질 글자-->
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
	 	function previewImage(event) { //버튼을 클릭하면 함수 실행
		    var input = event.target; //이벤트가 발생한 요소를 변수 input에 대입
		    var preview = document.getElementById('preview');
		    //preview라는 변수에 id가 preview인 요소를 할당, 이미지를 미리보기할 때 사용
		    if (input.files && input.files[0]) { //사용자가 선택한 파일의 목록과 첫번째 목록이 선택되었을 때
		      var reader = new FileReader(); // FileReader 객체를 생성하여 파일을 읽을 수 있게 함
		      reader.onload = function (e) {	//파일 읽기 작업이 완료되었을 때 실행되는 이벤트 핸들러
		        preview.src = e.target.result;	//미리보기 요소의 src 속성을 읽은 데이터로 설정
		        preview.style.display = 'block'; //미리보기 요소를 보이도록 설정
		      };
		      reader.readAsDataURL(input.files[0]);//FileReader 객체를 사용하여 선택한 파일을 읽음
		      //readAsDataURL 메서드는 파일의 데이터를 Base64 인코딩된 문자열로 반환
		      //이렇게 읽은 데이터는 e.target.result를 통해 접근
		    }
		  }
		function submitForm() { //버튼을 클릭하면 함수 실행
			const fm = document.getElementById('fm'); 
	        //id가 fm인 html요소를 선택하고 변수 fm에 할당
	        const itemNumber = fm.elements.itemNumber.value; 
	        //html폼 내의 이름이 itemNumber인 입력값을 가져와 변수 itemNumber에 할당
	        const inStock = fm.elements.inStock.value; 
	        //html폼 내의 이름이 inStock인 입력값을 가져와 변수 inStock에 할당
	        const itemName = fm.elements.itemName.value; 
	        //html폼 내의 이름이 itemName인 입력값을 가져와 변수 itemName에 할당
	        const explanation = fm.elements.explanation.value; 	
	        //html폼 내의 이름이 explanation인 입력값을 가져와 변수 explanation에 할당	
			const fileName = fm.elements.fileInput.value;        
	        //html폼 내의 이름이 fileInput인 입력값을 가져와 변수 fileName에 할당	
			const allowedExtensions = ['jpg', 'jpeg', 'png', 'gif'];
	        //입력을 허용하는 확장자 표시
			const fileExtension = fileName.split('.').pop().toLowerCase();
			//파일이름을 점을 기준으로 나누고 확장자부분을 꺼내어 소문자로 변환
	        const pattern1 = /^(?!\s+$).+$/; //공백을 허용하지 않는 정규식   	
	        const pattern2 = /^[0-9]\d*$/; //숫자만 입력받는 정규식
	        const pattern3 = /^(?=.*[a-zA-Z가-힣]).*$/; //영어한글 반드시 포함하는 정규식
			const pattern4 = /^[a-zA-Z0-9]+$/; //영어와 숫자만 입력받는 정규식
			if (!pattern1.test(itemNumber)) { //상품번호가 공백이면
				alert("상품번호를 입력해주세요");	//해당 알림창 띄우기
			} else if (!pattern1.test(inStock)) { //재고현황이 공백이면
				alert("재고현황을 입력해주세요");	//해당 알림창 띄우기
			} else if (!pattern1.test(itemName)) { //상품명이 공백이면
				alert("상품명을 입력해주세요");	//해당 알림창 띄우기
			} else if (!pattern1.test(explanation)) { //상품설명이 공백이면
				alert("상품설명을 입력해주세요");	//해당 알림창 띄우기
			} else if (!pattern2.test(inStock)) { //재고현황에 숫자가 아닌 값이 입력되면
				alert("재고현황은 숫자만 입력해주세요");	//해당 알림창 띄우기
			} else if (!pattern3.test(itemName)) { //상품명에 한글 영어 외의 값이 입력되면
				alert("상품명에 한글이나 영어가 포함되어야 합니다");	//해당 알림창 띄우기
			} else if (!pattern4.test(itemNumber)) { //상품번호에 영어 숫자 외의 값이 입력되면
				alert("상품번호에는 영어와 숫자만 입력해주세요");	//해당 알림창 띄우기
			} else if (!allowedExtensions.includes(fileExtension)) { //이미지파일 외의 파일이 입력되면	
				alert("이미지파일을 입력해주세요");	//해당 알림창 띄우기
			} else if (allowedExtensions.includes(fileExtension)) {	//이미지파일이 입력되면	
				fm.action = "Jaego_write.jsp"; //폼의 action을 해당 경로로 설정
				fm.submit();	//폼을 해당경로로 제출해줌
			}			
		}
	</script> <!--자바 스크립트 끝-->
<%	//scriptlet시작
	request.setCharacterEncoding("UTF-8");  //request의 문자 인코딩 utf-8 지정
	LocalDate currentDate = LocalDate.now();//LocalDate클래스를 이용하여 현재시간을 구하고 변수currentDate에 할당
   	String formattedDate = currentDate.format(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd"));
  //currentDate를 DateTimeFormatter를 이용하여 원하는 형태로 format하고 문자열형 변수 formattedDate에 할당
%> <!--scriptlet 끝-->
</head> <!--머릿말 끝-->
<body> <!--본문 시작-->
<h1>(주)트와이스 재고 현황 -상품등록</h1> <!--표제-->
	<form method=post enctype="multipart/form-data" id='fm'>
	<!-- 파일 첨부시 form tag의 method=post이어야 하고 enctype="multipart/form-data"라고 되어있어야만 한다 -->
	<table class="type10" width=650 border=1 cellspacing=0 cellpadding=5>
	<!-- 테이블 시작, 클래스 type10지정, 너비 650픽셀, 테두리 1픽셀, 셀간격 없음, 셀여백 5픽셀 -->
		<tr> <!-- 행 시작 -->
			<th><b>상품번호</b></th> <!-- 헤더셀, 굵은글씨 -->
			<td><input type=text name=itemNumber value='' maxlength=18></td>
			<!-- 셀 안에 입력창 생성, 입력받는 값을 itemNumber로 지정, 최대 18문자 가능 -->
		</tr> <!-- 행 끝 -->
		<tr> <!-- 행 시작 -->
			<th><b>상품명</b></th> <!-- 헤더셀, 굵은글씨 -->
			<td><input type=text name=itemName value='' maxlength=20></td>
			<!-- 셀 안에 입력창 생성, 입력받는 값을 itemName로 지정, 최대 20문자 가능 -->
		</tr> <!-- 행 끝 -->
		<tr> <!-- 행 시작 -->
			<th><b>재고 현황</b></th> <!-- 헤더셀, 굵은글씨 -->
			<td><input type=text name=inStock value='' maxlength=9></td>
			<!-- 셀 안에 입력창 생성, 입력받는 값을 inStock로 지정, 최대 9문자 가능 -->
		</tr> <!-- 행 끝 -->
		<tr> <!-- 행 시작 -->
			<th><b>상품등록일</b></th> <!-- 헤더셀, 굵은글씨 -->
			<td><%=formattedDate %></td> <!-- 셀 안에 해당 변수값 출력 -->
		</tr> <!-- 행 끝 -->
			<th><b>재고등록일</b></th> <!-- 헤더셀, 굵은글씨 -->
			<td><%=formattedDate %></td> <!-- 셀 안에 해당 변수값 출력 -->
		</tr> <!-- 행 끝 -->
		<tr> <!-- 행 시작 -->
			<th><b>상품설명</b></th> <!-- 헤더셀, 굵은글씨 -->
			<td><textarea name=explanation style='width:500px; height:50px; resize: none; overflow: auto;' name=content value="" cols=5 row=200 maxlength=1000></textarea></td>
			<!-- 셀 안에 텍스트입력창 생성, 입력받는 값을 explanation로 지정, 입력창 크기 고정, 최대 1000문자 가능 -->
		</tr> <!-- 행 끝 -->
		<tr> <!-- 행 시작 -->
			<th><b>상품사진</b></th> <!-- 헤더셀, 굵은글씨 -->
			<td><input type=file name=fileInput accept="image/*" onchange="previewImage(event)">
				<!-- 이미지파일 입력창 생성, 클릭하면 해당 함수가 호출됨 -->
				<br> <!-- 줄바꿈 -->
  				<img id="preview" src="#" alt="Preview" style="display: none; max-width: 400px; max-height: 400px;"></td>
  				<!-- 이미지 미리보기 설정, 사이즈 지정 -->
		</tr> <!-- 행 끝 -->
	</table> <!--테이블 끝-->
	<table width=650> <!-- 테이블 시작, 너비 650픽셀 -->
		<tr> <!-- 행 시작 -->
			<td width=600></td><!-- 셀 너비 600픽셀 -->
			<td><input type=button class="custom-button" value="완료" OnClick="submitForm()"></td>
			<!-- 버튼 생성, 클래스 custon-button 지정, 클릭하면 함수 실행 -->
		</tr> <!-- 행 끝 -->
	</table> <!--테이블 끝-->
	</form> <!--form 끝-->
</body> <!--본문 끝-->
</html> <!--html언어로 작성 끝-->