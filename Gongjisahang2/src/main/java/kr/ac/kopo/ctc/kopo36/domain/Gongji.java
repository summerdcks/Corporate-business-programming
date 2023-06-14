package kr.ac.kopo.ctc.kopo36.domain;

public class Gongji { //공지사항 클래스
	private int bunho; //글번호
	private String jemok; //제목
	private String ilja; //등록일
	private String naeyong; //내용
	
	//getter와 setter를 사용하여 해당값들을 입력하고 꺼내준다
	public int getBunho() {
		return bunho;
	}
	public void setBunho(int bunho) {
		this.bunho = bunho;
	}
	public String getJemok() {
		return jemok;
	}
	public void setJemok(String jemok) {
		this.jemok = jemok;
	}
	public String getIlja() {
		return ilja;
	}
	public void setIlja(String ilja) {
		this.ilja = ilja;
	}
	public String getNaeyong() {
		return naeyong;
	}
	public void setNaeyong(String naeyong) {
		this.naeyong = naeyong;
	}
	
}
