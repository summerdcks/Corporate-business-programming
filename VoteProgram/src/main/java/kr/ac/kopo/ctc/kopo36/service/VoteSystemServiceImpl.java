package kr.ac.kopo.ctc.kopo36.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class VoteSystemServiceImpl implements VoteSystemService {	
	
	@Override
	public int getAvailableKiho() { //새로 입력이 가능한 기호를 도출하는 함수
		int kiho = 1; //기호를 1번부터 살펴보기 위해 정수형 변수 선언하고 1로 초기화
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			// 데이터베이스와 통신하는데 사용되는 클래스를 호출한다
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo36", "root", "0000");
			// jdbc를 이용하여 mysql데이터베이스에 대한 연결을 설정한다
			Statement stmt = conn.createStatement();
			// 데이터베이스에 대해 sql문을 실행하는데 사용할 statement객체를 생성한다
			ResultSet rset = stmt.executeQuery("select * from hubo order by kiho;");
			//kiho를 기준으로 정렬한 hubo테이블의 모든 자료를 가져와 ResultSet에 담아줌
            while (rset.next()){ //rset객체의 각 행을 반복한다
                if (kiho == rset.getInt(1)) { //첫번째 자료부터 차례대로 기호를 뽑아 존재하면
                	kiho++;   //다음기호로 넘어간다
                } else { //해당 기호가 존재하지 않으면
                    break; //루프를 종료한다
                }
            } 
            stmt.close(); //Statement개체를 닫는다
			conn.close();	//데이터베이스 연결을 닫는다
		} catch (Exception e) { //오류가 발생하면
			e.printStackTrace(); //오류메시지를 출력한다
			return -1; //-1을 리턴한다
		}
		return kiho; //kiho를 리턴한다
	}
		
	@Override
	public int countVotes(int kiho) { //특정후보의 총득표수를 가져오는 함수
		int count = 0; //총득표수 정수형변수 선언하고 0으로 초기화
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			// 데이터베이스와 통신하는데 사용되는 클래스를 호출한다
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo36", "root", "0000");
			// jdbc를 이용하여 mysql데이터베이스에 대한 연결을 설정한다
			Statement stmt = conn.createStatement();
			// 데이터베이스에 대해 sql문을 실행하는데 사용할 statement객체를 생성한다
			ResultSet rset = stmt.executeQuery("select count(*) from tupyo where kiho = "+kiho+";");
			//해당기호를 가진 총자료수를 투표테이블에서 조회하여 ResultSet에 담는다
			while (rset.next()){ //rset객체의 각 행을 반복한다
				count = rset.getInt(1); //1번째 정수값을 가져와 count에 대입한다
	        }
			stmt.close(); //Statement개체를 닫는다
			conn.close();	//데이터베이스 연결을 닫는다
		} catch (Exception e) { //오류가 발생하면
			e.printStackTrace(); //오류메시지를 출력한다
			return -1; //-1을 리턴한다
		}
		return count; //해당후보의 총득표수를 리턴한다
	}
	
	@Override
	public int selectOne(int kiho, int age) { //특정후보의 연령대별 득표수를 가져오기 위한 함수
		int count = 0; //연령대별 득표수를 정수형 변수로 선언하여 0으로 초기화
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			// 데이터베이스와 통신하는데 사용되는 클래스를 호출한다
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo36", "root", "0000");
			// jdbc를 이용하여 mysql데이터베이스에 대한 연결을 설정한다
			Statement stmt = conn.createStatement();
			// 데이터베이스에 대해 sql문을 실행하는데 사용할 statement객체를 생성한다
			ResultSet rset = stmt.executeQuery("select count(*) from tupyo where kiho = "+kiho+" and age = "+age+";");
			//해당 기호와 연령대를 가진 자료수를 투표테이블에서 조회하여 ResultSet에 담는다
			while (rset.next()){ //rset객체의 각 행을 반복한다
				count = rset.getInt(1); //1번째 정수값을 가져와 count에 대입한다
	        }
			stmt.close(); //Statement개체를 닫는다
			conn.close();	//데이터베이스 연결을 닫는다
		} catch (Exception e) { //오류가 발생하면
			e.printStackTrace(); //오류메시지를 출력한다
			return -1; //-1을 리턴한다
		}
		return count; //연령대별 득표수를 리턴한다
	}

	@Override
	public int countAll() { //총투표수를 가져오는 함수
		int count = 0; //총투표수 정수형 변수 선언하고 0으로 초기화
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			// 데이터베이스와 통신하는데 사용되는 클래스를 호출한다
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo36", "root", "0000");
			// jdbc를 이용하여 mysql데이터베이스에 대한 연결을 설정한다
			Statement stmt = conn.createStatement();
			// 데이터베이스에 대해 sql문을 실행하는데 사용할 statement객체를 생성한다
			ResultSet rset = stmt.executeQuery("select count(*) from tupyo;");
			//투표테이블의 총자료수 = 총투표수를 가져와 ResultSet에 담는다
			while (rset.next()){ //rset객체의 각 행을 반복한다
				count = rset.getInt(1); //1번째 정수값을 가져와 count에 대입한다
	        }
			stmt.close(); //Statement개체를 닫는다
			conn.close();	//데이터베이스 연결을 닫는다
		} catch (Exception e) { //오류가 발생하면
			e.printStackTrace(); //오류메시지를 출력한다
			return -1; //-1을 리턴한다
		}
		return count; //총투표수를 리턴한다
	}
}
