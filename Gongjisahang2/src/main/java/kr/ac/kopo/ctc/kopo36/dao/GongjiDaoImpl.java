package kr.ac.kopo.ctc.kopo36.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import kr.ac.kopo.ctc.kopo36.domain.Gongji;

public class GongjiDaoImpl implements GongjiDao{
	@Override
	public String createInsertTable() { //db에 테이블을 생성하고 데이터를 입력함
		try {
		    Class.forName("com.mysql.cj.jdbc.Driver");
		    //데이터베이스와 통신하는데 사용되는 클래스를 호출한다
		    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo36", "root", "0000");
		    //jdbc를 이용하여 mysql데이터베이스에 대한 연결을 설정한다
		    Statement stmt = conn.createStatement();
		    //데이터베이스에 대해 sql문을 실행하는데 사용할 statement객체를 생성한다
		    stmt.execute("drop table gongji2;"); //공지 테이블이 있으면 삭제하는 쿼리 실행
		    stmt.execute("create table gongji2(id INT not null primary key AUTO_INCREMENT, title varchar(70), date date, content text)DEFAULT CHARSET=utf8;");
		    //테이블 생성 쿼리 실행
		    stmt.execute("insert into gongji2(title,date,content) values('공지사항1',date(now()),'공지사항내용1');");
		    stmt.execute("insert into gongji2(title,date,content) values('공지사항2',date(now()),'공지사항내용2');");
		    stmt.execute("insert into gongji2(title,date,content) values('공지사항3',date(now()),'공지사항내용3');");
		    stmt.execute("insert into gongji2(title,date,content) values('공지사항4',date(now()),'공지사항내용4');");
		    stmt.execute("insert into gongji2(title,date,content) values('공지사항5',date(now()),'공지사항내용5');");
		    } catch(Exception e) {//Exception오류가 발생하면
		    	e.printStackTrace(); //오류 내역을 출력해준다
		        return e.toString(); //오류문자열을 리턴한다
		    }
		return "테이블 생성, 데이터 입력 완료"; //생성완료 메시지를 리턴한다
	}

	@Override
	public List<Gongji> selectAll(int pageNo, int cntPT) { 
	//페이지넘버와 페이지당 출력할 자료의 수를 매개변수로 받아 해당 페이지의 자료값들을 객체배열로 리턴함
		List<Gongji> gongjis = new ArrayList<>(); //Gongji객체배열 생성
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			// 데이터베이스와 통신하는데 사용되는 클래스를 호출한다
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo36", "root", "0000");
			// jdbc를 이용하여 mysql데이터베이스에 대한 연결을 설정한다
			Statement stmt = conn.createStatement();
			//데이터베이스에 대해 sql문을 실행하는데 사용할 statement객체를 생성한다
			ResultSet rset = stmt.executeQuery("select * from gongji2 order by id desc limit " + ((pageNo-1)*cntPT) +","+ cntPT +";");
			// gongji에서 해당 페이지의 자료를 역순으로 조회하는 sql쿼리를 실행하고 결과를 ResultSet에 반환한다
			while (rset.next()) { // 더이상 읽을 내용이 없을 때까지 한줄씩 읽어오기 반복
				Gongji gongji = new Gongji(); // Gongji형식의 객체 gongji 생성
				gongji.setBunho(rset.getInt(1)); //rset의 1번째 인덱스의 정수값을 gongji의 Bunho에 할당한다
				gongji.setJemok(rset.getString(2)); //rset의 2번째 인덱스의 문자열을 gongji의 Jemok에 할당한다
				gongji.setIlja(rset.getString(3)); //rset의 3번째 인덱스의 문자열을 gongji의 Ilja에 할당한다
				gongji.setNaeyong(rset.getString(4)); //rset의 4번째 인덱스의 문자열을 gongji의 Naeyong에 할당한다
				gongjis.add(gongji); // 값이 담아진 gongji객체를 gongjis객체배열의 변수로 담아줌
			}
			rset.close(); //ResultSet개체를 닫는다
			stmt.close(); //Statement개체를 닫는다
			conn.close();	//데이터베이스 연결을 닫는다
		} catch (ClassNotFoundException | SQLException e) { //해당 오류가 발생하면
			e.printStackTrace(); //오류메시지를 출력하고
			return null; //null값을 리턴한다
		}	
		return gongjis; //해당 객체배열을 리턴해준다
	}

	@Override
	public Gongji OneView(int bunho) { //번호를 매개변수로 받아 해당 번호 글에 대한 정보값들을 리턴함
		Gongji gongji = new Gongji();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			// 데이터베이스와 통신하는데 사용되는 클래스를 호출한다
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo36", "root", "0000");
			// jdbc를 이용하여 mysql데이터베이스에 대한 연결을 설정한다
			Statement stmt = conn.createStatement();
			//데이터베이스에 대해 sql문을 실행하는데 사용할 statement객체를 생성한다
			ResultSet rset = stmt.executeQuery("select * from gongji2 where id = "+bunho+";");
			// gongji에서 해당 글 번호의 자료를 가져오는 sql쿼리를 실행하고 결과를 ResultSet에 반환한다
			while (rset.next()) { // 더이상 읽을 내용이 없을 때까지 한줄씩 읽어오기 반복
				gongji.setBunho(rset.getInt(1)); //rset의 1번째 인덱스의 정수값을 gongji의 Bunho에 할당한다
				gongji.setJemok(rset.getString(2)); //rset의 2번째 인덱스의 문자열을 gongji의 Jemok에 할당한다
				gongji.setIlja(rset.getString(3)); //rset의 3번째 인덱스의 문자열을 gongji의 Ilja에 할당한다
				gongji.setNaeyong(rset.getString(4)); //rset의 4번째 인덱스의 문자열을 gongji의 Naeyong에 할당한다
			}
			rset.close(); //ResultSet개체를 닫는다
			stmt.close(); //Statement개체를 닫는다
			conn.close();	//데이터베이스 연결을 닫는다
		} catch (ClassNotFoundException | SQLException e) { //해당 오류가 발생하면
			e.printStackTrace(); //오류메시지를 출력하고
			return null; //null값을 리턴한다
		}	
		return gongji; //해당 객체를 리턴한다
	}

	@Override
	public Gongji Write(Gongji gongji) { //사용자가 입력한 값들을 객체의 형태로 매개변수로 받아 db의 테이블에 입력해줌
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			// 데이터베이스와 통신하는데 사용되는 클래스를 호출한다
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo36", "root", "0000");
			// jdbc를 이용하여 mysql데이터베이스에 대한 연결을 설정한다
			Statement stmt = conn.createStatement();
			//데이터베이스에 대해 sql문을 실행하는데 사용할 statement객체를 생성한다
	
				int bunho = -1; //수정과 등록을 구분해주기 위해 정수형변수 bunho를 선언하고 -1값을 대입한다
				bunho = gongji.getBunho(); //매개변수로 받아온 객체에 값이 있으면 해당 객체의 bunho를 변수 bunho에 대입한다
				if(bunho == -1) { //글 등록
					stmt.execute("insert into gongji2 (title,date,content) values('"+gongji.getJemok()+"',date(now()),'"+gongji.getNaeyong()+"');");
					// gongji테이블에 해당 자료값을 입력해준다. 글 번호는 AUTO_INCREMENT로 자동생성된다
					ResultSet rsetmaxid = stmt.executeQuery("select max(id) from gongji2"); //등록된 글의 id를 구해준다
					int maxid = 0; //해당글 id를 담기 위한 정수형 변수 선언
					while(rsetmaxid.next()) {
						maxid = rsetmaxid.getInt(1); //변수에 대입
					}
					gongji.setBunho(maxid); //객체에 해당 글의 id 입력
				} else {	//글 수정
					stmt.executeUpdate("update gongji2 set title = '"+gongji.getJemok()+"', date = date(now()), content = '"+gongji.getNaeyong()+"' where id = "+ bunho +";");
					//해당 글번호를 가진 자료를 조회하여 제목과 내용을 수정해주고 글입력일자를 오늘로 바꿔준다
				}			
			stmt.close(); //Statement개체를 닫는다
			conn.close();	//데이터베이스 연결을 닫는다
		} catch (ClassNotFoundException | SQLException e) { //해당 오류가 발생하면
			e.printStackTrace(); //오류메시지를 출력하고
			return null; //null값을 리턴한다
		}	
		return gongji; //해당 글을 리턴한다
	}

	@Override
	public int delete(int bunho) { //글번호를 매개변수로 받아 db에서 글 삭제
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			// 데이터베이스와 통신하는데 사용되는 클래스를 호출한다
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo36", "root", "0000");
			// jdbc를 이용하여 mysql데이터베이스에 대한 연결을 설정한다
			Statement stmt = conn.createStatement();
			//데이터베이스에 대해 sql문을 실행하는데 사용할 statement객체를 생성한다
			stmt.executeUpdate("delete from gongji2 where id = "+bunho+";");
			// gongji에서 해당글번호의 댓글을 삭제하는 sql쿼리를 실행하고 결과를 ResultSet에 반환한다
			stmt.close(); //Statement개체를 닫는다
			conn.close();	//데이터베이스 연결을 닫는다
		} catch (ClassNotFoundException | SQLException e) { //해당 오류가 발생하면
			e.printStackTrace(); //오류메시지를 출력하고
			return -1; //null값을 리턴한다
		}	
		return bunho; //해당글번호를 리턴한다
	}

}
