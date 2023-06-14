package kr.ac.kopo.ctc.kopo36.dto;

public class pagination { //페이지버튼을 출력해주기 위한 pagination 클래스 선언
	private int c; //현재페이지
	private int s; //현재 목록의 첫번째페이지 버튼
	private int e; //현재 목록의 마지막페이지 버튼
	private int p; //이전페이지로 이동하는 버튼
	private int pp; //첫페이지로 이동하는 버튼
	private int n; //다음페이지로 이동하는 버튼
	private int nn; //마지막페이지로 이동하는 버튼
	
	//setter와 getter를 이용하여 객체에 값을 넣고 꺼내준다
	public int getC() {
		return c;
	}
	public void setC(int c) {
		this.c = c;
	}
	public int getS() {
		return s;
	}
	public void setS(int s) {
		this.s = s;
	}
	public int getE() {
		return e;
	}
	public void setE(int e) {
		this.e = e;
	}
	public int getP() {
		return p;
	}
	public void setP(int p) {
		this.p = p;
	}
	public int getPp() {
		return pp;
	}
	public void setPp(int pp) {
		this.pp = pp;
	}
	public int getN() {
		return n;
	}
	public void setN(int n) {
		this.n = n;
	}
	public int getNn() {
		return nn;
	}
	public void setNn(int nn) {
		this.nn = nn;
	}
	
}
