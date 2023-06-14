<%@page import="java.text.DecimalFormat"%>
<%@page import="kr.ac.kopo.ctc.kopo36.domain.Jaego"%>
<%@page import="kr.ac.kopo.ctc.kopo36.dao.JaegoDaoImpl"%>
<%@page import="kr.ac.kopo.ctc.kopo36.dao.JaegoDao"%>
<%@page import="kr.ac.kopo.ctc.kopo36.dto.pagination"%>
<%@page import="kr.ac.kopo.ctc.kopo36.service.JaegoServiceImpl"%>
<%@page import="kr.ac.kopo.ctc.kopo36.service.JaegoService"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!--utf-8 문자 인코딩으로 html콘텐츠를 생성할 것을 지정한다-->
<!DOCTYPE html> <!-- html로 작성된 문서 -->
<html> <!--html언어로 작성 시작-->
<head> <!--머릿말 시작-->
	<meta charset="UTF-8"> <!-- utf-8 문자 인코딩 -->
	<title>jaego_list</title> <!--타이틀에 새겨질 글자-->
	<style> /*CSS 스타일시트*/
		a { /*a태그 셀렉터*/
	    	text-decoration: none;
	  	}
		table.type10 { /*type10클래스의 테이블 셀렉터*/
		  border-collapse: collapse;
		  text-align: left;
		  line-height: 1.5;
		  border-top: 1px solid #ccc;
		  border-bottom: 1px solid #ccc;
		  margin: 20px 10px;
		}
		table.type10 thead th { /*type10클래스의 테이블의 thead th 셀렉터*/
		  padding: 10px;
		  font-weight: bold;
		  color: #fff;
		  background: #e7708d;
		}
		table.type10 td { /*type10클래스의 테이블의 td 셀렉터*/
		  padding: 10px;
		  vertical-align: top;
		}
		table.type10 .even { /*type10클래스의 테이블의 even클래스 셀렉터*/
		  background: #fdf3f5;
		}
		.custom-button { /*custom-button클래스의 버튼 셀렉터*/
            font-size: 15px;
            font-weight: bold;
            color: white;
            background-color: #e7708d;
            padding: 10px 15px;
            border: none;
        }
        input[type="text"] { /*텍스트 입력창 셀렉터*/
        	height: 30px;
        	font-size: 18px;
        }
	</style> <!-- CSS스타일시트 끝 -->
	<script> //자바 스크립트 시작
		function press(event, input){ //해당 이벤트가 발생하면 함수 호출
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
			    var key = document.getElementsByName("key")[0].value; //key파라미터를 받아와 변수로 선언
			    var regex1 = /^\S+$/; // 공백을 입력받지 않는 정규식
			    var regex2 = /^(?=.*[0-9])[A-Za-z0-9]+$/; //숫자 또는 영어+숫자만 입력받는 정규식
			    if (!regex1.test(key)) { //해당 정규식을 만족하지 않으면
				      alert("재고번호를 입력해주세요. 재고번호에는 공백이 포함되지 않습니다."); //알림창을 띄운다
				      return;
			    } else if (!regex2.test(key)) { //해당 정규식을 만족하지 않으면
				      alert("숫자 또는 영어와 숫자로 이루어진 바코드 번호를 입력해주세요."); //알림창을 띄운다
				      return;
				}
			    window.location = 'Jaego_view.jsp?key=' + encodeURIComponent(key); // 해당경로로 이동한다
		}
	</script> <!-- 자바 스크립트 끝 -->
</head> <!--머릿말 끝-->
<body> <!--본문 시작-->
<h1>(주)트와이스 재고 현황 -전체현황</h1> <!-- 표제 -->
<% //scriptlet시작
	request.setCharacterEncoding("UTF-8");  //request의 문자 인코딩 utf-8 지정
	String pageValue = request.getParameter("pageNo"); //pageNo파라미터를 받아와 문자열 변수pageValue에 담음
	int pageNo = 1;	//정수형 pageNo변수 선언 1로 초기화
	if (pageValue == null) { //pageNo파라미터에 값이 없으면
		pageNo = 1; //pageNo변수에 1대입
	} else { //파라미터로 받아온 값이 있으면
		pageNo = Integer.parseInt(request.getParameter("pageNo"));
	    //현재페이지 번호를 매개변수로 받아와 정수형변환하여 pageNo에 대입
	    if (pageNo < 1) pageNo = 1;
	    //pageNo가 1보다 작으면 1 대입
	}
	
	Integer cntPT = 20; //정수형 cntPT변수에 선언 20으로 초기화
	try{ //오류를 잡기 위해 try-catch 사용	    
		cntPT = Integer.parseInt(request.getParameter("cntPT")); //cntPT파라미터를 받아와 정수형변환 후 변수 cntPT에 대입 
	}catch(Exception e) { //오류 발생시
	    e.printStackTrace(); //오류메시지 출력
	}
	
	JaegoService jaegoService = new JaegoServiceImpl();
	//JaegoService 인터페이스를 구현한 JaegoServiceImpl 클래스의 인스턴스를 생성하여 jaegoService 변수에 할당
	pagination pagination = jaegoService.getPagination(pageNo, cntPT);
	//JaegoServiceImpl 클래스의 페이지넘버와 페이지당 자료수를 매개변수로 하는 getPagination 메서드를 호출하여
	//리턴값인 해당페이지에 대한 정보를 객체변수 pagination에 할당
	int C = pagination.getC(); //현재페이지넘버, pagination변수의 C값을 가져와 정수형변수로 선언한 C에 할당
	int S = pagination.getS(); //현재페이지에서 출력해줄 첫번째 페이지버튼의 페이지넘버
	int E = pagination.getE(); //현재페이지에서 출력해줄 마지막 페이지버튼의 페이지넘버
	int P = pagination.getP(); //이전페이지로 가는 버튼의 페이지넘버
	int PP = pagination.getPp(); //첫페이지로 가는 버튼의 페이지넘버
	int N = pagination.getN(); //다음페이지로 가는 버튼의 페이지넘버
	int NN = pagination.getNn(); //마지막페이지로 가는 버튼의 페이지넘버
	int count= 0; //전체자료수 조회하기 위한 정수형변수 선언 0으로 초기화
	
	JaegoDao jaegoDao = new JaegoDaoImpl();
	//JaegoDao 인터페이스를 구현한 JaegoDaoImpl 클래스의 인스턴스를 생성하여 jaegoDao 변수에 할당
	List<Jaego> jaegos = new ArrayList<>(); //jaegos객체배열 생성
	jaegos = jaegoDao.selectAll(C, cntPT);	
	//JaegoDaoImpl클래스의 selectAll메서드를 호출하여 리턴값을 jaegos객체배열에 대입
	
	if(jaegoService.count() == 0) { //전체 자료수를 리턴하는 함수를 호출하여 리턴값이 0이면
		out.println("상품이 존재하지 않습니다."); //해당 문구를 출력해줌	
		%> <!--scriptlet 끝-->
		<table> <!-- 행 시작 -->
		<tr> <!-- 행 시작 -->
			<td width=580></td> <!-- 셀 너비 580픽셀 -->
			<td><input type=button class="custom-button" value="신규 등록" OnClick="window.location='Jaego_insert.jsp'"></td>
			<!-- 클릭하면 해당 경로로 이동하는 버튼 생성 -->
		</tr> <!-- 행 끝 -->
		</table> <!-- 테이블 끝 -->
		<% //scriptlet시작
	} else { //리턴값이 0이 아니면 아래의 테이블 출력
%> <!--scriptlet 끝-->
	<form method=post name='fm'>
	<!--데이터가 HTTP post 메소드를 사용하여 제출되도록 지정, 양식 필드에 입력된 데이터가 쿼리 매개변수로 URL에 추가된다
    식별자 "fm"을 양식 요소에 할당하며 JavaScript 또는 CSS에서 양식을 참조하는 데 사용할 수 있게 한다-->   
	<table class="type10" width=680 border=1 cellspacing=0 cellpadding=5>
	<!-- 테이블 시작, 클래스 type10지정, 너비 650픽셀, 테두리 1픽셀, 셀간격 없음, 셀여백 5픽셀 -->
		<thead> <!-- 테이블 헤더 시작 -->
		<tr align=center> <!-- 행 시작 -->
			<th scope="cols" width=100px><b>상품번호</b></td> <!-- 헤더셀 굵은 글씨로 출력 -->
			<th scope="cols" width=200px><b>상품명</b></td> <!-- 헤더셀 굵은 글씨로 출력 -->
			<th scope="cols" width=100px><b>현재 재고수</b></td> <!-- 헤더셀 굵은 글씨로 출력 -->
			<th scope="cols" width=110px><b>재고파악일</b></td> <!-- 헤더셀 굵은 글씨로 출력 -->
			<th scope="cols" width=110px><b>상품등록일</b></td> <!-- 헤더셀 굵은 글씨로 출력 -->
		</tr> <!-- 행 끝 -->
		</thead> <!-- 테이블 헤더 끝 -->
<% 	 //scriptlet시작	
		DecimalFormat formatter = new DecimalFormat("#,###");
		//숫자에 뒤에서 세자리마다 쉼표를 찍어주기 위해 DecimalFormat클래스를 이용하여 formatter 생성
		
		for(int i = 0; i < jaegos.size(); i++) { //jaegos객체배열의 사이즈만큼 반복문 실행
			Jaego jaego = new Jaego(); //jaego 객체 생성
			jaego = jaegos.get(i); //jaegos객체배열의 i번째 객체를 jaego에 할당
			String title = jaego.getItem().replaceAll("<", "&lt;").replaceAll(">", "&gt;");
			String formattedInStock = formatter.format(jaego.getInStock());
			//재고수에 formatter를 이용하여 원하는 형태로 형변환후 문자열형 변수 formattedInStock에 대입
			if(i % 2 != 0) { //행 시작, 홀수행 표시
				out.println("<tr scope='row'>");
			} else { //행 시작, 짝수행 표시
				out.println("<tr scope='row' class='even'>");
			}
			out.println("<td><a href='Jaego_view.jsp?key="+jaego.getItemNumber()+"'>"+ jaego.getItemNumber() +"</a></td>");
			//셀 안에 클릭하면 해당 경로로 key값을 전달하며 이동하는 하이퍼링크 생성
			out.println("<td><a href='Jaego_view.jsp?key="+jaego.getItemNumber()+"'>"+ title +"</a></td>");
			//셀 안에 클릭하면 해당 경로로 key값을 전달하며 이동하는 하이퍼링크 생성
			out.println("<td align=right>"+ formattedInStock +"</td>"); //셀 안에 해당 변수값 출력		
			out.println("<td align=center>"+ jaego.getInvenRegisteredDate() +"</td>"); //셀 안에 해당 변수값 출력
			out.println("<td align=center>"+ jaego.getItemRegisteredDate() +"</td>"); //셀 안에 해당 변수값 출력
			out.println("</tr>"); //행 마지막 출력
		}		
%>	<!--scriptlet 끝-->
	</table> <!--테이블 끝-->
	<table> <!-- 테이블 시작 -->
		<tr> <!-- 행 시작 -->
			<td width=20></td> <!-- 셀 너비 20픽셀 -->
			<form action="Jaego_view.jsp" method="post" name="formname">
			<!-- formname폼 시작, 해당 경로로 정보를 제출 -->
	  			<td width="550"><input type="text" name="key" value="" onkeydown="press(event, this)" maxlength=30 placeholder="바코드 입력" autofocus>
	  			<!-- 셀 너비 550픽셀, 입력창 생성, 특정 이벤트가 발생하면 함수 호출, 최대길이 30문자 -->
	  			<input type=button class="custom-button" value="검색" onclick="searchJaego()"></td>
	  			<!-- 클릭하면 해당 함수를 호출하는 버튼 생성 -->
			</form> <!--form 끝-->
			<td><input type=button class="custom-button" value="신규 등록" OnClick="window.location='Jaego_insert.jsp'"></td>
			<!-- 클릭하면 해당 경로로 이동하는 버튼 생성 -->
		</tr> <!-- 행 끝 -->
	</table> <!--테이블 끝-->
	<table width=650 style="text-align: center; font-size: 30px;">
	<!-- 테이블 시작, 너비 650픽셀, 글자 가운데정렬, 글씨크기 30픽셀 -->
	<tr> <!-- 행 시작 -->
	    <td colspan=8 style="border: none;"> <!--해당 행의 8열까지 합쳐주고 테두리는 없음-->
	        <ul> <!--리스트 시작-->
	        <%  //scriptlet 시작 
	            if(10 < C) {  //현재 페이지가 10보다 클 때만 다음 두개의 버튼을 출력한다
	        %>
	                <a href="Jaego_list.jsp?pageNo=<%=PP %>&cntPT=<%=cntPT %>"><<</a> 
	                <!-- <<버튼을 누르면 첫번째 페이지로 이동한다-->
	                <a href="Jaego_list.jsp?pageNo=<%=P %>&cntPT=<%=cntPT %>"><</a>
	                <!-- <버튼을 누르면 이전 블록으로 이동한다-->
	        <%
	            }          
	             //만약 마지막 페이지수가 현 블록의 마지막 페이지 번호보다 크면
                for(int i = S; i < E + 1; i++) { //페이지번호 10개를 출력
                    if(i == C) {//페이지번호가 현재페이지번호가 될 때만 텍스트색을 red로 지정
        	%>
                        <a style="color: red;" href="Jaego_list.jsp?pageNo=<%=i %>&cntPT=<%=cntPT %>"><%=i %></a>
                        <!--현재페이지 버튼번호를 빨간색으로 출력해준다-->
        	<%
                    } else {
        	%>
                        <a href="Jaego_list.jsp?pageNo=<%=i %>&cntPT=<%=cntPT %>"><%=i %></a>
                        <!--현 블록의 페이지버튼 번호 10개를 출력해준다-->
        	<%             
                    }
                }   
	        
	    		if(NN != -1) { //첫페이지로 가는 넘버값이 -1이 아닐 때만
	        %> 
	                <a href="Jaego_list.jsp?pageNo=<%=N %>&cntPT=<%=cntPT %>">></a>
	                <!-- >버튼을 누르면 다음 블록으로 이동한다-->
	                <a href="Jaego_list.jsp?pageNo=<%=NN%>&cntPT=<%=cntPT %>">>></a>
	                <!-- >>버튼을 누르면 마지막 페이지로 이동한다-->
	        <%
	    		} 
	
	        %>  <!--scriptlet 끝-->
	        </ul><!--리스트 끝-->
	    </td> <!--셀 끝-->
	</tr> <!-- 행 끝 -->
	</table> <!--테이블 닫기-->
<% //scriptlet 시작 
} //테이블에 자료가 있을 때 테이블 출력 끝
%><!--scriptlet 끝-->
	</form> <!--form 끝-->
</body> <!--본문 끝-->
</html> <!--html언어로 작성 끝-->