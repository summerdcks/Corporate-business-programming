<%@page import="kr.ac.kopo.ctc.kopo36.service.GongjiServiceImpl"%>
<%@page import="kr.ac.kopo.ctc.kopo36.service.GongjiService"%>
<%@page import="kr.ac.kopo.ctc.kopo36.dao.GongjiDao"%>
<%@page import="kr.ac.kopo.ctc.kopo36.dao.GongjiDaoImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--utf-8 문자 인코딩으로 html콘텐츠를 생성할 것을 지정한다-->
<!DOCTYPE html> <!-- html로 작성된 문서 -->
<html> <!--html언어로 작성 시작-->
<head> <!--머릿말 시작-->
	<meta charset="UTF-8"> <!-- utf-8 문자 인코딩 -->
	<title>gongji_delete</title> <!--타이틀에 새겨질 글자-->
</head> <!--머릿말 끝-->
<body> <!--본문 시작-->
<% //scriptlet시작
	request.setCharacterEncoding("UTF-8"); //request의 문자 인코딩 utf-8 지정
	int bunho = Integer.parseInt(request.getParameter("id"));
	//매개변수로 전달받은 id값을 정수형변환하여 정수형변수 bunho에 대입한다
	int rootid = -1;
	try { 
		rootid = Integer.parseInt(request.getParameter("rootid"));
	//매개변수로 전달받은 rootid값을 정수형변환하여 정수형변수 rootid에 대입한다
	} catch(Exception e){
		
	}
	int recnt = -1;
	try {
		recnt = Integer.parseInt(request.getParameter("recnt"));
	//매개변수로 전달받은 recnt값을 정수형변환하여 정수형변수 recnt에 대입한다
	} catch(Exception e) {
		
	}
	GongjiService gongjiService = new GongjiServiceImpl();
	//GongjiService 인터페이스를 구현한 GongjiServiceImpl 클래스의 인스턴스를 생성하여 gongjiService 변수에 할당
	int C = gongjiService.currentPageNumber(bunho, 20);
	//GongjiServiceImpl 클래스의 currentPageNumber메서드를 호출하여 해당 글번호가 있는 페이지넘버를 리턴받고 정수형 변수 C에 할당
	GongjiDao gongjiDao = new GongjiDaoImpl();
	//GongjiDao 인터페이스를 구현한 GongjiDaoImpl 클래스의 인스턴스를 생성하여 gongjiDao 변수에 할당
	gongjiDao.delete(bunho, rootid, recnt);
	//GongjiDaoImpl 클래스의 delete메서드를 호출하여 해당글번호가 있는 자료를 db에서 삭제한다
%> <!--scriptlet 끝-->
	<script> //자바스크립트 시작
		window.location.href="gongji_list.jsp?pageNo=<%=C%>&cntPT=20";
		//화면을 해당 페이지로 이동시킨다
	</script> <!--자바 스크립트 끝-->
</body> <!--본문 끝-->
</html> <!--html언어로 작성 끝-->
