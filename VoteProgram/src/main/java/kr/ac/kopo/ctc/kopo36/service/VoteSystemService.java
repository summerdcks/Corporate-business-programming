package kr.ac.kopo.ctc.kopo36.service;

public interface VoteSystemService {
	int getAvailableKiho(); //새로 입력이 가능한 기호를 도출하는 함수
	int countAll();  //총투표수를 가져오는 함수
	int selectOne(int kiho, int age); //특정후보의 연령대별 득표수를 가져오기 위한 함수
	int countVotes(int kiho);  //특정후보의 총득표수를 가져오는 함수
}
