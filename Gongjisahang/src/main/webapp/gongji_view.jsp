<%@page import="kr.ac.kopo.ctc.kopo36.service.GongjiServiceImpl"%>
<%@page import="kr.ac.kopo.ctc.kopo36.service.GongjiService"%>
<%@page import="kr.ac.kopo.ctc.kopo36.domain.Gongji"%>
<%@page import="kr.ac.kopo.ctc.kopo36.dao.GongjiDaoImpl"%>
<%@page import="kr.ac.kopo.ctc.kopo36.dao.GongjiDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--utf-8 문자 인코딩으로 html콘텐츠를 생성할 것을 지정한다-->
<!DOCTYPE html> <!-- html로 작성된 문서 -->
<html> <!--html언어로 작성 시작-->
<head> <!--머릿말 시작-->
	<meta charset="UTF-8"> <!-- utf-8 문자 인코딩 -->
	<title>gongji_view</title> <!--타이틀에 새겨질 글자-->
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
		function onChange(msg) { //버튼을 클릭하면 호출되는 함수
			if(msg == '수정'){	//수정버튼을 클릭하면
				fm.action='gongji_update.jsp?key=id'; //폼 action값이 해당 경로로 지정
				fm.submit();	//폼 제출
			} else if(msg == '삭제'){ //삭제버튼을 클릭하면
				fm.action='gongji_delete.jsp?key=id'; //폼 action값이 해당 경로로 지정
				fm.submit();	//폼 제출
			} else if(msg == '댓글'){ //댓글버튼을 클릭하면
				fm.action='gongji_reinsert.jsp?key=id'; //폼 action값이 해당 경로로 지정
				fm.submit();	//폼 제출
			}
		}
	</script> <!--자바 스크립트 끝-->
<% //scriptlet시작
	request.setCharacterEncoding("UTF-8"); //request의 문자 인코딩 utf-8 지정 
	int bunho = Integer.parseInt(request.getParameter("key"));
	//key값을 파라미터로 받고 정수형변환하여 정수형 변수인 bunho에 대입
	
	GongjiService gongjiService = new GongjiServiceImpl();
	//GongjiService 인터페이스를 구현한 GongjiServiceImpl 클래스의 인스턴스를 생성하여 gongjiService 변수에 할당
	int count = gongjiService.countViewcnt(bunho);
	//GongjiServiceImpl클래스의 countViewcnt메서드를 호출하여 bunho를 파라미터로 입력하고 리턴값을 정수형 변수 count에 받음
		
	GongjiDao gongjiDao = new GongjiDaoImpl();
	//GongjiDao 인터페이스를 구현한 GongjiDaoImpl 클래스의 인스턴스를 생성하여 gongjiDao 변수에 할당
	Gongji gongji = new Gongji();
	//gongji객체 생성
	gongji = gongjiDao.OneView(bunho);
	//해당 글번호를 파라미터로 받는 OneView메소드를 호출하여 리턴값을 gongji객체에 대입
	int C = gongjiService.currentPageNumber(gongji.getRootid(), 20);
	//GongjiServiceImpl클래스의 currentPageNumber메서드를 호출하여 원글번호를 파라미터로 입력하고 리턴값을 정수형 변수 C에 받음
	
	String title = gongji.getJemok().replaceAll("<", "&lt;").replaceAll(">", "&gt;");
	//괄호를 이스케이프하여 HTML이나 XML 태그의 일부로 해석되지 않고 문자 그대로 처리하기 위해 변형하여 문자열형 변수에 대입
  	String content = gongji.getNaeyong().replaceAll("<", "&lt;").replaceAll(">", "&gt;");
  	//괄호를 이스케이프하여 HTML이나 XML 태그의 일부로 해석되지 않고 문자 그대로 처리하기 위해 변형하여 문자열형 변수에 대입
%> <!--scriptlet 끝-->
</head> <!--머릿말 끝-->
<body> <!--머릿말 끝-->
<h1>공지사항</h1>
	<form method=post name='fm'>
	<!--데이터가 HTTP post 메소드를 사용하여 제출되도록 지정, 양식 필드에 입력된 데이터가 쿼리 매개변수로 URL에 추가된다
    식별자 "fm"을 양식 요소에 할당하며 JavaScript 또는 CSS에서 양식을 참조하는 데 사용할 수 있게 한다-->   
	<table class="type10" width=650 border=1 cellspacing=0 cellpadding=5>
		 <!-- 테이블 시작, 클래스 type10지정, 너비 650픽셀, 테두리 1픽셀, 셀간격 없음, 셀여백 5픽셀 -->
		<tr> <!-- 행 시작 -->
			<th width=100><b>번호</b></th> <!-- 헤더셀, 굵은글씨 너비 100픽셀-->
			<td colspan=3 width=500><%=gongji.getBunho()%><input type=hidden name=id value='<%=gongji.getBunho() %>'></td>
			<!-- 셀 너비 500픽셀, 해당 번호를 출력해주고 hidden타입으로 id로 지정 -->
		</tr> <!-- 행 끝 -->
		<tr> <!-- 행 시작 -->
			<th ><b>제목</b></th> <!-- 헤더셀, 굵은글씨 -->
			<td colspan=3><input type=text name=title size=70 maxlength=70 value='<%=title %>' readonly></td> <!-- 셀 안에 해당값 출력 -->
		</tr> <!-- 행 끝 -->
		<tr> <!-- 행 시작 -->
			<th><b>일자</b></th> <!-- 헤더셀, 굵은글씨 -->
			<td colspan=3><%=gongji.getIlja()%></td> <!-- 셀 안에 해당값 출력 -->
		</tr> <!-- 행 끝 -->
		<tr> <!-- 행 시작 -->
			<th><b>조회수</b></th> <!-- 헤더셀, 굵은글씨 -->
			<td colspan=3><%=gongji.getViewcnt() %></td>
			 <!-- 셀 안에 해당값의 개행을 형변환하여 출력 -->
		</tr> <!-- 행 끝 -->
		<tr> <!-- 행 시작 -->
			<th><b>내용</b></th> <!-- 헤더셀, 굵은글씨 -->
			<td colspan=3><textarea style='width:500px; height:250px; resize: none; overflow: auto;' name=content cols=70 row=600 maxlength=10000 readonly><%=content %>
			</textarea></td>
			 <!-- 셀 안에 텍스트 입력창 생성, 크기 고정, 최대 10000자, 읽기 전용, 해당 변수값을 출력해줌 -->
		</tr> <!-- 행 끝 -->
		<tr> <!-- 행 시작 -->
			<th><b>원글</b></th> <!-- 헤더셀, 굵은글씨 -->
			<td colspan=3><%=gongji.getRootid() %><input type=hidden name=rootid value='<%=gongji.getRootid() %>'></td>
			 <!-- 셀 3개 합치기, 셀 안에 해당값을 출력, 해당값을 폼에 파라미터로 전달-->
		</tr> <!-- 행 끝 -->
		<tr> <!-- 행 시작 -->
			<th><b>댓글수준</b></th> <!-- 헤더셀, 굵은글씨 -->
			<td width = 180><%=gongji.getRelevel() %><input type=hidden name=relevel value='<%=gongji.getRelevel() %>'></td>
			<!-- 셀 너비 180픽셀, 셀 안에 해당값 출력, 해당값을 폼에 파라미터로 전달 -->
			<th width = 100><b>댓글내 순서</b></th> <!-- 헤더셀 너비 100픽셀, 셀 안에 해당값 출력 -->
			<td><%=gongji.getRecnt() %><input type=hidden name=recnt value='<%=gongji.getRecnt() %>'></td>
			 <!-- 셀 안에 해당값을 출력, 해당값을 폼에 파라미터로 전달-->
		</tr> <!-- 행 끝 -->
	</table> <!--테이블 끝-->
	<table width=650> <!-- 테이블 생성, 너비 650픽셀 -->
		<tr> <!-- 행 시작 -->
			<td width=600></td> <!-- 셀 너비 600픽셀 -->
			<td><input type=button class="custom-button" value="목록" OnClick="location.href='gongji_list.jsp?pageNo=<%=C%>'"></td>
			<!-- 클릭하면 해당 페이지로 이동하는 버튼 생성 -->
			<td><input type=button class="custom-button" value="수정" OnClick="onChange('수정')"></td>
			<!-- 클릭하면 해당 함수가 호출되는 버튼 생성 -->
			<td><input type=button class="custom-button" value="삭제" OnClick="onChange('삭제')"></td>
			<!-- 클릭하면 해당 함수가 호출되는 수정버튼 생성 -->
			<td><input type=button class="custom-button" value="댓글" OnClick="onChange('댓글')"></td>
			<!-- 클릭하면 해당 함수가 호출되는 수정버튼 생성 -->
		</tr> <!-- 행 끝 -->
	</table> <!--테이블 끝-->
	</form> <!--form 끝-->
</body> <!--본문 끝-->
</html> <!--html언어로 작성 끝-->