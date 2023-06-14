package kr.ac.kopo.ctc.kopo36.dao;

import java.util.List;
import kr.ac.kopo.ctc.kopo36.domain.Vote;

public interface VoteSystemDao {
	List<Vote> selectAll(); //hubo테이블의 모든 후보자에 대한 기호-이름 정보를 가져오기 위한 함수
	int deleteHubo(int kiho); //기호를 매개변수로 받아 특정 후보를 후보테이블에서 삭제하는 함수
	int deleteHuboTupyo(int kiho);
	//득표한 후보는 투표테이블에서 foreign key로 잡혀있어 후보테이블에서 삭제가 불가능하므로 투표,후보테이블에서 모두 삭제하는 함수
	String insertIntoHubo(String name); //이름을 매개변수로 받아 새로운 후보를 후보테이블에 입력하는 함수
	int insertIntoTupyo(int kiho, int age); //기호와 연령대를 매개변수로 받아 투표테이블에 투표하는 함수
}
