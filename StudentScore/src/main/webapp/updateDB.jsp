<%@page import="java.util.ArrayList"%>
<%@page import="kr.ac.kopo.ctc.kopo36.domain.StudentScore"%>
<%@page import="java.util.List"%>
<%@page import="kr.ac.kopo.ctc.kopo36.dao.StudentScoreDaoImpl"%>
<%@page import="kr.ac.kopo.ctc.kopo36.dao.StudentScoreDao"%>
<%@page import="kr.ac.kopo.ctc.kopo36.dto.pagination"%>
<%@page import="kr.ac.kopo.ctc.kopo36.service.StudentScoreServiceImpl"%>
<%@page import="kr.ac.kopo.ctc.kopo36.service.StudentScoreService"%>
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
        table, th, tr, td {  /*해당 태그들에 아래의 내용을 적용하기 위한 태그 셀렉터*/
            border: 1px double black;   /*테두리는 1픽셀 두줄 검은색*/
            text-align: center; /*글자 가운데 정렬*/
        } 
        a { /*a태그에서 밑줄 없애기*/
            text-decoration-line: none;
        }
    </style> <!--스타일시트 끝-->
</head> <!--머릿말 끝-->
<body> <!--본문 시작-->
<h1>레코드 수정</h1> <!--표제-->
<% //scriptlet 시작
    String name =""; //문자형 name변수에 빈값 대입
    Integer sid =0; //정수형 sid변수에 0값 대입
    Integer kor =0; //정수형 kor변수에 0값 대입
    Integer eng =0; //정수형 eng변수에 0값 대입
    Integer mat =0; //정수형 mat변수에 0값 대입   
    try{ //오류를 잡기 위해 try-catch 사용
        name = request.getParameter("name"); //name파라미터를 받아와 변수 name에 대입
        sid = Integer.parseInt(request.getParameter("sid")); //sid파라미터를 받아와 정수형변환 후 변수 sid에 대입
        kor = Integer.parseInt(request.getParameter("kor")); //kor파라미터를 받아와 정수형변환 후 변수 kor에 대입
        eng = Integer.parseInt(request.getParameter("eng")); //eng파라미터를 받아와 정수형변환 후 변수 eng에 대입
        mat = Integer.parseInt(request.getParameter("mat")); //mat파라미터를 받아와 정수형변환 후 변수 mat에 대입    
    }catch(Exception e) { //오류가 있으면
        out.println(e); //해당 오류내용을 출력해준다
    }   
    StudentScoreDao studentScoreDao = new StudentScoreDaoImpl();
  	//StudentScoreDao 인터페이스를 구현한 StudentScoreDaoImpl 클래스의 인스턴스를 생성하여 studentScoreDao 변수에 할당
	StudentScore studentScore = new StudentScore();
	//StudentScore클래스의 인스턴스를 생성하여 studentScore변수에 할당
	studentScore.setName(name); //studentScore에 이름입력
	studentScore.setStudentId(sid); //studentScore에 학번입력
	studentScore.setKor(kor); //studentScore에 국어점수입력
	studentScore.setEng(eng); //studentScore에 영어점수입력
	studentScore.setMat(mat); //studentScore에 수학점수입력
	studentScoreDao.update(sid, studentScore);
	//studentScoreDaoImpl클래스에서 해당학번과 studentScore객체를 파라미터로 받는 update 메서드를 호출하여 해당 정보를 테이블에 수정입력해줌
    
	String cntValue = request.getParameter("cntPT");  //cntPT파라미터를 받아와 문자열 변수cntValue에 담음
	int cntPT = 10; //페이지당 출력해줄 자료수를 정수형 변수 선언하고 10으로 초기화
    if (cntValue == null) { //cntValue파라미터에 값이 없으면
    	cntPT = 10; //10대입
    } else {
    	cntPT = Integer.parseInt(request.getParameter("cntPT"));
    	 //cntPT를 매개변수로 받아와 정수형변환하여 cntPT에 대입한다
        if (cntPT < 1) cntPT = 1;
      //cntPT가 1보다 작으면 1 대입
    }    
    StudentScoreService studentScoreService = new StudentScoreServiceImpl();
  	//StudentScoreService 인터페이스를 구현한 StudentScoreServiceImpl 클래스의 인스턴스를 생성하여 studentScoreService 변수에 할당
    
    String pageValue = request.getParameter("pageNo"); //pageNo파라미터를 받아와 문자열 변수pageValue에 담음
	int pageNo = studentScoreService.currentPageNumber(sid, cntPT);
	 //특정학번과 페이지당 자료수를 입력하면 해당학번이 있는 페이지를 리턴하는 함수를 호출하여 리턴값을 pageNo에 대입
    if (pageValue == null) { //pageNo파라미터에 값이 없으면
    	
    } else {
    	pageNo = Integer.parseInt(request.getParameter("pageNo"));
        //현재페이지 번호를 매개변수로 받아와 정수형변환하여 대입한다
        if (pageNo < 1) pageNo = 1;
        //pageNo가 1보다 작으면 1 대입
    }
    
	List<StudentScore> studentScores = new ArrayList<>();
	//StudentScore객체의 리스트를 생성하여 studentScores변수에 할당
	studentScores = studentScoreDao.selectAll(pageNo, cntPT);
	//StudentScoreDaoImpl 클래스의 페이지넘버와 페이지당 자료수를 매개변수로 하는 selectAll 메서드를 호출하여
	//리턴값인 해당페이지의 자료 객체를 객체배열변수 studentScores에 할당
	
	pagination pagination = studentScoreService.getPagination(pageNo, cntPT);
	//StudentScoreServiceImpl 클래스의 페이지넘버와 페이지당 자료수를 매개변수로 하는 getPagination 메서드를 호출하여
	//pagination클래스의 인스턴스인 pagination변수에 할당해줌
	int C = pagination.getC(); //현재페이지넘버, pagination변수의 C값을 가져와 정수형변수로 선언한 C에 할당
	int S = pagination.getS(); //현재페이지에서 출력해줄 첫번째 페이지버튼의 페이지넘버
	int E = pagination.getE(); //현재페이지에서 출력해줄 마지막 페이지버튼의 페이지넘버
	int P = pagination.getP(); //이전페이지로 가는 버튼의 페이지넘버
	int PP = pagination.getPp(); //첫페이지로 가는 버튼의 페이지넘버
	int N = pagination.getN(); //다음페이지로 가는 버튼의 페이지넘버
	int NN = pagination.getNn(); //마지막페이지로 가는 버튼의 페이지넘버
    %> <!--scriptlet 끝-->
<table cellspacing=1 width=600 border=1> <!--셀 사이 간격 1픽셀, 셀 너비 600px, 테두리 1px-->
    <tr> <!--행 시작-->
        <td width=50><p align=center>이름</p></td> <!--셀너비 50픽셀, 글자 가운데 정렬-->
        <td width=50><p align=center>학번</p></td> <!--셀너비 50픽셀, 글자 가운데 정렬-->
        <td width=50><p align=center>국어</p></td> <!--셀너비 50픽셀, 글자 가운데 정렬-->
        <td width=50><p align=center>영어</p></td> <!--셀너비 50픽셀, 글자 가운데 정렬-->
        <td width=50><p align=center>수학</p></td> <!--셀너비 50픽셀, 글자 가운데 정렬-->
        <td width=50><p align=center>합계</p></td> <!--셀너비 50픽셀, 글자 가운데 정렬-->
        <td width=50><p align=center>평균</p></td> <!--셀너비 50픽셀, 글자 가운데 정렬-->
        <td width=50><p align=center>등수</p></td> <!--셀너비 50픽셀, 글자 가운데 정렬-->
    </tr> <!--행 끝-->   
<% //sciptlet 시작
	for(int i = 0; i < studentScores.size(); i++) {  //studentScores객체배열의 크기만큼 반복한다
		StudentScore studentScore1 = new StudentScore();
		//StudentScore클래스의 인스턴스를 생성하여 studentScore변수에 할당
		studentScore1 = studentScores.get(i); //studentScores객체배열의 i번째 객체변수를 studentScore변수에 할당
        if(studentScore1.getStudentId() == sid) { //수정한 학번이 현재 학번과 같다면
            out.println("<tr style=\"background-color:yellow\">"); //해당 행에 노란색 배경을 적용한다
        } else { //그렇지 않다면
            out.println("<tr>"); //보통 테이블 행 시작표시 출력
        }
        out.println("<td width=50><p align=center><a href=\"oneview.jsp?id="+studentScore1.getStudentId()+"\" target=\"content\">" + studentScore1.getName()+"</p></td>");
	    //studentScore에서 이름을 테이블의 셀에 대입하여 출력해준다, 하이퍼링크를 이용하여 해당학번을 클릭하면 학번정보와 함께 oneview.jsp로 이동하도록 설정한다
	   	out.println("<td width=50><p align=center>" + Integer.toString(studentScore1.getStudentId())+"</p></td>");
	    //studentScore에서 학번을 정수값으로 가져와 문자열로 변환하여 테이블의 셀에 대입하여 출력해준다
	    out.println("<td width=50><p align=center>" + Integer.toString(studentScore1.getKor())+"</p></td>");
	    //studentScore에서 국어점수를 정수값으로 가져와 문자열로 변환하여 테이블의 셀에 대입하여 출력해준다
	    out.println("<td width=50><p align=center>" + Integer.toString(studentScore1.getEng())+"</p></td>");
	    //studentScore에서 영어점수를 정수값으로 가져와 문자열로 변환하여 테이블의 셀에 대입하여 출력해준다
	    out.println("<td width=50><p align=center>" + Integer.toString(studentScore1.getMat())+"</p></td>");
	    //studentScore에서 수학점수를 정수값으로 가져와 문자열로 변환하여 테이블의 셀에 대입하여 출력해준다
	    out.println("<td width=50><p align=center>" + Integer.toString(studentScore1.getSum())+"</p></td>");
	    //studentScore에서 합계를 정수값으로 가져와 문자열로 변환하여 테이블의 셀에 대입하여 출력해준다
	    out.println("<td width=50><p align=center>" + Integer.toString(studentScore1.getAve())+"</p></td>");
	    //studentScore에서 평균을 정수값으로 가져와 문자열로 변환하여 테이블의 셀에 대입하여 출력해준다
	    out.println("<td width=50><p align=center>" + Integer.toString(studentScore1.getRan())+"</p></td>");
	    //studentScore에서 등수를 정수값으로 가져와 문자열로 변환하여 테이블의 셀에 대입하여 출력해준다
	    out.println("</tr>"); //테이블 행 끝표시 출력
	} 
%> <!-- scriptlet 끝 -->
	<tr> <!-- 행 시작 -->
	    <td colspan=8 style="border: none;"> <!--해당 행의 8열까지 합쳐주고 테두리는 없음-->	
	        <ul> <!--리스트 시작-->
	        <%  //scriptlet 시작 
	            if(10 < C) {  //현재 페이지가 10보다 클 때만 다음 두개의 버튼을 출력한다
	        %>
	                <a href="AllviewDB.jsp?pageNo=<%=PP %>&sid=<%=sid %>&cntPT=<%=cntPT %>"><<</a> 
	                <!-- <<버튼을 누르면 첫번째 페이지로 이동한다-->
	                <a href="AllviewDB.jsp?pageNo=<%=P %>&sid=<%=sid %>&cntPT=<%=cntPT %>"><</a>
	                <!-- <버튼을 누르면 이전 블록으로 이동한다-->
	        <%
	            }
	             //만약 마지막 페이지수가 현 블록의 마지막 페이지 번호보다 크면
                for(int i = S; i < E + 1; i++) { //페이지번호 10개를 출력
                    if(i == C) {//페이지번호가 현재페이지번호가 될 때만 텍스트색을 red로 지정
        	%>
                        <a style="color: red;" href="AllviewDB.jsp?pageNo=<%=i %>&sid=<%=sid %>&cntPT=<%=cntPT %>"><%=i %></a>
                        <!--현재페이지 버튼번호를 빨간색으로 출력해준다-->
        	<%
                    } else {
        	%>
                        <a href="AllviewDB.jsp?pageNo=<%=i %>&sid=<%=sid %>&cntPT=<%=cntPT %>"><%=i %></a>
                        <!--현 블록의 페이지버튼 번호 10개를 출력해준다-->
        	<%             
                    }
                }   
	        
	    		if(NN != -1) { //첫페이지로 가는 넘버값이 -1이 아닐 때만
	        %> 
	                <a href="AllviewDB.jsp?pageNo=<%=N %>&sid=<%=sid %>&cntPT=<%=cntPT %>">></a>
	                <!-- >버튼을 누르면 다음 블록으로 이동한다-->
	                <a href="AllviewDB.jsp?pageNo=<%=NN%>&sid=<%=sid %>&cntPT=<%=cntPT %>">>></a>
	                <!-- >>버튼을 누르면 마지막 페이지로 이동한다-->
	        <%
	    		}
	        %>  <!--scriptlet 끝-->
	        </ul><!--리스트 끝-->
	    </td> <!--행 끝-->
	</tr> <!-- 행 끝 -->
</table> <!--테이블 끝-->
</table> <!--테이블 닫기-->
</body> <!--본문 끝-->
</html> <!--html언어로 작성 끝-->