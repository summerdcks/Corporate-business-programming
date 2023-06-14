<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<!--html 메타태그: 문서의 문자 인코딩을 utf-9로 설정한다-->
<%@ page contentType="text/html; charset=utf-8" %>
<!--utf-8 문자 인코딩으로 html콘텐츠를 생성할 것을 지정한다-->
<%@ page import ="java.io.*, java.net.*" %>
<!--java.io, java.net패키지를 가져와 입력 및 출력 작업에 사용되는 클래스를 제공한다-->
<html> <!--html로 작성 시작-->
<head></head> <!--머릿말-->
<body> <!--본문 시작-->
<H1><center> JSP Database 실습 1</center></h1> <!--표제, 가운데정렬-->
<%  //scriptlet 시작
    String data; //파일을 읽어줄 문자형변수
    int cnt=0; //방문횟수를 카운트해줄 정수형변수 0대입
    FileReader f1 = new FileReader("C:\\Users\\DataSWB\\eclipse-workspace\\StudentScore\\src\\main\\webapp\\cnt.txt");
    //cnt.txt파일을 읽기 위해 FileReader객체를 생성한다
    StringBuffer sb = new StringBuffer();
    //읽어온 파일 내용을 저장할 StringBuffer객체를 생성한다
    int ch=0; //파일에서 읽은 문자의 아스키코드를 저장할 정수형변수
    while((ch=f1.read()) != -1) { //-1(파일의 끝)이 아닌 동안 반복하며 읽은 문자의 아스키코드를 ch에 할당한다
        sb.append((char)ch); //ch에 저장된 아스키코드를 문자형변환하고 sb에 문자를 추가한다
    }
    //파일의 내용을 한글자씩 읽어와 sb에 추가한다
    data=sb.toString().trim().replace("\n","");
    //sb를 String으로 변환하여 공백과 개행문자를 제거하고 data에 할당한다
    f1.close(); //파일 닫기

    cnt = Integer.parseInt(data);   //data를 정수형변환하고 cnt에 할당한다
    cnt++; //방문 횟수를 1 증가한다
    data = Integer.toString(cnt); //방문횟수를 다시 문자형변환하여 data에 할당한다
    
    out.println("<br><br>현재 홈페이지 방문조회수는 ["+data+"] 입니다</br>");
    //업데이트된 방문 횟수를 웹페이지에 출력한다    
    FileWriter f12 = new FileWriter("C:\\Users\\DataSWB\\eclipse-workspace\\StudentScore\\src\\main\\webapp\\cnt.txt", false);
    //cnt.txt파일을 쓰기 위해 FileWriter객체를 생성한다
    f12.write(data);    //업데이트된 방문 횟수를 파일에 기록한다
    f12.close();    //파일 닫기
%> <!--scriptlet 끝 -->
</body> <!--본문 끝-->
</html> <!--html언어로 작성 끝-->