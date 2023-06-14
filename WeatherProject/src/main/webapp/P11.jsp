<%@page import="org.w3c.dom.Element"%>
<%@page import="org.w3c.dom.Document"%>
<%@page import="org.w3c.dom.NodeList"%>
<%@page import="java.io.File"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="javax.xml.parsers.DocumentBuilder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- jsp페이지가 java언어로 작성됨, 페이지 컨텐츠 유형은 html, 페이지 인코딩 utf-8 -->
<!DOCTYPE html> <!--html로 작성한 문서-->
<html> <!--html 언어로 작성 시작-->
<head> <!--머릿말 시작-->
	<meta charset="UTF-8"> <!--문자 인코딩 utf-8 지정-->
	<title>Insert title here</title> <!-- 타이틀에 새겨질 문자 -->
</head> <!--머릿말 끝-->
<body> <!--본문 시작-->
<% //scriptlet으로 작성 시작
	DocumentBuilder docBuilder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
	//XML 문서를 파싱하는 데 사용할 DocumentBuilder 객체를 생성
	//DocumentBuilderFactory.newInstance()는 DocumentBuilderFactory의 인스턴스를 반환
	//newDocumentBuilder()는 DocumentBuilder의 인스턴스를 반환합니다.
	Document doc = docBuilder.parse("http://192.168.23.103:8081/WeatherProject/xmlmake.jsp");
	//지정된 URL에서 XML 문서를 가져와서 파싱
	//docBuilder를 사용하여 parse() 메서드를 호출하여 해당 url로부터 XML 문서를 파싱한 후 Document 객체로 반환
	
	Element root = doc.getDocumentElement();
	//파싱된 XML 문서의 루트 요소를 가져옵니다. getDocumentElement() 메서드는 Document 객체의 루트 요소를 반환합니다.
	NodeList tag_name = doc.getElementsByTagName("name");
	//doc에서 name 태그를 가진 모든 요소를 선택하여 NodeList tag_name에 대입
	NodeList tag_studentid = doc.getElementsByTagName("studentid");
	//doc에서 studentid 태그를 가진 모든 요소를 선택하여 NodeList tag_studentid에 대입
	NodeList tag_kor = doc.getElementsByTagName("kor");
	//doc에서 kor 태그를 가진 모든 요소를 선택하여 NodeList tag_kor에 대입
	NodeList tag_eng = doc.getElementsByTagName("eng");
	//doc에서 eng 태그를 가진 모든 요소를 선택하여 NodeList tag_eng에 대입
	NodeList tag_mat = doc.getElementsByTagName("mat");
	//doc에서 mat 태그를 가진 모든 요소를 선택하여 NodeList tag_mat에 대입
	
	out.println("<table cellspacing=1 width=500 border=1>"); //셀간격 1픽셀 너비 500픽셀 테두리 1픽셀의 테두리 생성
	out.println("<tr>"); //행 시작
	out.println("<td width=100>이름</td>"); //너비 100픽셀의 셀
	out.println("<td width=100>학번</td>"); //너비 100픽셀의 셀
	out.println("<td width=100>국어</td>"); //너비 100픽셀의 셀
	out.println("<td width=100>영어</td>"); //너비 100픽셀의 셀
	out.println("<td width=100>수학</td>"); //너비 100픽셀의 셀
	out.println("</tr>"); //행 끝
	
	for(int i = 0; i < tag_name.getLength(); i++) { //tag_name의 크기만큼 반복문 실행
		out.println("<tr>"); //행 시작
		out.println("<td width=100>"+tag_name.item(i).getFirstChild().getNodeValue()+"</td>");
		//너비 100픽셀의 셀 안에 XML 문서에서 name 태그를 가진 요소의 값을 출력
		//tag_name NodeList에서 i번째 요소의 첫 번째 자식 노드를 반환, 선택된 노드의 값을 가져옴
		out.println("<td width=100>"+tag_studentid.item(i).getFirstChild().getNodeValue()+"</td>");
		//너비 100픽셀의 셀 안에 XML 문서에서 studentid 태그를 가진 요소의 값을 출력
		//tag_tag_studentid NodeList에서 i번째 요소의 첫 번째 자식 노드를 반환, 선택된 노드의 값을 가져옴
		out.println("<td width=100>"+tag_kor.item(i).getFirstChild().getNodeValue()+"</td>");
		//너비 100픽셀의 셀 안에 XML 문서에서 kor 태그를 가진 요소의 값을 출력
		//tag_kor NodeList에서 i번째 요소의 첫 번째 자식 노드를 반환, 선택된 노드의 값을 가져옴
		out.println("<td width=100>"+tag_eng.item(i).getFirstChild().getNodeValue()+"</td>");
		//너비 100픽셀의 셀 안에 XML 문서에서 eng 태그를 가진 요소의 값을 출력
		//tag_eng NodeList에서 i번째 요소의 첫 번째 자식 노드를 반환, 선택된 노드의 값을 가져옴
		out.println("<td width=100>"+tag_mat.item(i).getFirstChild().getNodeValue()+"</td>");
		//너비 100픽셀의 셀 안에 XML 문서에서 mat 태그를 가진 요소의 값을 출력
		//tag_mat NodeList에서 i번째 요소의 첫 번째 자식 노드를 반환, 선택된 노드의 값을 가져옴
		out.println("</tr>"); //행 끝
	}
%> <!-- scriplet으로 작성 끝 -->
</body> <!--본문 끝-->
</html> <!--html언어로 작성 끝-->