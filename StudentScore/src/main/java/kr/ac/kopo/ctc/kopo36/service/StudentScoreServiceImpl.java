package kr.ac.kopo.ctc.kopo36.service;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import kr.ac.kopo.ctc.kopo36.dao.StudentScoreDaoImpl;
import kr.ac.kopo.ctc.kopo36.dto.pagination;

public class StudentScoreServiceImpl implements StudentScoreService {

	@Override
	public pagination getPagination(int page, int countPerPage){ //현재페이지와 페이지당 자료수를 입력하면 페이지버튼값을 리턴하는 함수
		StudentScoreService s = new StudentScoreServiceImpl();
		//StudentScoreServiceImpl클래스의 인스턴스를 StudentScoreService타입의 변수 s에 할당해준다
		int total = s.count(); //s객체의 count메소드를 실행하여 총자료수를 구한다
		int lastPage = total % countPerPage == 0 ? (total/countPerPage) : (int)(total/countPerPage) + 1;
		//총자료수를 페이지당 출력하고자 하는 자료수로 나누어 마지막페이지번호를 구한다
		pagination pagination = new pagination();
		//pagination클래스의 인스턴스를 생성하여 pagination변수에 할당한다
		
		int C; //현재페이지번호 선언
		if (page < 1) { //페이지가 1보다 작으면
			C = 1; //1페이지 할당
		} else if (page >= lastPage) { //페이지가 마지막페이지보다 크거나 같으면
			C = lastPage; //마지막페이지 할당
		} else { //그 외에는
			C = page; //해당페이지 할당
		}
		
		int S = C % 10 == 0 ? (((int)(C/10))-1)*10+1 : ((int)(C/10))*10+1 ;
		//현재페이지와 출력할 페이지버튼수를 이용하여 출력해줄 첫번째 페이지버튼을 구한다
		int E = S + 9; //첫번째 페이지버튼에 9를 더하여 마지막 페이지버튼을 구한다
		if (E > lastPage) { //마지막페이지 버튼이 마지막페이지수보다 크면
			E = lastPage; //마지막페이지수를 마지막페이지버튼에 할당한다
		}
		
		int P = C - 10 > 1 ? C - 10 : 1; 
		//이전페이지버튼에 현재페이지보다 10작은 페이지를 할당하고 그 값이 1보다 작으면 1페이지를 할당한다
		int PP = 1; //처음페이지버튼에 1페이지를 할당한다
		if (C < 11) { //현재페이지가 11페이지보다 작으면
			P = -1; //이전버튼을 -1로 하여 표시해주지 않는다
			PP = -1; //처음버튼을 -1로 하여 표시해주지 않는다
		}
		
		int N = C + 10 < lastPage ? C + 10 : lastPage;
		//다음페이지버튼에 현재페이지보다 10큰 페이지를 할당하고 그 값이 마지막페이지수보다 크면 마지막페이지를 할당한다
		int lastPageS = lastPage % 10 == 0 ? (((int)(lastPage/10))-1)*10+1 : ((int)(lastPage/10))*10+1 ;
		//마지막페이지단의 시작페이지버튼을 구해준다
		int NN = lastPage; //마지막페이지버튼에 마지막페이지를 할당해준다
		if (C >= lastPageS) { //현재페이지가 마지막페이지의 시작버튼보다 크거나 같으면
			N = -1; //다음페이지버튼을 -1로 하여 표시해주지 않는다
			NN = -1; //마지막페이지버튼을 -1로 하여 표시해주지 않는다
		}
				
		pagination.setC(C); //pagination의 C에 C값을 할당한다
		pagination.setS(S); //pagination의 S에 S값을 할당한다
		pagination.setE(E); //pagination의 E에 E값을 할당한다
		pagination.setP(P); //pagination의 P에 P값을 할당한다
		pagination.setPp(PP); //pagination의 PP에 PP값을 할당한다
		pagination.setN(N); //pagination의 N에 N값을 할당한다
		pagination.setNn(NN); //pagination의 NN에 NN값을 할당한다
		return pagination; //해당객체를 리턴한다
	}

	@Override
	public int count() { //전체자료수를 리턴하는 함수
		int total;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			// 데이터베이스와 통신하는데 사용되는 클래스를 호출한다
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo36", "root", "0000");
			// jdbc를 이용하여 mysql데이터베이스에 대한 연결을 설정한다
			Statement stmt = conn.createStatement();
			// 데이터베이스에 대해 sql문을 실행하는데 사용할 statement객체를 생성한다
			total = 0; // 전체 자료수를 정수형 변수로 생성하여 0 대입
			ResultSet countrset = stmt.executeQuery("select count(*) from examtable;");
			// examtable의 총자료수를 조회하는 해당 쿼리를 실행하여 결과를 ResultSet에 담는다
			while (countrset.next()) { // ResultSet을 실행시킨다
				total = countrset.getInt(1); // countrset의 1번째 인덱스 정수값을 가져와 변수 total에 할당한다
			}
			countrset.close(); // 파일 닫기
			stmt.close(); //Statement개체를 닫는다
			conn.close();	//데이터베이스 연결을 닫는다
		} catch (ClassNotFoundException | SQLException e) { //해당 오류가 발생하면
			e.printStackTrace(); //오류메시지를 출력하고
			return -1; //-1값을 리턴한다
		}
		return total; //총자료수를 리턴한다
	}

	@Override
	public int currentPageNumber(int id, int countPerPage) { //특정학번과 페이지당 자료수를 입력하면 해당학번이 있는 페이지를 리턴하는 함수
		int page = 0; //리턴해줄 현재페이지를 정수형 변수로 선언
		int place = 0; //해당 학번이 테이블의 몇번째 자료인지 구하기 위한 정수형 변수 선언
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			// 데이터베이스와 통신하는데 사용되는 클래스를 호출한다
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo36", "root", "0000");
			// jdbc를 이용하여 mysql데이터베이스에 대한 연결을 설정한다
			Statement stmt = conn.createStatement();
			// 데이터베이스에 대해 sql문을 실행하는데 사용할 statement객체를 생성한다
			int realid = 0; //해당학번의 id를 담아주기 위한 정수형 변수 선언
			String q = "select id from examtable where studentid = " + id + ";";
			//해당학번의 id를 조회하는 쿼리를 생성한다
			ResultSet r = stmt.executeQuery(q); //쿼리를 실행하고 결과를 ResultSet에 담아준다
			while(r.next()) { //ResultSet을 실행시킨다
				realid = r.getInt(1); //id를 담아준다
			}
			String query = "select (select count(*) + 1 from examtable as a where (a.id) < (b.id)) from examtable as b"
		               + " where id = "+realid+";";
			//해당 id보다 작은 id의 수를 조회하고 1을 더하여 반환(해당 id가 몇번째에 위치한 자료인지 반환)하는 쿼리를 생성한다
			ResultSet rset = stmt.executeQuery(query); //해당쿼리를 실행시키고 결과를 ResultSet에 받는다
			while(rset.next()) { //ResultSet을 실행시킨다
				place = rset.getInt(1); //몇번째 자료인지 값을 담아준다
			}
			page = place % countPerPage == 0 ? (place/countPerPage) : (place/countPerPage) + 1;
			//몇번째 자료인지를 페이지당 출력하고자 하는 자료수로 나누어주면 해당페이지 넘버를 구할 수 있다
			rset.close(); //ResultSet개체를 닫는다
			stmt.close(); //Statement개체를 닫는다
		    conn.close(); //데이터베이스 연결을 닫는다
		} catch(Exception e) {//Exception오류가 발생하면
			e.printStackTrace(); //오류 내역을 출력해준다
			return -1; //-1을 리턴한다
		}  
		return page; //해당페이지넘버를 리턴한다
	}

	@Override
	public int countVisitor() { //방문자수를 세어주는 함수
		int count= 0; //방문자수를 담기 위한 정수형 변수 선언
		try {
		Class.forName("com.mysql.cj.jdbc.Driver");
	    //데이터베이스와 통신하는데 사용되는 클래스를 호출한다
	    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo36", "root", "0000");
	    //jdbc를 이용하여 mysql데이터베이스에 대한 연결을 설정한다
	    Statement stmt = conn.createStatement();
	    //데이터베이스에 대해 sql문을 실행하는데 사용할 statement객체를 생성한다
		ResultSet rset1 = stmt.executeQuery("select count from countVisitor where id = 1;");
		//countVisitor테이블의 유일한 자료값을 조회해서 ResultSet에 담아준다
		while(rset1.next()) { //ResultSet을 실행시킨다
			count = rset1.getInt(1); //count에 방문자수를 담아준다
		}
		count++; //방문자수를 1 증가한다
		stmt.executeUpdate("update countVisitor set count = "+count+" where id = 1;");
		//1증가한 방문자수를 다시 테이블에 update해준다	
		rset1.close(); //ResultSet개체를 닫는다
		stmt.close(); //Statement개체를 닫는다
	    conn.close(); //데이터베이스 연결을 닫는다
		} catch(Exception e) {//Exception오류가 발생하면
			e.printStackTrace(); //오류 내역을 출력해준다
			return -1; //-1을 리턴한다
		}  
		return count; //방문자수를 리턴한다
	}

}
