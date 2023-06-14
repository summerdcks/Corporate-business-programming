package kr.ac.kopo.ctc.kopo36.domain;

public class Gongji { //공지사항 클래스
	private int bunho; //글번호
	private String jemok; //제목
	private String ilja; //등록일
	private String naeyong; //내용
	private int rootid; //원글 번호
	private int relevel; //댓글 레벨
	private int recnt; //표시 순서
	private int viewcnt; //조회수
	
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
	public int getRootid() {
		return rootid;
	}
	public void setRootid(int rootid) {
		this.rootid = rootid;
	}
	public int getRelevel() {
		return relevel;
	}
	public void setRelevel(int relevel) {
		this.relevel = relevel;
	}
	public int getRecnt() {
		return recnt;
	}
	public void setRecnt(int recnt) {
		this.recnt = recnt;
	}
	public int getViewcnt() {
		return viewcnt;
	}
	public void setViewcnt(int viewcnt) {
		this.viewcnt = viewcnt;
	}
	
}
