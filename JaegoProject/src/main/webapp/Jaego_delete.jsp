<%@page import="kr.ac.kopo.ctc.kopo36.service.JaegoServiceImpl"%>
<%@page import="kr.ac.kopo.ctc.kopo36.service.JaegoService"%>
<%@page import="kr.ac.kopo.ctc.kopo36.dao.JaegoDaoImpl"%>
<%@page import="kr.ac.kopo.ctc.kopo36.dao.JaegoDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--utf-8 문자 인코딩으로 html콘텐츠를 생성할 것을 지정한다-->
<!DOCTYPE html> <!-- html로 작성된 문서 -->
<html> <!--html언어로 작성 시작-->
<head> <!--머릿말 시작-->
	<meta charset="UTF-8"> <!-- utf-8 문자 인코딩 -->
	<title>jaego_delete</title> <!--타이틀에 새겨질 글자-->
	<style> /*CSS 스타일시트*/
		.custom-button { /*custom-button클래스의 버튼 셀렉터*/
            font-size: 15px;
            font-weight: bold;
            color: white;
            background-color: #e7708d;
            padding: 10px 15px;
            border: none;
        }
	</style> <!-- CSS스타일시트 끝 -->
</head> <!--머릿말 끝-->
<body> <!--본문 시작-->
<h1>(주)트와이스 재고 현황 -상품삭제</h1> <!--표제-->
	<% //scriptlet시작
	request.setCharacterEncoding("UTF-8");  //request의 문자 인코딩 utf-8 지정
	String itemNumber = request.getParameter("id"); //id값을 파라미터로 받아 문자열형 변수 itemNumber에 할당
	String itemName = request.getParameter("itemName"); //itemName값을 파라미터로 받아 문자열형 변수 itemName에 할당
	
	JaegoService jaegoService = new JaegoServiceImpl();
	//JaegoService 인터페이스를 구현한 JaegoServiceImpl 클래스의 인스턴스를 생성하여 jaegoService 변수에 할당
	int C = jaegoService.currentPageNumber(itemNumber, 20);
	//JaegoServiceImpl클래스의 currentPageNumber메서드를 호출하여 파라미터를 입력하고 리턴값을 정수형 변수인 C에 할당
	
	JaegoDao jaegoDao = new JaegoDaoImpl();
	//JaegoDao 인터페이스를 구현한 JaegoDaoImpl 클래스의 인스턴스를 생성하여 jaegoDao 변수에 할당
	jaegoDao.delete(itemNumber);
	//JaegoDaoImpl클래스의 delete메서드를 호출하여 DB의 테이블에서 itemNumber에 해당하는 자료를 삭제
	
	out.println("<h1>["+itemName+"] 상품이 삭제되었습니다.</h1>"); //해당문구 출력
	%> <!--scriptlet 끝-->
	<table width=650> <!-- 테이블 시작, 너비 650픽셀 -->
		<tr> <!-- 행 시작 -->
			<td width=600></td> <!-- 셀 너비 600픽셀 -->
			<td><input type=button class="custom-button" value="목록" OnClick="location.href='Jaego_list.jsp?pageNo=<%=C%>&cntPT=20'"></td>
			<!-- 셀 안에 버튼을 생성하여 클릭하면 해당 페이지로 이동 -->
		</tr> <!-- 행 끝 -->
	</table> <!--테이블 끝-->
</body> <!--본문 끝-->
</html> <!--html언어로 작성 끝-->