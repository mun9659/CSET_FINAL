package com.koreait.cset.dto;

import java.sql.Date;

public class JoinVO {

	private String pName,pFilename,mId,mName;
	private int oPrice,oAmount,oNo,nNo ,pNo;
	private Date oDate;
	
	public JoinVO(String pName, String pFilename, String mId, String mName, int oPrice, int oAmount, int oNo, int nNo,
			int pNo, Date oDate) {
		super();
		this.pName = pName;
		this.pFilename = pFilename;
		this.mId = mId;
		this.mName = mName;
		this.oPrice = oPrice;
		this.oAmount = oAmount;
		this.oNo = oNo;
		this.nNo = nNo;
		this.pNo = pNo;
		this.oDate = oDate;
	}
	public JoinVO() {
		// TODO Auto-generated constructor stub
	}
	public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}
	public String getpFilename() {
		return pFilename;
	}
	public void setpFilename(String pFilename) {
		this.pFilename = pFilename;
	}
	public String getmId() {
		return mId;
	}
	public void setmId(String mId) {
		this.mId = mId;
	}
	public String getmName() {
		return mName;
	}
	public void setmName(String mName) {
		this.mName = mName;
	}
	public int getoPrice() {
		return oPrice;
	}
	public void setoPrice(int oPrice) {
		this.oPrice = oPrice;
	}
	public int getoAmount() {
		return oAmount;
	}
	public void setoAmount(int oAmount) {
		this.oAmount = oAmount;
	}
	public int getoNo() {
		return oNo;
	}
	public void setoNo(int oNo) {
		this.oNo = oNo;
	}
	public int getnNo() {
		return nNo;
	}
	public void setnNo(int nNo) {
		this.nNo = nNo;
	}
	public int getpNo() {
		return pNo;
	}
	public void setpNo(int pNo) {
		this.pNo = pNo;
	}
	public Date getoDate() {
		return oDate;
	}
	public void setoDate(Date oDate) {
		this.oDate = oDate;
	}
	
	


		
}
