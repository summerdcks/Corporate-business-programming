package kr.ac.kopo.ctc.kopo36.domain;

public class StudentScore { //학생정보를 담아줄 StudentScore 클래스 생성
	private int id; //정수형 변수 id 선언
	private String name; //문자열형 변수 이름 선언
	private int studentId; //정수형 변수 학번 선언
	private int kor; //정수형 변수 국어점수 선언
	private int eng; //정수형 변수 영어점수 선언
	private int mat; //정수형 변수 수학점수 선언
	private int sum; //정수형 변수 합계 선언
	private int ave; //정수형 변수 평균 선언
	private int ran; //정수형 변수 등수 선언
	
	//setter와 getter를 이용하여 객체에 값을 넣고 꺼내준다
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getStudentId() {
		return studentId;
	}
	public void setStudentId(int studentId) {
		this.studentId = studentId;
	}
	public int getKor() {
		return kor;
	}
	public void setKor(int kor) {
		this.kor = kor;
	}
	public int getEng() {
		return eng;
	}
	public void setEng(int eng) {
		this.eng = eng;
	}
	public int getMat() {
		return mat;
	}
	public void setMat(int mat) {
		this.mat = mat;
	}
	public int getSum() {
		return sum;
	}
	public void setSum(int sum) {
		this.sum = sum;
	}
	public int getAve() {
		return ave;
	}
	public void setAve(int ave) {
		this.ave = ave;
	}
	public int getRan() {
		return ran;
	}
	public void setRan(int ran) {
		this.ran = ran;
	}	
}
