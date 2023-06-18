package kr.ac.kopo.ctc.kopo36.service;

import kr.ac.kopo.ctc.kopo36.dto.pagination;

public interface StudentScoreService {
	pagination getPagination(int page, int countPerPage);
	//현재페이지와 페이지당 자료수를 입력하면 페이지버튼값을 리턴하는 함수
	int count(); //전체자료수를 리턴하는 함수
	int currentPageNumber(int id, int countPerPage);
	//특정학번과 페이지당 자료수를 입력하면 해당학번이 있는 페이지를 리턴하는 함수
	int countVisitor(); //방문자수를 세어주는 함수
}