package kr.ac.kopo.ctc.kopo36.domain;

public class Jaego {	//Jaego 클래스 선언
	private String itemNumber;	//정수형 변수 itemNumber 선언
	private String item;	//문자열 변수 item 선언
	private int inStock;	//정수형 변수 inStock 선언
	private String itemRegisteredDate;	//문자열 변수 itemRegisteredDate 선언
	private String invenRegisteredDate;	//문자열 변수 invenRegisteredDate 선언
	private String explanation;	//문자열 변수 explanation 선언
	private String imageName;	//문자열 변수 imageName 선언
	
	//getter와 setter를 이용하여 값을 입력하고 호출함
	public String getItemNumber() {
		return itemNumber;
	}
	public void setItemNumber(String itemNumber) {
		this.itemNumber = itemNumber;
	}
	public String getItem() {
		return item;
	}
	public void setItem(String item) {
		this.item = item;
	}
	public int getInStock() {
		return inStock;
	}
	public void setInStock(int inStock) {
		this.inStock = inStock;
	}
	public String getItemRegisteredDate() {
		return itemRegisteredDate;
	}
	public void setItemRegisteredDate(String itemRegisteredDate) {
		this.itemRegisteredDate = itemRegisteredDate;
	}
	public String getInvenRegisteredDate() {
		return invenRegisteredDate;
	}
	public void setInvenRegisteredDate(String invenRegisteredDate) {
		this.invenRegisteredDate = invenRegisteredDate;
	}
	public String getExplanation() {
		return explanation;
	}
	public void setExplanation(String explanation) {
		this.explanation = explanation;
	}
	public String getImageName() {
		return imageName;
	}
	public void setImageName(String imageName) {
		this.imageName = imageName;
	}	
}
