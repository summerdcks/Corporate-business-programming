package kr.ac.kopo.ctc.kopo36.service;

import kr.ac.kopo.ctc.kopo36.dto.pagination;

public interface JaegoService {
	public pagination getPagination(int page, int countPerPage);
	//현재페이지와 페이지당 자료수를 입력하면 페이지버튼값을 리턴하는 함수
	int count(); //총 자료수를 리턴하는 함수
	int currentPageNumber(String bunho, int countPerPage);
	 //특정재고번호와 페이지당 자료수를 입력하면 해당재고가 있는 페이지를 리턴하는 함수
}
