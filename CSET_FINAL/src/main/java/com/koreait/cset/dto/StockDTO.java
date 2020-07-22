package com.koreait.cset.dto;

public class StockDTO {
	private int sNo,pNo,sAmount;
	private String pSize;
	public StockDTO() {
		// TODO Auto-generated constructor stub
	}
	public StockDTO(int sNo, int pNo, int sAmount, String pSize) {
		super();
		this.sNo = sNo;
		this.pNo = pNo;
		this.sAmount = sAmount;
		this.pSize = pSize;
	}
	public int getsNo() {
		return sNo;
	}
	public void setsNo(int sNo) {
		this.sNo = sNo;
	}
	public int getpNo() {
		return pNo;
	}
	public void setpNo(int pNo) {
		this.pNo = pNo;
	}
	public int getsAmount() {
		return sAmount;
	}
	public void setsAmount(int sAmount) {
		this.sAmount = sAmount;
	}
	public String getpSize() {
		return pSize;
	}
	public void setpSize(String pSize) {
		this.pSize = pSize;
	}
	
	
}
