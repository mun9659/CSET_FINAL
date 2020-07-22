package com.koreait.cset.dto;

public class CartDTO {
	
	private int cNo, pNo, cAmount; // 카트 번호, 상품 번호, 상품 수량
	private String mId, cSize; // 회원 아이디
	
	public CartDTO() {	}

	public CartDTO(int cNo, int pNo, int cAmount, String mId, String cSize) {
		super();
		this.cNo = cNo;
		this.pNo = pNo;
		this.cAmount = cAmount;
		this.mId = mId;
		this.cSize = cSize;
	}

	public int getcNo() {
		return cNo;
	}

	public void setcNo(int cNo) {
		this.cNo = cNo;
	}

	public int getpNo() {
		return pNo;
	}

	public void setpNo(int pNo) {
		this.pNo = pNo;
	}

	public int getcAmount() {
		return cAmount;
	}

	public void setcAmount(int cAmount) {
		this.cAmount = cAmount;
	}

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}

	public String getcSize() {
		return cSize;
	}

	public void setcSize(String cSize) {
		this.cSize = cSize;
	}
	
}
