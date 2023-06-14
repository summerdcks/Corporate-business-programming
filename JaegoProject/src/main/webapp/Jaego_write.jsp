<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="kr.ac.kopo.ctc.kopo36.service.JaegoServiceImpl"%>
<%@page import="kr.ac.kopo.ctc.kopo36.service.JaegoService"%>
<%@page import="kr.ac.kopo.ctc.kopo36.dao.JaegoDaoImpl"%>
<%@page import="kr.ac.kopo.ctc.kopo36.dao.JaegoDao"%>
<%@page import="kr.ac.kopo.ctc.kopo36.domain.Jaego"%>
<%@ page import="java.io.File"%>
<%@ page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<!--utf-8 문자 인코딩으로 html콘텐츠를 생성할 것을 지정한다-->
<!DOCTYPE html> <!-- html로 작성된 문서 -->
<html> <!--html언어로 작성 시작-->
<head> <!--머릿말 시작-->
	<meta charset="UTF-8"> <!-- utf-8 문자 인코딩 -->
	<title>jaego_write</title> <!--타이틀에 새겨질 글자-->
	<style> /*CSS 스타일시트*/
		.custom-button { /*해당 클래스의 버튼 셀렉터*/
			font-size: 15px;
			font-weight: bold;
			color: white;
			background-color: #e7708d;
			padding: 10px 15px;
			border: none;
		}
	</style> <!-- 스타일시트 끝 -->
	<script> //자바스크립트 시작
		function goBack() { //해당 함수가 호출되면
			window.history.back(); //이전 페이지로 돌아간다
		}
	</script> <!--자바 스크립트 끝-->
</head> <!--머릿말 끝-->
<body> <!--머릿말 끝-->
<h1>(주)트와이스 재고 현황 -상품등록</h1> <!-- 표제 -->
<%	//scriptlet시작 
	request.setCharacterEncoding("UTF-8"); //request의 문자 인코딩 utf-8 지정
	
	//이미지를 저장할 경로	
	String path = getServletContext().getRealPath("/image");
	//해당 상대경로에 대한 절대경로를 구해 문자열형 변수 path에 대입
	//String path = "/var/lib/tomcat9/webapps/JaegoProject/image"; //리눅스 서버의 절대경로

	//저장용량 제한
	int size = 10 * 1024 * 1024; //10메가바이트
	DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy(); //중복이름방지

	//실제로 파일업로드 하는 처리문
	//MultipartRequest multi = new MultipartRequest(request, 저장위치, 용량제한, 인코딩, 중복파일명 처리 객체);
	MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", policy);

	String fileName = ""; //문자열형 변수 선언
	try {
		fileName = multi.getFilesystemName("fileInput");
		//해당 파라미터값을 가져와 fileName에 대입
	} catch (Exception e) { //오류 발생시
		e.printStackTrace(); // 콘솔에 오류메시지 출력
	}

	String itemNumber = ""; //문자열형 변수 선언
	try {
		itemNumber = multi.getParameter("itemNumber");
		//해당 파라미터값을 가져와 itemNumber 대입
	} catch (Exception e) { //오류 발생시
		e.printStackTrace(); // 콘솔에 오류메시지 출력
	}
	String itemName = ""; //문자열형 변수 선언
	try {
		itemName = multi.getParameter("itemName");
		//해당 파라미터값을 가져와 itemName 대입
	} catch (Exception e) { //오류 발생시
		e.printStackTrace(); // 콘솔에 오류메시지 출력
	}
	int inStock = -1; //정수형 변수 선언하고 -1로 초기화
	try {
		inStock = Integer.parseInt(multi.getParameter("inStock"));
		//해당 파라미터값을 가져와 정수형변환 후 inStock 대입
	} catch (Exception e) { //오류 발생시
		e.printStackTrace(); // 콘솔에 오류메시지 출력
	}
	String explanation = ""; //문자열형 변수 선언
	try {
		explanation = multi.getParameter("explanation");
		//해당 파라미터값을 가져와 explanation 대입
	} catch (Exception e) { //오류 발생시
		e.printStackTrace(); // 콘솔에 오류메시지 출력
	}

	Jaego jaego = new Jaego(); //파라미터로 받아온 변수값들을 대입하여 함수에 전달해줄 jaego객체 생성
	jaego.setItemNumber(itemNumber); //jaego객체에 itemNumber를 set한다
	jaego.setItem(itemName); //jaego객체에 itemName를 set한다
	jaego.setInStock(inStock); //jaego객체에 inStock를 set한다
	jaego.setExplanation(explanation); //jaego객체에 explanation를 set한다
	if(fileName == null) { //입력한 파일이 없으면
		jaego.setImageName("./image/null.png"); //해당 경로를 set해준다
	} else { //입력한 파일이 있으면
		jaego.setImageName("./image/"+ fileName); //해당 경로를 set해준다
	}
	String title = jaego.getItem().replaceAll("<", "&lt;").replaceAll(">", "&gt;");
	//괄호를 이스케이프하여 HTML이나 XML 태그의 일부로 해석되지 않고 문자 그대로 처리하기 위해 변형하여 문자열형 변수에 대입
	
	JaegoService jaegoService = new JaegoServiceImpl();
	//JaegoService 인터페이스를 구현한 JaegoServiceImpl 클래스의 인스턴스를 생성하여 jaegoService 변수에 할당
	int C = jaegoService.currentPageNumber(itemNumber, 20);
	//JaegoServiceImpl 클래스의 currentPageNumber메서드를 호출하여 해당 글번호가 있는 페이지넘버를 리턴받고 정수형 변수 C에 할당

	JaegoDao jaegoDao = new JaegoDaoImpl();
	//JaegoDao 인터페이스를 구현한 JaegoDaoImpl 클래스의 인스턴스를 생성하여 jaegoDao 변수에 할당
	String msg = jaegoDao.write(jaego);
	//JaegoDaoImpl클래스의 write함수를 호출하여 jaego를 db의 테이블에 입력하고 리턴값을 문자열형 변수 msg에 대입

	String Value = jaego.getExplanation();
	//파라미터로 전달받아 jaego에 set해준 explanation을 문자열형 변수 Value에 대입
	if (Value == null) { //explanation에 값이 없으면
		out.println("<h1>[" + title + "]재고가 수정되었습니다.</h1>"); //해당 문구 출력
	} else if (msg == "duplicate") { //write함수의 리턴값이 중복을 알리면
		out.println("<h1>중복된 상품번호입니다. 다시 시도해주세요.</h1>"); //해당 문구 출력
	} else { //explanation에 값이 있으면
		out.println("<h1>[" + title + "]재고가 등록되었습니다.</h1>"); //해당 문구 출력
	}

	if (msg == "duplicate") { //중복된 값이 있으면 아래의 버튼 출력
	%> <!--scriptlet 끝-->
	<table width=650> <!-- 테이블 시작 너비 650픽셀 -->
		<tr> <!-- 행 시작 -->
			<td width=600></td> <!-- 셀 너비 600픽셀 -->
			<td><input type=button class="custom-button" value="돌아가기" OnClick='goBack()'></td>
			<!-- 클릭하면 해당 함수가 호출되는 버튼 생성 -->
			<td><input type=button class="custom-button" value="목록" OnClick="location.href='Jaego_list.jsp'"></td>
			<!-- 클릭하면 해당 경로로 이동하는 버튼 생성 -->
		</tr> <!-- 행 끝 -->
	</table> <!-- 테이블 끝 -->
	<%	//scriptlet시작 
	} else { //중복된 값이 없으면 아래의 버튼 출력
	%> <!--scriptlet 끝-->
	<table width=650> <!-- 테이블 시작 너비 650픽셀 -->
		<tr> <!-- 행 시작 -->
			<td width=600></td> <!-- 셀 너비 600픽셀 -->
			<td><input type=button class="custom-button" value="돌아가기" OnClick='goBack()'></td>
			<!-- 클릭하면 해당 함수가 호출되는 버튼 생성 -->
			<td><input type=button class="custom-button" value="재고현황" OnClick="location.href='Jaego_view.jsp?key=<%=itemNumber%>'"></td>
			<!-- 클릭하면 해당 경로로 이동하는 버튼 생성 -->
			<td><input type=button class="custom-button" value="목록" OnClick="location.href='Jaego_list.jsp?pageNo=<%=C%>'"></td>
			<!-- 클릭하면 해당 경로로 이동하는 버튼 생성 -->
		</tr> <!-- 행 끝 -->
	</table> <!-- 테이블 끝 -->
	<%	//scriptlet시작 
	}
	%> <!--scriptlet 끝-->
</body> <!--본문 끝-->
</html> <!--html언어로 작성 끝-->