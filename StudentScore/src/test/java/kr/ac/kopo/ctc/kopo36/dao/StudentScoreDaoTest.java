package kr.ac.kopo.ctc.kopo36.dao;

import java.util.ArrayList;
import java.util.List;

import org.junit.jupiter.api.Test;

import kr.ac.kopo.ctc.kopo36.domain.StudentScore;
import kr.ac.kopo.ctc.kopo36.dto.pagination;


public class StudentScoreDaoTest {
	@Test
	void test_insert() {
		StudentScoreDao studentScoreDao = new StudentScoreDaoImpl();
		StudentScore studentScore = new StudentScore();
		studentScore.setId(-1);
		studentScore.setName("지은");
		studentScore.setStudentId(212011);
		studentScore.setKor(77);
		studentScore.setEng(66);
		studentScore.setMat(88);
		studentScoreDao.insert(studentScore);
	}
	
	@Test
	void test_selectOne() {
		StudentScoreDao studentScoreDao = new StudentScoreDaoImpl();
		StudentScore studentScore = new StudentScore();
		studentScore = studentScoreDao.selectOne(99);
		System.out.println(studentScore.getId());
		System.out.println(studentScore.getName());
		System.out.println(studentScore.getStudentId());
		System.out.println(studentScore.getKor());
		System.out.println(studentScore.getEng());
		System.out.println(studentScore.getMat());
	}
	
	@Test
	void test_selectAll() {
		StudentScoreDao studentScoreDao = new StudentScoreDaoImpl();
		List<StudentScore> studentScores = new ArrayList<>();
		StudentScore studentScoreF = new StudentScore();
		StudentScore studentScoreL = new StudentScore();
		studentScores = studentScoreDao.selectAll(2, 50);
		studentScoreF = studentScores.get(0);
		System.out.println(studentScoreF.getStudentId());
		studentScoreL = studentScores.get(49);
		System.out.println(studentScoreL.getStudentId());
	}
	
	@Test
	void test_update() {
		StudentScoreDao studentScoreDao = new StudentScoreDaoImpl();
		StudentScore studentScore = new StudentScore();
		studentScore.setId(-1);
		studentScore.setName("민수");
		studentScore.setStudentId(999998);
		studentScore.setKor(77);
		studentScore.setEng(66);
		studentScore.setMat(88);
		studentScoreDao.update(5, studentScore);
	}
	
	@Test
	void test_delete() {
		StudentScoreDao studentScoreDao = new StudentScoreDaoImpl();
		studentScoreDao.delete(10);
	}
	
	@Test
	void test_count() {
		StudentScoreDao studentScoreDao = new StudentScoreDaoImpl();
		studentScoreDao.count();
	}
	
}
