<%@page import="kr.ac.kopo.ctc.kopo36.domain.StudentScore"%>
<%@page import="kr.ac.kopo.ctc.kopo36.dao.StudentScoreDaoImpl"%>
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
	 request.setCharacterEncoding("UTF-8");
     String name=""; //문자형 변수 name에 빈값 대입
     int kor =0; //정수형 변수 kor에 0 대입
     int eng =0; //정수형 변수 eng에 0 대입
     int mat =0; //정수형 변수 mat에 0 대입
     int id =0; //정수형 변수 id에 0 대입
     try{        
        name = request.getParameter("username"); //username값을 파라미터로 받아와 변수 name에 대입
        kor = Integer.parseInt(request.getParameter("korean"));
        //korean값을 파라미터로 받아와 정수형변환하고 kor에 대입
        eng = Integer.parseInt(request.getParameter("english"));
        //english값을 파라미터로 받아와 정수형변환하고 eng에 대입
        mat = Integer.parseInt(request.getParameter("math"));
        //math값을 파라미터로 받아와 정수형변환하고 mat에 대입
       	
       	StudentScoreDao studentScoreDao = new StudentScoreDaoImpl();
      	//StudentScoreDao 인터페이스를 구현한 StudentScoreDaoImpl 클래스의 인스턴스를 생성하여 studentScoreDao 변수에 할당
   		StudentScore studentScore = new StudentScore();
   		//StudentScore클래스의 인스턴스를 생성하여 studentScore변수에 할당
   		StudentScore insertComplete = new StudentScore();
   		//StudentScore클래스의 인스턴스를 생성하여 insertComplete변수에 할당
   		studentScore.setName(name); //studentScore에 이름입력
   		studentScore.setKor(kor); //studentScore에 국어점수입력
   		studentScore.setEng(eng); //studentScore에 영어점수입력
   		studentScore.setMat(mat); //studentScore에 수학점수입력
   		insertComplete = studentScoreDao.insert(studentScore);
   		//studentScore객체의 정보를 StudentScoreDaoImpl클래스의 insert함수를 이용하여 테이블에 입력하고
   		//리턴값을 insertComplete로 받아 아랫단에서 출력하여 제대로 입력되었는지 확인      
   		if(insertComplete == null) {
   			out.println("테이블이 존재하지 않습니다.");
   		} else {
%> <!--scriptlet 끝-->          
</head> <!--머릿말 끝-->
<body> <!--본문 시작-->
<h1>성적입력추가완료</h1> <!--표제-->
		<table style="border: none;"> <!-- 테이블 생성, 테두리 없음 -->
		<tr><td style="border: none;"> <!-- 행열 시작, 테두리 없음 -->
    	<div style='width:750px;float: right;'> <!-- div태그 설정, 너비 750픽셀, 오른쪽 유동정렬 -->
      		<button onclick = "location.href = 'inputForm1.html'">뒤로가기</button>
      		 <!--div태그 설정, 클릭하면 해당경로로 이동하는 버튼을 생성한다-->
        </div> <!-- div태그 끝 -->
		</td></tr> <!-- 행열 끝 -->
		</table> <!-- 테이블 끝 -->
        <table> <!--테이블 시작-->
            <tr> <!--행 시작-->
                <td style="width:100px;">이름</td>  <!--셀 너비 100픽셀 설정, 셀 안에 해당 문구 출력-->
                <td style="width:300px;"><%=insertComplete.getName() %></td> <!--셀 너비 300픽셀 설정, insertComplete객체의 name값 출력-->
            </tr> <!--행 끝-->
            <tr> <!--행 시작-->
                <td>학번</td> <!--셀 안에 해당 문구 출력-->
                <td><%=insertComplete.getStudentId() %></td> <!-- insertComplete객체의 id값 출력-->
            </tr> <!--행 끝-->
            <tr> <!--행 시작-->
                <td>국어</td> <!--셀 안에 해당 문구 출력-->
                <td><%=insertComplete.getKor() %></td> <!-- insertComplete객체의 kor값 출력-->
            </tr> <!--행 끝-->
            <tr> <!--행 시작-->
                <td>영어</td> <!--셀 안에 해당 문구 출력-->
                <td><%=insertComplete.getEng() %></td> <!-- insertComplete객체의 eng값 출력-->
            </tr> <!--행 끝-->
            <tr> <!--행 시작-->
                <td>수학</td> <!--셀 안에 해당 문구 출력-->
                <td><%=insertComplete.getMat() %></td> <!-- insertComplete객체의 mat값 출력-->
            </tr> <!--행 끝-->    
        </table> <!--테이블 끝-->
<% //scriptlet 시작
   		}
        } catch (NumberFormatException e) { //NumberFormatException이 발생하면
            out.println(e); //해당 오류내역을 출력해준다
        } catch (Exception e) { //그 외 Exception이 발생하면
            out.println(e); //해당 오류내역을 출력해준다
        }
 %> <!--scriptlet 끝-->
</body> <!--본문 끝-->
</html> <!--html언어로 작성 끝-->
