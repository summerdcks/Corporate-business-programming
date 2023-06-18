package kr.ac.kopo.ctc.kopo36.domain;

public class Vote { //후보테이블의 정보를 가지고올 vote클래스 생성
	private int kiho; //정수형 변수 kiho 선언
	private String name; //문자열형 변수 name 선언
	
	//getter와 setter를 이용하여 값을 입력받고 내보내준다
	public int getKiho() {
		return kiho;
	}
	public void setKiho(int kiho) {
		this.kiho = kiho;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
