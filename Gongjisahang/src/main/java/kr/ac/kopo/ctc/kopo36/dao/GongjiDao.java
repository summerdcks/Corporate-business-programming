package kr.ac.kopo.ctc.kopo36.dao;

import java.util.List;
import kr.ac.kopo.ctc.kopo36.domain.Gongji;

public interface GongjiDao {
	String createInsertTable(); //db에 테이블을 생성하고 데이터를 입력함
	List<Gongji> selectAll(int pageNo, int cntPT); 
	//페이지넘버와 페이지당 출력할 자료의 수를 매개변수로 받아 해당 페이지의 자료값들을 객체배열로 리턴함
	Gongji OneView(int bunho);	//번호를 매개변수로 받아 해당 번호 글에 대한 정보값들을 리턴함
	Gongji Write(Gongji gongji); //사용자가 입력한 값들을 객체의 형태로 매개변수로 받아 db의 테이블에 입력해줌
	int delete(int bunho, int rootid, int recnt);	//글번호를 매개변수로 받아 db에서 글 삭제
	int getMaxRecnt(int rootid); //해당 원글의 마지막 순서를 찾는 함수
	int getMiddleRecnt(int rootid, int relevel, int recnt); //해당 원글번호에서 댓글이 중간에 들어갈 순서를 찾는 함수
}
