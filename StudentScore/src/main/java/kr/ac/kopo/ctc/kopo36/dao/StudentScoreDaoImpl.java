package kr.ac.kopo.ctc.kopo36.dao;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.mysql.cj.protocol.Resultset;

import kr.ac.kopo.ctc.kopo36.domain.StudentScore;

public class StudentScoreDaoImpl implements StudentScoreDao { //StudentScoreDao인터페이스를 상속받아 override한다

	@Override
	public String createTable() { //테이블을 생성하고 문자열을 리턴하는 함수
		try {
		    Class.forName("com.mysql.cj.jdbc.Driver");
		    //데이터베이스와 통신하는데 사용되는 클래스를 호출한다
		    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo36", "root", "0000");
		    //jdbc를 이용하여 mysql데이터베이스에 대한 연결을 설정한다
		    Statement stmt = conn.createStatement();
		    //데이터베이스에 대해 sql문을 실행하는데 사용할 statement객체를 생성한다
		    String QueryTxt = String.format("create table examtable(id INT AUTO_INCREMENT PRIMARY KEY, name varchar(20), studentid int not null unique, kor int, eng int, mat int);");
		    //실행할 sql문 문자열 생성, 자동생성되는 id와 이름, 학번, 국영수점수를 필드로 가지는 examtable테이블을 생성한다
		    stmt.execute(QueryTxt);  //해당 쿼리문 실행
		    } catch(Exception e) {//Exception오류가 발생하면
		    	e.printStackTrace(); //오류 내역을 출력해준다
		        return e.toString(); //오류문자열을 리턴한다
		    }
		return "테이블 생성 완료"; //생성완료 메시지를 리턴한다
	}
	
	@Override
	public String dropTable() { //테이블을 삭제하고 문자열을 리턴하는 함수
		try {
		    Class.forName("com.mysql.cj.jdbc.Driver");
		    //데이터베이스와 통신하는데 사용되는 클래스를 호출한다
		    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo36", "root", "0000");
		    //jdbc를 이용하여 mysql데이터베이스에 대한 연결을 설정한다
		    Statement stmt = conn.createStatement();
		    //데이터베이스에 대해 sql문을 실행하는데 사용할 statement객체를 생성한다
		    String QueryTxt = String.format("drop table examtable;");
		    //실행할 sql문 문자열 생성, examtable테이블을 삭제한다
		    stmt.execute(QueryTxt);  //해당 쿼리문 실행
		    } catch(Exception e) {//Exception오류가 발생하면
		        e.printStackTrace(); //오류 내역을 출력해준다
		        return e.toString();//오류문자열을 리턴한다
		    }
		return "테이블 삭제 완료"; //삭제완료 메시지를 리턴한다
	}
	
	@Override
	public String insertAll() { //테이블에 모든 데이터를 입력하고 문자열을 리턴하는 함수
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		    //데이터베이스와 통신하는데 사용되는 클래스를 호출한다
		    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo36", "root", "0000");
		    //jdbc를 이용하여 mysql데이터베이스에 대한 연결을 설정한다
		    Statement stmt = conn.createStatement();
		    //데이터베이스에 대해 sql문을 실행하는데 사용할 statement객체를 생성한다
		    
		    for(int i = 1; i < 1001; i++) { //1000개의 데이터를 입력하기 위해 반복문을 이용한다
		    	String name = "홍길" + Integer.toString(i); //홍길1부터 홍길1000까지 생성
		    	int studentid = 209900 + i; //209901번부터 210900까지 1000개의 학번 생성
			    int kor = (int)(Math.random()*101); //랜덤함수를 이용하여 0~100사이의 국어점수 생성
			    int eng = (int)(Math.random()*101); //랜덤함수를 이용하여 0~100사이의 영어점수 생성
			    int mat = (int)(Math.random()*101); //랜덤함수를 이용하여 0~100사이의 수학점수 생성
		        stmt.execute("insert into examtable (name, studentid, kor, eng, mat) VALUES ('"+name+"', "+studentid+", "+kor+", "+eng+", "+mat+");"); 
		        //해당 자료들을 examtable의 해당필드에 입력하는 쿼리 실행, id는 자동생성된다
		    }
		    
	        stmt.close(); //Statement개체를 닫는다
		    conn.close(); //데이터베이스 연결을 닫는다
	    } catch(Exception e) {//Exception오류가 발생하면
	    	  e.printStackTrace(); //오류 내역을 출력해준다
		      return e.toString();//오류문자열을 리턴한다
	    }    
		return "데이터 입력 완료"; //입력완료 메시지를 리턴한다
	}
	
	@Override
	public StudentScore insert(StudentScore studentScore_k36) { //테이블에 특정학생의 데이터를 입력하고 객체를 리턴하는 함수
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			// 데이터베이스와 통신하는데 사용되는 클래스를 호출한다
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo36", "root", "0000");
			// jdbc를 이용하여 mysql데이터베이스에 대한 연결을 설정한다	
			Statement stmt = conn.createStatement();
			// 데이터베이스에 대해 sql문을 실행하는데 사용할 statement객체를 생성한다
			ResultSet rset = stmt.executeQuery("select * from examtable order by studentid;");
            //학번으로 정렬한 examtable의 모든 자료를 조회하는 sql쿼리를 실행하고 결과를 ResultSet에 반환한다
			int fromId = 209901;//최초 학번을 fromId 변수에 대입
            while (rset.next()){ //rset객체의 각 행을 반복한다
                if (fromId == rset.getInt(3)) { //첫번째 자료부터 차례대로 학번을 뽑아 존재하면
                    fromId++;   //다음 학번으로 넘어간다
                } else { //해당학번이 존재하지 않으면
                    break; //루프를 종료한다
                }
            }     
            studentScore_k36.setStudentId(fromId); //studentScore_k36객체의 studentid에 fromId값을 할당
			stmt.execute("insert into examtable (name, studentid, kor, eng, mat) value "
					+ "('" + studentScore_k36.getName() + "'," + fromId + "," + studentScore_k36.getKor() +
					"," + studentScore_k36.getEng() + "," + studentScore_k36.getMat() + ");");
			//examtable의 각 필드에 studentScore_k36객체의 해당값을 가져와 입력하는 쿼리를 수행한다
			ResultSet rset1 = stmt.executeQuery("select id from examtable where studentid = " + fromId + ";");
			//해당 학번을 가진 학생의 id를 조회하는 쿼리를 실행하여 ResultSet으로 받는다
			int id = 0; //id값을 받아오기 위한 정수형 변수를 선언하고 0으로 초기화한다
			while (rset1.next()) { // ResultSet을 실행시킨다
				id = rset1.getInt(1); // rset의 1번째 인덱스 정수값을 가져와 변수 id에 할당한다
			}
			studentScore_k36.setId(id);	//studentScore_k36객체의 id에 id값을 할당한다
			rset.close(); //ResultSet개체를 닫는다
			rset1.close(); //ResultSet개체를 닫는다
			stmt.close(); //Statement개체를 닫는다
			conn.close();	//데이터베이스 연결을 닫는다
		} catch (ClassNotFoundException | SQLException e) { //해당 오류가 발생하면
			e.printStackTrace(); //오류메시지를 출력하고
			return null; //null값을 리턴한다
		}
		return studentScore_k36; //insert가 올바르게 실행되면 해당 객체를 리턴한다
	}

	@Override
	public StudentScore selectOne(int id_k36) { //테이블에 특정 학번을 가진 학생을 검색해서 보여주는 함수
		StudentScore studentScore = new StudentScore(); //studentScore객체를 생성한다
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			// 데이터베이스와 통신하는데 사용되는 클래스를 호출한다
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo36", "root", "0000");
			// jdbc를 이용하여 mysql데이터베이스에 대한 연결을 설정한다
			Statement stmt = conn.createStatement();
			// 데이터베이스에 대해 sql문을 실행하는데 사용할 statement객체를 생성한다
			stmt.execute("DROP view if exists rtview"); //rtview가 존재하면 삭제하는 쿼리문을 실행한다
		    stmt.execute("create view rtview(id, name, studentid, kor, eng, mat, sum, ave, ran)"
		            + "as select *, b.kor+b.eng+b.mat, (b.kor+b.eng+b.mat)/3,"
		            + "(select count(*) + 1 from examtable as a where (a.kor+a.eng+a.mat) > (b.kor+b.eng+b.mat))"
		            + "from examtable as b;");
		    //examtable로부터 모든 자료를 조회하고 총합, 평균, 등수를 뽑아내는 rtview를 생성한다
			ResultSet rset = stmt.executeQuery("select * from rtview where studentid = " + id_k36 + ";");
			// rtview에서 해당 학번의 자료를 조회하는 sql쿼리를 실행하고 결과를 ResultSet에 반환한다	
			while (rset.next()) { // 더이상 읽을 내용이 없을 때까지 한줄씩 읽어오기 반복
				studentScore.setId(rset.getInt(1)); //rset의 1번째 인덱스의 정수값을 studentScore의 id에 할당한다
				studentScore.setName(rset.getString(2)); //rset의 2번째 인덱스의 문자열값을 studentScore의 이름에 할당한다
				studentScore.setStudentId(rset.getInt(3)); //rset의 3번째 인덱스의 정수값을 studentScore의 학번에 할당한다
				studentScore.setKor(rset.getInt(4)); //rset의 4번째 인덱스의 정수값을 studentScore의 국어점수에 할당한다
				studentScore.setEng(rset.getInt(5)); //rset의 5번째 인덱스의 정수값을 studentScore의 영어점수에 할당한다
				studentScore.setMat(rset.getInt(6)); //rset의 6번째 인덱스의 정수값을 studentScore의 수학점수에 할당한다
				studentScore.setSum(rset.getInt(7)); //rset의 7번째 인덱스의 정수값을 studentScore의 합계에 할당한다
				studentScore.setAve(rset.getInt(8)); //rset의 8번째 인덱스의 정수값을 studentScore의 평균에 할당한다
				studentScore.setRan(rset.getInt(9)); //rset의 9번째 인덱스의 정수값을 studentScore의 등수에 할당한다
			}	
			rset.close(); //ResultSet개체를 닫는다
			stmt.close(); //Statement개체를 닫는다
			conn.close();	//데이터베이스 연결을 닫는다
		} catch (ClassNotFoundException | SQLException e) { //해당 오류가 발생하면
			e.printStackTrace(); //오류메시지를 출력하고
			return null; //null값을 리턴한다
		}
		return studentScore; //selectOne이 올바르게 실행되면 해당 객체를 리턴한다
	}

	@Override
	public List<StudentScore> selectAll(int page, int countPerPage) { //현재페이지와 페이지당 데이터수를 입력하면 해당 페이지를 객체배열로 반환하는 함수
		List<StudentScore> studentScores_k36 = new ArrayList<>(); // 객체배열 studentScores_k36선언
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			// 데이터베이스와 통신하는데 사용되는 클래스를 호출한다
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo36", "root", "0000");
			// jdbc를 이용하여 mysql데이터베이스에 대한 연결을 설정한다
			Statement stmt = conn.createStatement();
			// 데이터베이스에 대해 sql문을 실행하는데 사용할 statement객체를 생성한다
			stmt.execute("DROP view if exists rtview"); //rtview가 존재하면 삭제하는 쿼리문을 실행한다
		    stmt.execute("create view rtview(id, name, studentid, kor, eng, mat, sum, ave, ran)"
		            + "as select *, b.kor+b.eng+b.mat, (b.kor+b.eng+b.mat)/3,"
		            + "(select count(*) + 1 from examtable as a where (a.kor+a.eng+a.mat) > (b.kor+b.eng+b.mat))"
		            + "from examtable as b;");
		    //examtable로부터 모든 자료를 조회하고 총합, 평균, 등수를 뽑아내는 rtview를 생성한다
			ResultSet rset = stmt.executeQuery("select * from rtview order by studentid limit " + ((page-1)*countPerPage) +","+ countPerPage +";");
			// examtable에서 해당 페이지의 자료를 조회하는 sql쿼리를 실행하고 결과를 ResultSet에 반환한다
			while (rset.next()) { // 더이상 읽을 내용이 없을 때까지 한줄씩 읽어오기 반복
				StudentScore studentScore_k36 = new StudentScore(); // StudentScore형식의 객체 studentScore_k36 생성
				studentScore_k36.setId(rset.getInt(1)); //rset의 1번째 인덱스의 정수값을 studentScore의 id에 할당한다
				studentScore_k36.setName(rset.getString(2)); //rset의 2번째 인덱스의 문자열을 studentScore의 이름에 할당한다
				studentScore_k36.setStudentId(rset.getInt(3)); //rset의 3번째 인덱스의 정수값을 studentScore의 학번에 할당한다
				studentScore_k36.setKor(rset.getInt(4)); //rset의 4번째 인덱스의 정수값을 studentScore의 국어점수에 할당한다
				studentScore_k36.setEng(rset.getInt(5)); //rset의 5번째 인덱스의 정수값을 studentScore의 영어점수에 할당한다
				studentScore_k36.setMat(rset.getInt(6)); //rset의 6번째 인덱스의 정수값을 studentScore의 수학점수에 할당한다
				studentScore_k36.setSum(rset.getInt(7)); //rset의 7번째 인덱스의 정수값을 studentScore의 합계에 할당한다
				studentScore_k36.setAve(rset.getInt(8)); //rset의 8번째 인덱스의 정수값을 studentScore의 평균에 할당한다
				studentScore_k36.setRan(rset.getInt(9)); //rset의 9번째 인덱스의 정수값을 studentScore의 등수에 할당한다
				studentScores_k36.add(studentScore_k36); // 값이 담아진 studentScore_k36객체를 studentScores_k36객체배열의 변수로 담아줌
			}
			rset.close(); //ResultSet개체를 닫는다
			stmt.close(); //Statement개체를 닫는다
			conn.close();	//데이터베이스 연결을 닫는다
		} catch (ClassNotFoundException | SQLException e) { //해당 오류가 발생하면
			e.printStackTrace(); //오류메시지를 출력하고
			return null; //null값을 리턴한다
		}
		return studentScores_k36; // studentScores_k36객체배열을 리턴해줌
	}

	@Override
	public StudentScore update(int id, StudentScore studentScore) { //특정 학생의 정보를 수정하는 함수
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			// 데이터베이스와 통신하는데 사용되는 클래스를 호출한다
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo36", "root", "0000");
			// jdbc를 이용하여 mysql데이터베이스에 대한 연결을 설정한다
			Statement stmt = conn.createStatement();
			// 데이터베이스에 대해 sql문을 실행하는데 사용할 statement객체를 생성한다
			stmt.execute("update examtable set name = '"+ studentScore.getName() + 
					"', studentid = " + studentScore.getStudentId() + ", kor = " + studentScore.getKor() + 
					", eng = " + studentScore.getEng() + ", mat = " + studentScore.getMat() + " where studentid = " + id + ";");
			// examtable에서 해당 학번을 가진 자료를 조회하고 필드값들을 다시 set하여 update해준다
			stmt.close(); //Statement개체를 닫는다
			conn.close();	//데이터베이스 연결을 닫는다
		} catch (ClassNotFoundException | SQLException e) { //해당 오류가 발생하면
			e.printStackTrace(); //오류메시지를 출력하고
			return null; //null값을 리턴한다
		}
		return studentScore; //studentScore객체를 리턴해줌
	}

	@Override
	public void delete(int id_k36) { //특정 학생의 정보를 삭제하는 함수
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			// 데이터베이스와 통신하는데 사용되는 클래스를 호출한다
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo36", "root", "0000");
			// jdbc를 이용하여 mysql데이터베이스에 대한 연결을 설정한다
			Statement stmt = conn.createStatement();
			// 데이터베이스에 대해 sql문을 실행하는데 사용할 statement객체를 생성한다
			stmt.execute("delete from examtable where studentid = " + id_k36 + ";");
			// examtable에서 해당 학번을 가진 자료를 삭제한다
			stmt.close(); //Statement개체를 닫는다
			conn.close();	//데이터베이스 연결을 닫는다
			System.out.println("delete complete."); //삭제완료메시지를 출력한다
		} catch (ClassNotFoundException | SQLException e) { //해당 오류가 발생하면
			e.printStackTrace(); //오류메시지를 출력한다
		}
	}
}
