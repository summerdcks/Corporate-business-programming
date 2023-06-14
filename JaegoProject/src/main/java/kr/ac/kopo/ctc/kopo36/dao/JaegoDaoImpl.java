package kr.ac.kopo.ctc.kopo36.dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import kr.ac.kopo.ctc.kopo36.domain.Jaego;
public class JaegoDaoImpl implements JaegoDao{
	@Override
	public List<Jaego> selectAll(int C, int cntPT) {
		//현재페이지번호와 페이지당 자료수를 매개변수로 받아 db의 테이블에서 해당 자료들을 조회하여 객체배열로 리턴하는 함수
		List<Jaego> jaegos = new ArrayList<>(); //객체배열 jaegos 생성
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			// 데이터베이스와 통신하는데 사용되는 클래스를 호출한다
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo36", "root", "0000");
			// jdbc를 이용하여 mysql데이터베이스에 대한 연결을 설정한다
			Statement stmt = conn.createStatement();
			//데이터베이스에 대해 sql문을 실행하는데 사용할 statement객체를 생성한다
			ResultSet rset = stmt.executeQuery("select * from Jaego order by id desc limit " + ((C-1)*cntPT) +","+ cntPT +";");
			// Jaego에서 해당 페이지의 자료를 역순으로 조회하는 sql쿼리를 실행하고 결과를 ResultSet에 반환한다
			while (rset.next()) { // 더이상 읽을 내용이 없을 때까지 한줄씩 읽어오기 반복
				Jaego jaego = new Jaego(); // Jaego형식의 객체 jaego 생성
				jaego.setItemNumber(rset.getString(2)); //rset의 1번째 인덱스의 정수값을 jaego의 ItemNumber 에 할당한다
				jaego.setItem(rset.getString(3)); //rset의 2번째 인덱스의 문자열을 jaego의 Item에 할당한다
				jaego.setInStock(rset.getInt(4));//rset의 3번째 인덱스의 문자열을 jaego의 InStock에 할당한다
				jaego.setItemRegisteredDate(rset.getString(5)); //rset의 4번째 인덱스의 문자열을 jaego의 ItemRegisteredDate에 할당한다
				jaego.setInvenRegisteredDate(rset.getString(6));//rset의 5번째 인덱스의 문자열을 jaego의 InvenRegisteredDate에 할당한다
				jaego.setExplanation(rset.getString(7));//rset의 6번째 인덱스의 문자열을 jaego의 Explanation에 할당한다
				jaego.setImageName(rset.getString(8));//rset의 7번째 인덱스의 문자열을 jaego의 ImageName에 할당한다
				jaegos.add(jaego); // 값이 담아진 jaego객체를 jaegos객체배열의 변수로 담아줌
			}
			rset.close(); //ResultSet개체를 닫는다
			stmt.close(); //Statement개체를 닫는다
			conn.close();	//데이터베이스 연결을 닫는다
		} catch (ClassNotFoundException | SQLException e) { //해당 오류가 발생하면
			e.printStackTrace(); //오류메시지를 출력하고
			return null; //null값을 리턴한다
		}	
		return jaegos;	//jaegos객체배열 리턴
	}

	@Override
	public Jaego OneView(String itemNumber) {	//재고번호를 파라미터로 받아 db에서 해당자료의 정보를 조회하고 Jaego객체로 리턴하는 함수
		Jaego jaego = new Jaego();
		jaego.setItem(null);
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			// 데이터베이스와 통신하는데 사용되는 클래스를 호출한다
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo36", "root", "0000");
			// jdbc를 이용하여 mysql데이터베이스에 대한 연결을 설정한다
			Statement stmt = conn.createStatement();
			//데이터베이스에 대해 sql문을 실행하는데 사용할 statement객체를 생성한다
			ResultSet rset = stmt.executeQuery("select * from Jaego where itemNumber = "+itemNumber+";");
			// Jaego에서 해당 재고번호의 자료를 조회하는 sql쿼리를 실행하고 결과를 ResultSet에 반환한다
			while (rset.next()) { // 더이상 읽을 내용이 없을 때까지 한줄씩 읽어오기 반복
				jaego.setItemNumber(rset.getString(2)); //rset의 1번째 인덱스의 정수값을 jaego의 ItemNumber 에 할당한다
				jaego.setItem(rset.getString(3)); //rset의 2번째 인덱스의 문자열을 jaego의 Item에 할당한다
				jaego.setInStock(rset.getInt(4));//rset의 3번째 인덱스의 문자열을 jaego의 InStock에 할당한다
				jaego.setItemRegisteredDate(rset.getString(5)); //rset의 4번째 인덱스의 문자열을 jaego의 ItemRegisteredDate에 할당한다
				jaego.setInvenRegisteredDate(rset.getString(6));//rset의 5번째 인덱스의 문자열을 jaego의 InvenRegisteredDate에 할당한다
				jaego.setExplanation(rset.getString(7));//rset의 6번째 인덱스의 문자열을 jaego의 Explanation에 할당한다
				jaego.setImageName(rset.getString(8));//rset의 7번째 인덱스의 문자열을 jaego의 ImageName에 할당한다
			}
			rset.close(); //ResultSet개체를 닫는다
			stmt.close(); //Statement개체를 닫는다
			conn.close();	//데이터베이스 연결을 닫는다
		} catch (ClassNotFoundException | SQLException e) { //해당 오류가 발생하면
			e.printStackTrace(); //오류메시지를 출력하고
			return null; //null값을 리턴한다
		}	
		return jaego; //재고 객체 리턴
	}

	@Override
	public String delete(String itemNumber) { //재고번호를 파라미터로 받아 db에서 해당자료를 삭제하고 정수를 리턴하는 함수
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			// 데이터베이스와 통신하는데 사용되는 클래스를 호출한다
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo36", "root", "0000");
			// jdbc를 이용하여 mysql데이터베이스에 대한 연결을 설정한다
			Statement stmt = conn.createStatement();
			//데이터베이스에 대해 sql문을 실행하는데 사용할 statement객체를 생성한다
			stmt.executeUpdate("delete from Jaego where itemNumber = "+itemNumber+";");
			// Jaego에서 재고번호의 자료를 삭제하는 sql쿼리를 실행
			stmt.close(); //Statement개체를 닫는다
			conn.close();	//데이터베이스 연결을 닫는다
		} catch (ClassNotFoundException | SQLException e) { //해당 오류가 발생하면
			e.printStackTrace(); //오류메시지를 출력하고
			return ""; //-1값을 리턴한다
		}	
		return itemNumber;	//해당 재고번호를 리턴
	}

	@Override
	public String write(Jaego jaego) { //jaego객체를 파라미터로 받아 db에 입력하고 문자열을 리턴하는 함수			
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			// 데이터베이스와 통신하는데 사용되는 클래스를 호출한다
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo36", "root", "0000");
			// jdbc를 이용하여 mysql데이터베이스에 대한 연결을 설정한다
			Statement stmt = conn.createStatement();
			//데이터베이스에 대해 sql문을 실행하는데 사용할 statement객체를 생성한다
			String value = jaego.getExplanation(); //jaego객체의 explanation을 문자열 변수 value에 대입
			if(value == null) { //해당 변수값이 null이면
				stmt.executeUpdate("update Jaego set inStock = "+jaego.getInStock()+", invenRegisteredDate = date(now()) where itemNumber = "+ jaego.getItemNumber() +";");
				//해당 재고번호의 자료를 수정해준다
			} else {	//해당 변수에 값이 있으면
				ResultSet rset = stmt.executeQuery("select count(*) from Jaego where itemNumber = "+jaego.getItemNumber()+";");
				//Jaego테이블에서 해당 재고번호를 가진 자료의 수를 조회한다
				int checkDuplicate = 0; //중복을 확인하기 위해 정수형 변수 선언하고 0으로 초기화
				while(rset.next()) {
					checkDuplicate = rset.getInt(1); //이미 존재하는 재고번호면 1 이상, 아니면 0을 해당 변수에 대입
				}
				if(checkDuplicate >= 1) { //1보다 크거나 같으면(중복이면)
					return "duplicate"; //해당 문자열을 리턴
				} else if(checkDuplicate == 0) { //0이면(중복이 아니면)
				stmt.execute("insert into Jaego (itemNumber, item, inStock, itemRegisteredDate, invenRegisteredDate, explanation, imageUrl) values("+jaego.getItemNumber()+", '"+jaego.getItem()+"', "+jaego.getInStock()+", date(now()), date(now()), '"+jaego.getExplanation()+"', '"+jaego.getImageName()+"');");
				//새로운 재고에 대한 정보를 입력한다
				}
			}
			stmt.close(); //Statement개체를 닫는다
			conn.close();	//데이터베이스 연결을 닫는다
		} catch (ClassNotFoundException | SQLException e) { //해당 오류가 발생하면
			return "error"; //해당 문자열을 리턴한다
		}	
		return "done"; //해당 문자열을 리턴한다
	}

}
