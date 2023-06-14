package kr.ac.kopo.ctc.kopo36.dao;

import java.util.List;
import kr.ac.kopo.ctc.kopo36.domain.Jaego;

public interface JaegoDao {
	List<Jaego> selectAll(int C, int cntPT);
	//현재페이지번호와 페이지당 자료수를 매개변수로 받아 db의 테이블에서 해당 자료들을 조회하여 객체배열로 리턴하는 함수
	Jaego OneView(String itemNumber);	//재고번호를 파라미터로 받아 db에서 해당자료의 정보를 조회하고 Jaego객체로 리턴하는 함수
	String delete(String itemNumber); //재고번호를 파라미터로 받아 db에서 해당자료를 삭제하고 정수를 리턴하는 함수
	String write(Jaego jaego); //jaego객체를 파라미터로 받아 db에 입력하고 문자열을 리턴하는 함수
}
