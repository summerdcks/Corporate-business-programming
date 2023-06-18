package kr.ac.kopo.ctc.kopo36.dao;

import java.util.List;

import kr.ac.kopo.ctc.kopo36.domain.StudentScore;

public interface StudentScoreDao {
	String createTable(); //테이블을 생성하고 문자열을 리턴하는 함수
	String dropTable(); //테이블을 삭제하고 문자열을 리턴하는 함수
	String insertAll(); //테이블에 모든 데이터를 입력하고 문자열을 리턴하는 함수
	StudentScore insert(StudentScore studentScore); //테이블에 특정학생의 데이터를 입력하고 객체를 리턴하는 함수
	StudentScore selectOne(int id); //테이블에 특정 학번을 가진 학생을 검색해서 보여주는 함수
	List<StudentScore> selectAll(int page, int countPerPage); 
	//현재페이지와 페이지당 데이터수를 입력하면 해당 페이지를 객체배열로 반환하는 함수
	StudentScore update(int id, StudentScore studentScore); //특정 학생의 정보를 수정하는 함수
	void delete(int id); //특정 학생의 정보를 삭제하는 함수

}
