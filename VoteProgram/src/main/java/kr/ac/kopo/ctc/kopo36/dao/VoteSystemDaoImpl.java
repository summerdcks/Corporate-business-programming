package kr.ac.kopo.ctc.kopo36.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import kr.ac.kopo.ctc.kopo36.domain.Vote;

public class VoteSystemDaoImpl implements VoteSystemDao{

	@Override
	public List<Vote> selectAll() { //hubo테이블의 모든 후보자에 대한 기호-이름 정보를 가져오기 위한 함수
		List<Vote> Votes = new ArrayList<>(); // Vote형식의 객체배열 선언
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			// 데이터베이스와 통신하는데 사용되는 클래스를 호출한다
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo36", "root", "0000");
			// jdbc를 이용하여 mysql데이터베이스에 대한 연결을 설정한다
			Statement stmt = conn.createStatement();
			// 데이터베이스에 대해 sql문을 실행하는데 사용할 statement객체를 생성한다
			ResultSet rset = stmt.executeQuery("select * from hubo order by kiho;");
			//kiho를 기준으로 정렬한 hubo테이블의 모든 정보를 가져와 ResultSet에 담아준다
			while (rset.next()) { // 더이상 읽을 내용이 없을 때까지 한줄씩 읽어오기 반복
				Vote vote = new Vote(); // Vote형식의 객체 vote 생성
				vote.setKiho(rset.getInt(1)); //rset에서 1번째 정수값을 가져와 vote의 kiho값으로 넣어준다
				vote.setName(rset.getString(2)); //rset에서 2번째 문자열을 가져와 vote의 name값으로 넣어준다
				Votes.add(vote); // 값이 담아진 vote객체를 Votes객체배열에 담아줌
			}
			rset.close(); //ResultSet개체를 닫는다
			stmt.close(); //Statement개체를 닫는다
			conn.close();	//데이터베이스 연결을 닫는다
		} catch (Exception e) { //오류가 발생하면
			e.printStackTrace(); //오류메시지를 출력한다
		}
		return Votes; //Votes객체배열을 리턴한다
	}

	@Override
	public int deleteHubo(int kiho) { //기호를 매개변수로 받아 특정 후보를 후보테이블에서 삭제하는 함수
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			// 데이터베이스와 통신하는데 사용되는 클래스를 호출한다
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo36", "root", "0000");
			// jdbc를 이용하여 mysql데이터베이스에 대한 연결을 설정한다
			Statement stmt = conn.createStatement();
			// 데이터베이스에 대해 sql문을 실행하는데 사용할 statement객체를 생성한다
			stmt.executeUpdate("delete from hubo where kiho = "+ kiho +";");
			//매개변수로 받은 기호를 가진 자료를 후보테이블에서 삭제한다
			stmt.close(); //Statement개체를 닫는다
			conn.close();	//데이터베이스 연결을 닫는다
		} catch (Exception e) { //오류가 발생하면
			e.printStackTrace(); //오류메시지를 출력한다
			return -1; //-1을 리턴한다
		}
		return kiho; //kiho를 리턴한다
	}


	@Override
	public int deleteHuboTupyo(int kiho) {
		//득표한 후보는 투표테이블에서 foreign key로 잡혀있어 후보테이블에서 삭제가 불가능하므로 투표,후보테이블에서 모두 삭제하는 함수
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			// 데이터베이스와 통신하는데 사용되는 클래스를 호출한다
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo36", "root", "0000");
			// jdbc를 이용하여 mysql데이터베이스에 대한 연결을 설정한다
			Statement stmt = conn.createStatement();
			// 데이터베이스에 대해 sql문을 실행하는데 사용할 statement객체를 생성한다
			stmt.executeUpdate("delete from tupyo where kiho = "+ kiho +";");
			//tupyo테이블에서 해당 kiho를 가진 자료를 삭제한다
			stmt.executeUpdate("delete from hubo where kiho = "+ kiho +";");
			//hubo테이블에서 해당 kiho를 가진 자료를 삭제한다
			stmt.close(); //Statement개체를 닫는다
			conn.close();	//데이터베이스 연결을 닫는다
		} catch (Exception e) { //오류가 발생하면
			e.printStackTrace(); //오류메시지를 출력한다
			return -1; //-1를 리턴한다
		}
		return kiho; //kiho를 리턴한다
	}
	
	@Override
	public String insertIntoHubo(String name) { //이름을 매개변수로 받아 새로운 후보를 후보테이블에 입력하는 함수
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			// 데이터베이스와 통신하는데 사용되는 클래스를 호출한다
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo36", "root", "0000");
			// jdbc를 이용하여 mysql데이터베이스에 대한 연결을 설정한다
			Statement stmt = conn.createStatement();
			// 데이터베이스에 대해 sql문을 실행하는데 사용할 statement객체를 생성한다
			ResultSet rset = stmt.executeQuery("select * from hubo order by kiho;");
			//kiho를 기준으로 정렬한 hubo의 모든 자료를 ResultSet으로 가져온다
			int id = 1; //기호 1부터 검색하기 위해 정수형 변수 선언하고 1로 초기화
            while (rset.next()){ //rset객체의 각 행을 반복한다
                if (id == rset.getInt(1)) { //첫번째 자료부터 차례대로 기호를 뽑아 존재하면
                	id++;   //다음기호로 넘어간다
                } else { //해당 기호가 존재하지 않으면
                    break; //루프를 종료한다
                }
            } 
			stmt.executeUpdate("insert into hubo value ("+ id +", '"+ name +"');");
			//해당 kiho와 name을 가진 자료를 hubo테이블에 입력한다
			stmt.close(); //Statement개체를 닫는다
			conn.close();	//데이터베이스 연결을 닫는다
		} catch (Exception e) { //오류가 발생하면
			e.printStackTrace(); //오류메시지를 출력한다
			return "insert fail"; //해당문자열을 리턴한다
		}
		return "insert success"; //해당문자열을 리턴한다
	}
	
	@Override
	public int insertIntoTupyo(int kiho, int age) { //기호와 연령대를 매개변수로 받아 투표테이블에 투표하는 함수
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			// 데이터베이스와 통신하는데 사용되는 클래스를 호출한다
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo36", "root", "0000");
			// jdbc를 이용하여 mysql데이터베이스에 대한 연결을 설정한다
			Statement stmt = conn.createStatement();
			// 데이터베이스에 대해 sql문을 실행하는데 사용할 statement객체를 생성한다
			stmt.executeUpdate("insert into tupyo (kiho, age) value ("+ kiho +", "+ age +");");
			//해당 기호와 연령대를 투표테이블에 입력해준다
			stmt.close(); //Statement개체를 닫는다
			conn.close();	//데이터베이스 연결을 닫는다
		} catch (Exception e) { //오류가 발생하면
			e.printStackTrace(); //오류메시지를 출력한다
			return -1; //-1을 리턴한다
		}
		return kiho; //kiho를 리턴한다
	}	

}
