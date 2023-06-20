<%@page import="org.w3c.dom.NodeList"%>
<%@page import="org.w3c.dom.Element"%>
<%@page import="org.w3c.dom.Document"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="javax.xml.parsers.DocumentBuilder"%>
<%@ page import="java.text.DecimalFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- jsp페이지가 java언어로 작성됨, 페이지 컨텐츠 유형은 html, 페이지 인코딩 utf-8 -->
<!DOCTYPE html> <!--html로 작성한 문서-->
<html> <!--html 언어로 작성 시작-->
<head> <!--머릿말 시작-->
	<meta charset="UTF-8"> <!--문자 인코딩 utf-8 지정-->
	<title>Insert title here</title> <!-- 타이틀에 새겨질 문자 -->
	<style> /*CSS*/
		table { /*테이블 속성 지정*/ 
		  border-collapse: separate;
		  border-spacing: 1px;
		  text-align: left;
		  line-height: 1.5;
		  border-top: 1px solid #ccc;
		  margin : 20px 10px;
		}
		td { /*셀 속성 지정*/
		  padding: 3px;
		  vertical-align: top;
		  border-bottom: 1px solid #ccc;
		}
	
	</style> <!-- CSS끝 -->
</head> <!--머릿말 끝-->
<body> <!--본문 시작-->
<% //scriptlet으로 작성 시작
	String seq="";	//48시간 중 몇번째인지 가르킴
	String hour=""; //동네예보 3시간 단위
	String day="";	//1번째날 (0:오늘 / 1:내일 / 2:모레)
	String temp=""; //현재 시간 온도
	String tmx="";	//최고 온도
	String tmn="";	//최저 온도
	String sky="";	//하늘 상태코드 (1:맑음, 2:구름조금, 3:구름많음, 4:흐림);
	String pty="";	//강수 상태코드 (0:없음, 1:비, 2:비/눈, 3:눈/비, 4:눈);
	String wfKor="";//날씨 한국어
	String wfEn="";	//날씨 영어
	String pop="";	//강수 확률%
	String r12="";	//12시간 예상 강수량
	String s12="";	//12시간 예상 적설량
	String ws="";	//풍속(m/s)
	String wd="";	//풍향(0~7:북, 북동, 동, 남동, 남, 남서, 서, 북서)
	String wdKor="";//풍향 한국어
	String wdEn="";	//풍향 영어
	String reh="";	//습도%
	String r06="";	//6시간 예상 강수량
	String s06="";	//6시간 예상 적설량
	
	DocumentBuilder docBuilder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
	//XML 문서를 파싱하는 데 사용되는 DocumentBuilder 객체를 생성
	//DocumentBuilderFactory.newInstance()는 DocumentBuilderFactory의 인스턴스를 반환하고, 
	//newDocumentBuilder()는 DocumentBuilder의 인스턴스를 반환
	Document doc = docBuilder.parse("http://www.kma.go.kr/wid/queryDFS.jsp?gridx=61&gridy=123");
	//지정된 URL에서 XML 문서를 가져와 파싱
	//docBuilder.parse() 메서드를 사용하여 XML 문서를 파싱한 후 Document 객체로 반환
	
	Element root = doc.getDocumentElement();
	//getDocumentElement() 메서드를 호출하여 Document 객체의 루트 요소를 반환
	NodeList tag_001 = doc.getElementsByTagName("data");
	//doc에서 data 태그를 가진 모든 요소를 선택하여 NodeList tag_001에 대입
	
	DecimalFormat decimalFormat = new DecimalFormat("0.00");
	//실수값을 소수점 이하 두자리까지 표현하기 위하여 formatter를 생성한다
%> <!-- scriplet으로 작성 끝 -->
<table> <!-- 테이블 시작 -->
	<tr> <!-- 행 시작 -->
		<td>seq</td> <!-- 셀 안에 문자열 출력 -->
		<td>시간</td> <!-- 셀 안에 문자열 출력 -->
		<td>현재 온도</td> <!-- 셀 안에 문자열 출력 -->
		<td>최고 온도</td> <!-- 셀 안에 문자열 출력 -->
		<td>최저 온도</td> <!-- 셀 안에 문자열 출력 -->
		<td>하늘 상태</td> <!-- 셀 안에 문자열 출력 -->
		<td>강수 상태</td> <!-- 셀 안에 문자열 출력 -->
		<td>날씨(K)</td> <!-- 셀 안에 문자열 출력 -->
		<td>날씨(E)</td> <!-- 셀 안에 문자열 출력 -->
		<td>강수 확률</td> <!-- 셀 안에 문자열 출력 -->
		<td>12시간 예상강수량</td> <!-- 셀 안에 문자열 출력 -->
		<td>12시간 예상적설량</td> <!-- 셀 안에 문자열 출력 -->
		<td>풍속(m/s)</td> <!-- 셀 안에 문자열 출력 -->
		<td>풍향</td> <!-- 셀 안에 문자열 출력 -->
		<td>풍향(K)</td> <!-- 셀 안에 문자열 출력 -->
		<td>풍향(E)</td> <!-- 셀 안에 문자열 출력 -->
		<td>습도</td> <!-- 셀 안에 문자열 출력 -->
		<td>6시간 예상강수량</td> <!-- 셀 안에 문자열 출력 -->
		<td>6시간 예상적설량</td> <!-- 셀 안에 문자열 출력 -->
	</tr> <!-- 행 끝 -->
<% //scriptlet으로 작성 시작
	for(int i =0; i < tag_001.getLength(); i++) { //tag_001 NodeList의 크기만큼 반복문 실행
		Element elmt = (Element)tag_001.item(i);
		// 현재 반복 중인 요소를 Element 객체로 캐스팅하여 변수 elmt에 대입
		seq = tag_001.item(i).getAttributes().getNamedItem("seq").getNodeValue();	
		// 현재 요소의 seq 속성 노드의 값을 가져와 변수 seq에 대입
		hour = elmt.getElementsByTagName("hour").item(0).getFirstChild().getNodeValue();
		//현재 요소에서 hour 태그를 가진 첫 번째 하위 요소의 값을 가져와 변수 hour에 저장
		//hour 태그를 가진 모든 요소들의 NodeList를 반환하여 그 중 첫번째 하위 요소를 선택, 첫번째 자식 노드(텍스트 노드)를 반환
		day = elmt.getElementsByTagName("day").item(0).getFirstChild().getNodeValue();
		//현재 요소에서 day 태그를 가진 첫 번째 하위 요소의 값을 가져와 변수 day 저장
		temp = elmt.getElementsByTagName("temp").item(0).getFirstChild().getNodeValue();
		//현재 요소에서 temp 태그를 가진 첫 번째 하위 요소의 값을 가져와 변수 temp 저장
		tmx = elmt.getElementsByTagName("tmx").item(0).getFirstChild().getNodeValue();
		//현재 요소에서 tmx 태그를 가진 첫 번째 하위 요소의 값을 가져와 변수 tmx 저장
		tmn = elmt.getElementsByTagName("tmn").item(0).getFirstChild().getNodeValue();
		//현재 요소에서 tmn 태그를 가진 첫 번째 하위 요소의 값을 가져와 변수 tmn 저장
		sky = elmt.getElementsByTagName("sky").item(0).getFirstChild().getNodeValue();
		//현재 요소에서 sky 태그를 가진 첫 번째 하위 요소의 값을 가져와 변수 sky 저장
		pty = elmt.getElementsByTagName("pty").item(0).getFirstChild().getNodeValue();
		//현재 요소에서 pty 태그를 가진 첫 번째 하위 요소의 값을 가져와 변수 pty 저장
		wfKor = elmt.getElementsByTagName("wfKor").item(0).getFirstChild().getNodeValue();
		//현재 요소에서 wfKor 태그를 가진 첫 번째 하위 요소의 값을 가져와 변수 wfKor 저장
		wfEn = elmt.getElementsByTagName("wfEn").item(0).getFirstChild().getNodeValue();
		//현재 요소에서 wfEn 태그를 가진 첫 번째 하위 요소의 값을 가져와 변수 wfEn 저장
		pop = elmt.getElementsByTagName("pop").item(0).getFirstChild().getNodeValue();
		//현재 요소에서 pop 태그를 가진 첫 번째 하위 요소의 값을 가져와 변수 pop 저장
		r12 = elmt.getElementsByTagName("r12").item(0).getFirstChild().getNodeValue();
		//현재 요소에서 r12 태그를 가진 첫 번째 하위 요소의 값을 가져와 변수 r12 저장
		s12 = elmt.getElementsByTagName("s12").item(0).getFirstChild().getNodeValue();
		//현재 요소에서 s12 태그를 가진 첫 번째 하위 요소의 값을 가져와 변수 s12 저장
		ws = elmt.getElementsByTagName("ws").item(0).getFirstChild().getNodeValue();
		//현재 요소에서 ws 태그를 가진 첫 번째 하위 요소의 값을 가져와 변수 ws 저장
		String wsformatted = decimalFormat.format(Double.parseDouble(ws));
		//풍향을 소수점 이하 두자리까지 표현하기 위하여 먼저 실수형변환한 후 formatter를 적용하고 문자열 변수로 받는다
		wd = elmt.getElementsByTagName("wd").item(0).getFirstChild().getNodeValue();
		//현재 요소에서 wd 태그를 가진 첫 번째 하위 요소의 값을 가져와 변수 wd 저장
		wdKor = elmt.getElementsByTagName("wdKor").item(0).getFirstChild().getNodeValue();
		//현재 요소에서 wdKor 태그를 가진 첫 번째 하위 요소의 값을 가져와 변수 wdKor 저장
		wdEn = elmt.getElementsByTagName("wdEn").item(0).getFirstChild().getNodeValue();
		//현재 요소에서 wdEn 태그를 가진 첫 번째 하위 요소의 값을 가져와 변수 wdEn 저장
		reh = elmt.getElementsByTagName("reh").item(0).getFirstChild().getNodeValue();
		//현재 요소에서 reh 태그를 가진 첫 번째 하위 요소의 값을 가져와 변수 reh 저장
		r06 = elmt.getElementsByTagName("r06").item(0).getFirstChild().getNodeValue();
		//현재 요소에서 r06 태그를 가진 첫 번째 하위 요소의 값을 가져와 변수 r06 저장
		s06 = elmt.getElementsByTagName("s06").item(0).getFirstChild().getNodeValue();
		//현재 요소에서 s06 태그를 가진 첫 번째 하위 요소의 값을 가져와 변수 s06 저장
		
		//코드값이 해당 숫자와 일치할 때 변수에 관련된 정보를 문자열로 대입
		if(Integer.parseInt(day) == 0) {
			day = "오늘";
		} else if(Integer.parseInt(day) == 1) {
			day = "내일";
		} else if(Integer.parseInt(day) == 2) {
			day = "모레";
		} 
		
		//코드값이 해당 숫자와 일치할 때 변수에 관련된 정보를 이미지로 대입
		if(Integer.parseInt(sky) == 1) {
			sky = "맑음.png";
		} else if(Integer.parseInt(sky) == 2) {
			sky = "구름조금.png";
		} else if(Integer.parseInt(sky) == 3) {
			sky = "구름많음.png";
		} else if(Integer.parseInt(sky) == 4) {
			sky = "흐림.png";
		} 
		
		//코드값이 해당 숫자와 일치할 때 변수에 관련된 정보를 이미지로 대입
		if(Integer.parseInt(pty) == 0) {
			pty = "없음.png";
		} else if(Integer.parseInt(pty) == 1) {
			pty = "비.png";
		} else if(Integer.parseInt(pty) == 2) {
			pty = "비눈.png";
		} else if(Integer.parseInt(pty) == 3) {
			pty = "눈비.png";
		} else if(Integer.parseInt(pty) == 4) {
			pty = "눈.png";
		} 
		
		//코드값이 해당 숫자와 일치할 때 변수에 관련된 정보를 이미지로 대입
		if(Integer.parseInt(wd) == 0) {
			wd = "N.gif";
		} else if(Integer.parseInt(wd) == 1) {
			wd = "NE.gif";
		} else if(Integer.parseInt(wd) == 2) {
			wd = "E.gif";
		} else if(Integer.parseInt(wd) == 3) {
			wd = "SE.gif";
		} else if(Integer.parseInt(wd) == 4) {
			wd = "S.gif";
		} else if(Integer.parseInt(wd) == 5) {
			wd = "SW.gif";
		} else if(Integer.parseInt(wd) == 6) {
			wd = "W.gif";
		} else if(Integer.parseInt(wd) == 7) {
			wd = "NW.gif";
		}
		
		String time = day + " " + hour + "시";
		//시간에 대한 정보를 원하는 문자열 형식으로 조합하여 문자열 time에 담아줌		
		
		out.println("<tr "); //행 시작
		if(day.equals("오늘")) {
			out.println("bgcolor='#F5F5DC'>");
		} else if(day.equals("내일")) {
			out.println("bgcolor='#F0FFFF'>");
		} else if(day.equals("모레")) {
			out.println("bgcolor='#FAEBD7'>");
		}
		//날짜 별로 행의 배경색을 바꿔주기 위해 if-else if절을 사용한다
		out.println("<td>"+seq+"</td>"); //셀 안에 해당 변수값을 출력
		out.println("<td>"+time+"</td>"); //셀 안에 해당 변수값을 출력
		out.println("<td>"+temp+"</td>"); //셀 안에 해당 변수값을 출력
		out.println("<td>"+tmx+"</td>"); //셀 안에 해당 변수값을 출력
		out.println("<td>"+tmn+"</td>"); //셀 안에 해당 변수값을 출력
		out.println("<td><img src="+sky+"></td>"); //셀 안에 해당 이미지를 출력
		out.println("<td><img src="+pty+"></td>"); //셀 안에 해당 이미지를 출력
		out.println("<td>"+wfKor+"</td>"); //셀 안에 해당 변수값을 출력
		out.println("<td>"+wfEn+"</td>"); //셀 안에 해당 변수값을 출력
		out.println("<td>"+pop+"</td>"); //셀 안에 해당 변수값을 출력
		out.println("<td>"+r12+"</td>"); //셀 안에 해당 변수값을 출력
		out.println("<td>"+s12+"</td>"); //셀 안에 해당 변수값을 출력
		out.println("<td>"+wsformatted+"</td>"); //셀 안에 해당 변수값을 출력
		out.println("<td><img src="+wd+"></td>"); //셀 안에 해당 이미지를 출력
		out.println("<td>"+wdKor+"</td>"); //셀 안에 해당 변수값을 출력
		out.println("<td>"+wdEn+"</td>"); //셀 안에 해당 변수값을 출력
		out.println("<td>"+reh+"</td>"); //셀 안에 해당 변수값을 출력
		out.println("<td>"+r06+"</td>"); //셀 안에 해당 변수값을 출력
		out.println("<td>"+s06+"</td>"); //셀 안에 해당 변수값을 출력
		out.println("</tr>"); //행 끝	
	}
%> <!-- scriplet으로 작성 끝 -->
</table> <!-- 테이블 끝 -->
</body> <!--본문 끝-->
</html> <!--html언어로 작성 끝-->