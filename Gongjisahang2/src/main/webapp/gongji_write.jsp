<%@page import="kr.ac.kopo.ctc.kopo36.dao.GongjiDaoImpl"%>
<%@page import="kr.ac.kopo.ctc.kopo36.dao.GongjiDao"%>
<%@page import="kr.ac.kopo.ctc.kopo36.service.GongjiServiceImpl"%>
<%@page import="kr.ac.kopo.ctc.kopo36.service.GongjiService"%>
<%@page import="kr.ac.kopo.ctc.kopo36.domain.Gongji"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--utf-8 문자 인코딩으로 html콘텐츠를 생성할 것을 지정한다-->
<!DOCTYPE html> <!-- html로 작성된 문서 -->
<html> <!--html언어로 작성 시작-->
<head> <!--머릿말 시작-->
	<meta charset="UTF-8"> <!-- utf-8 문자 인코딩 -->
	<title>gongji_write</title> <!--타이틀에 새겨질 글자-->
</head> <!--머릿말 끝-->
<body> <!--머릿말 끝-->
<%	//scriptlet시작 
	request.setCharacterEncoding("UTF-8"); //request의 문자 인코딩 utf-8 지정	
	Gongji gongji = new Gongji(); //gongji 객체 생성
	
	//글 insert인지 update인지 bunho로 구분: bunho가 -1이면 새글입력, bunho에 값이 있으면 수정
	int bunho = -1;	//정수형 변수 bunho를 -1로 초기화
	try{
		bunho = Integer.parseInt(request.getParameter("id"));
		//id값을 파라미터로 받아 정수형변환하여 bunho에 대입
	}catch(Exception e) { //오류 발생시
		e.printStackTrace();
	}
	gongji.setBunho(bunho); //변수값을 gongji객체의 해당 변수에 set해준다
		
	String jemok = request.getParameter("title");
	//title값을 파라미터로 받아 문자열 jemok에 대입
	String naeyong = request.getParameter("content");
	//content값을 파라미터로 받아 문자열 naeyong에 대입
	
	String title = jemok.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
  	String content = naeyong.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
	gongji.setJemok(title); //jemok를 gongji객체의 jemok에 대입
	gongji.setNaeyong(content);	//naeyong를 gongji객체의 naeyong에 대입
	
	GongjiService gongjiService = new GongjiServiceImpl();
	//GongjiService 인터페이스를 구현한 GongjiServiceImpl 클래스의 인스턴스를 생성하여 gongjiService 변수에 할당
	int C = gongjiService.currentPageNumber(bunho, 20);
	//GongjiServiceImpl 클래스의 currentPageNumber메서드를 호출하여 해당 글번호가 있는 페이지넘버를 리턴받고 정수형 변수 C에 할당
	GongjiDao gongjiDao = new GongjiDaoImpl();
	//GongjiDao 인터페이스를 구현한 GongjiDaoImpl 클래스의 인스턴스를 생성하여 gongjiDao 변수에 할당
	gongji = gongjiDao.Write(gongji);
	//GongjiDaoImpl클래스의 Write함수를 호출하여 gongji를 db에 입력
	if (gongji == null) {
		out.println("비정상적인 신호가 감지되어 글작성에 실패했습니다. 다시 입력해주세요.");
%>	
	<table><tr>
		<td><input type=button class="custom-button" value="목록" OnClick="location.href='gongji_list.jsp?pageNo=<%=C%>'"></td>
		<!-- 클릭하면 해당 페이지로 이동하는 버튼 생성 -->
	</tr></table>
<%
	}else {
%> <!--scriptlet 끝-->
	<script> //자바스크립트 시작
		window.location.href="gongji_view.jsp?key=<%=gongji.getBunho()%>";
		//해당 key값을 가진 페이지로 이동
	</script> <!--자바 스크립트 끝-->
<%	} %>
</body> <!--본문 끝-->
</html> <!--html언어로 작성 끝-->