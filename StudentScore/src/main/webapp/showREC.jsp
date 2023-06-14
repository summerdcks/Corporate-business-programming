<%@page import="kr.ac.kopo.ctc.kopo36.dao.StudentScoreDaoImpl"%>
<%@page import="kr.ac.kopo.ctc.kopo36.domain.StudentScore"%>
<%@page import="kr.ac.kopo.ctc.kopo36.dao.StudentScoreDao"%>
<meta http-equiv="Content-Type" content="text/html; charset-utf-8"/>
<!--html 메타태그: 문서의 문자 인코딩을 utf-8로 설정한다-->
<%@ page contentType="text/html; charset=utf-8" %>
<!--utf-8 문자 인코딩으로 html콘텐츠를 생성할 것을 지정한다-->
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>
<!--java.sql과 javax.sql 패키지를 가져와 데이터베이스 접근과 조작을 위한 클래스와
인터페이스를 제공한다. java.io패키지를 가져와 입력 및 출력 작업에 사용되는 클래스를 제공한다-->
<html> <!--html언어로 작성 시작-->
<head> <!--머릿말 시작-->
    <style> /*스타일시트 시작*/
        table, td { /*table, td태그 셀렉터*/
            border: 1px double black; /*테두리 1픽셀 두줄 검은색 지정*/
            text-align: center; /*글자 가운데 정렬*/
            height: 30px; /*높이 30픽셀*/
        }   
     </style> <!--스타일시트 끝-->
     <% //scriptlet시작
        String name=""; //문자형 변수 name에 빈값 대입
        Integer kor =0; //정수형 변수 kor에 0 대입
        Integer eng =0; //정수형 변수 eng에 0 대입
        Integer mat =0; //정수형 변수 mat에 0 대입
        Integer sid =0; //정수형 변수 id에 0 대입
      
try{
	    sid = Integer.parseInt(request.getParameter("studentid"));
	    //studentid값을 파라미터로 받아와 변수 sid에 대입
	    StudentScoreDao studentScoreDao = new StudentScoreDaoImpl();
	  	//StudentScoreDao 인터페이스를 구현한 StudentScoreDaoImpl 클래스의 인스턴스를 생성하여 studentScoreDao 변수에 할당
		StudentScore studentScore = new StudentScore();
		//StudentScore클래스의 인스턴스를 생성하여 studentScore변수에 할당
		studentScore = studentScoreDao.selectOne(sid);
		//StudentScoreDaoImpl클래스의 id를 매개변수로 받는 selectOne메서드를 호출하여 리턴값을 studentScore변수에 할당
		if (studentScore.getName() == null) { //studentScore객체의 이름에 값이 없으면
			name = "해당학번없음"; //해당 문자열을 name에 대입
		} else { //값이 있으면
			name = studentScore.getName(); //studentScore의 이름을 name에 대입
	        sid = studentScore.getStudentId();  //studentScore의 학번을 name에 대입
	        kor = studentScore.getKor();  //studentScore의 국어점수를 name에 대입
	        eng = studentScore.getEng();  //studentScore의 영어점수를 name에 대입
	        mat = studentScore.getMat();  //studentScore의 수학점수를 name에 대입
		}
        %> <!--scriptlet 끝-->
<script> //자바스크립트 시작
function update(msg) { //msg값을 매개변수로 받는 함수 update 생성
    const form = document.getElementById('form_1'); //id가 form_1인 html을 받아와 form에 할당한다
    if (msg =='수정'){ //msg가 "수정"이면 해당 내용 실행
        const form = document.getElementById('form_1');
         //id가 form_1인 html을 받아와 form에 할당한다
        const username = form.elements.name.value;
        //form html에서 name으로 입력된 값을 받아와 username에 할당한다
        const korean = parseFloat(form.elements.kor.value);
        //form html에서 kor으로 입력된 값을 받아와 실수형변환하고 korean에 할당한다
        const english = parseFloat(form.elements.eng.value);
        //form html에서 eng으로 입력된 값을 받아와 실수형변환하고 english에 할당한다
        const math =  parseFloat(form.elements.mat.value);
        //form html에서 mat으로 입력된 값을 받아와 실수형변환하고 math에 할당한다
        const pattern1 = /^([a-zA-Z]|[가-힣])+$/; //한글,영어만 입력받는 정규식1 생성
        const pattern2 = /^.{1,20}$/; //20자 이내만 입력받는 정규식2 생성
        const pattern3 = /^(?:100|[1-9]?[0-9])$/; //0~100사이의 정수값만 입력받는 정규식3 생성
        if(!pattern1.test(username)) { //username값이 정규식1을 만족하지 않으면 
            alert("이름에 한글, 영어를 입력해주세요"); //해당문구를 알림창에 띄워준다
        } else if (!pattern2.test(username)) { //username값이 정규식2을 만족하지 않으면 
            alert("이름은 20자 이내로 입력해주세요"); //해당문구를 알림창에 띄워준다
        } else if (!pattern3.test(korean) || !pattern3.test(english) || !pattern3.test(math)) {
            //국어, 영어, 수학점수가 정규식3을 만족하지 않으면
            alert("유효한 점수를 입력해주세요"); //해당문구를 알림창에 띄워준다
        } else { //변수값들이 모두 위의 정규식들을 만족하면
            form.action = 'updateDB.jsp';  //form의 action요소를 updateDB.jsp로 지정해준다
            form.submit(); //form의 데이터를 해당 경로로 제출한다
        }
    } else if(msg =='삭제') { //msg가 "삭제"면 해당 내용 실행
            form.action = 'deleteDB.jsp'; //form의 action요소를 deleteDB.jsp로 지정해준다
            form.submit(); //form의 데이터를 해당 경로로 제출한다
    }
}
function submit1() { //함수 submit1 생성
    const form = document.getElementById('form_2');
     //id가 form_2인 html을 받아와 form에 할당한다
    const studentid = parseFloat(form.elements.studentid.value); 
    //form html에서 studentid로 입력된 값을 받아와 실수형변환하고 변수 studentid에 대입한다
    const pattern = /^[0-9]{6}$/; //6자리 정수만 받는 정규식 생성
    if(!pattern.test(studentid)) { //studentid값이 정규식을 만족하지 않으면
        alert("학번에 6자리 숫자를 입력해주세요"); //해당문구를 알림창에 띄워준다
    } else { //정규식을 만족하면
        form.action='showREC.jsp'; //form의 action요소를 showREC.jsp로 지정해준다
        form.submit(); //form의 데이터를 해당 경로로 제출한다
    }
}
window.onload = function() { //윈도우가 로드될 때 적용되는 함수
    document.querySelector('input[name="name"]').focus(); 
    //name이 username인 입력창에 오토포커스가 되도록 함
}
</script> <!--자바 스크립트 끝-->
</head> <!--머릿말 끝-->
<body> <!--본문 시작-->
<h1>조회 처리</h1> <!--표제-->
    <form method="get" id="form_2">
    <!--데이터가 HTTP GET 메소드를 사용하여 제출되도록 지정, 양식 필드에 입력된 데이터가 쿼리 매개변수로 URL에 추가된다
    식별자 "form_2"을 양식 요소에 할당하며 JavaScript 또는 CSS에서 양식을 참조하는 데 사용할 수 있게 한다-->
    <table style="border: none;"> <!-- 테이블 생성, 테두리 없음 -->
    	<tr><td style="border: none;"> <!-- 행열 생성, 테두리 없음 -->
       	조회할 학번 <input type="number" name="studentid" min="100000" max="999999"> <input type="button" value="조회" onclick="submit1()">
        <!--입력창을 생성하고 최소값 최대값을 설정하여 number를 받아 studentid변수로 선언한다--><!-- 클릭버튼을 생성하고 안의 텍스트는 "추가", 클릭하면 submit1함수가 호출된다-->
        </td></tr> <!-- 행열 끝 -->
    </table></form> <!--테이블 끝 --><!--form끝-->
    
    <form method="get" id="form_1">
    <!--데이터가 HTTP GET 메소드를 사용하여 제출되도록 지정, 양식 필드에 입력된 데이터가 쿼리 매개변수로 URL에 추가된다
    식별자 "form_1"을 양식 요소에 할당하며 JavaScript 또는 CSS에서 양식을 참조하는 데 사용할 수 있게 한다-->
        <table> <!--테이블 생성-->
            <tr> <!--행 시작-->
                <td style="width:100px;">이름</td> <!--너비 100픽셀의 셀 지정, 해당 문구 출력-->
                <td style="width:300px;"><input type="text" name="name" value="<%=name%>"></td>
                <!--너비 300픽셀의 셀 지정, 텍스트를 입력받아 입력받은 값을 name으로 지정한다-->
            </tr> <!--행 끝-->
            <tr> <!--행 시작-->
                <td>학번</td> <!--셀 안에 해당 문구 출력-->
                <td><input type="hidden" name="sid" value="<%=sid%>" readonly><%=sid%></td>
                <!--텍스트를 입력받고 입력받은 값을 sid으로 지정한다-->
            </tr> <!--행 끝-->
            <tr> <!--행 시작-->
                <td>국어</td> <!--셀 안에 해당 문구 출력-->
                <td><input type="number" name="kor" value="<%=kor%>" min="0" max="100"></td>
                <!--0~100사이의 숫자값을 입력받고 입력받은 값을 kor으로 지정한다-->
            </tr> <!--행 끝-->
            <tr> <!--행 시작-->
                <td>영어</td> <!--셀 안에 해당 문구 출력-->
                <td><input type="number" name="eng" value="<%=eng%>" min="0" max="100"></td>
                <!--0~100사이의 숫자값을 입력받고 입력받은 값을 eng으로 지정한다-->
            </tr> <!--행 끝-->
            <tr> <!--행 시작-->
                <td>수학</td> <!--셀 안에 해당 문구 출력-->
                <td><input type="number" name="mat" value="<%=mat%>" min="0" max="100"></td>
                <!--0~100사이의 숫자값을 입력받고 입력받은 값을 mat으로 지정한다-->
            </tr> <!--행 끝-->
        </table> <!--테이블 끝-->
    <% //scriptlet 시작   
        if(name != "해당학번없음") { //name이 해당학번없음이 아니면 다음의 버튼을 출력
    %> <!--scriptlet 끝-->
     <table style="border: none; text-align:left"> <!-- 테이블 생성, 테두리 없음, 글자 왼쪽 정렬 -->
    	<tr><td style="border: none; text-align:left"> <!-- 행열 시작, 테두리 없음, 글자 왼쪽 정렬 -->
            <input type="button" value="수정" onclick="update('수정')">
            <!--버튼을 생성, 클릭하면 수정 문자열을 매개변수로 받는 update함수를 호출한다-->
            </td> <!-- 열 끝 -->
            <td style="border: none; text-align:right"> <!-- 열 시작, 테두리 없음, 글자 왼쪽 정렬 -->
        <div style='width:363px;float: right;'> <!-- div 생성, 너비 363픽셀, 오른쪽 유동정렬 -->
            <input type="button" value="삭제" onclick="update('삭제')">
            <!--버튼을 생성, 클릭하면 삭제 문자열을 매개변수로 받는 update함수를 호출한다-->
        </div> <!--div 끝 -->
        </td></tr> <!-- 행열 끝 -->
     </table> <!-- 테이블 끝 -->
            
    <%  //scriptlet 시작   
        } else {  //name이 해당학번없음이면 아무 버튼도 출력하지 않는다
        } 
}catch(Exception e) {
	out.println("테이블이 존재하지 않습니다.");
}
    %> <!--scriptlet 끝-->
    </form> <!--form 끝-->
</body> <!--본문 끝-->
</html> <!--html언어로 작성 끝-->
