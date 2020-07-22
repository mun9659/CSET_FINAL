package com.koreait.cset.dto;

import java.sql.Date;

public class MemberDTO {

	private String mSno,mId,mName,mPw,mAddr,mEmail,mPhone;
	private int mNo,mPno,mPayment,mPoint;
	private char mGrade;
	private Date mRegdate;
	public MemberDTO() {
		// TODO Auto-generated constructor stub
	}
	public MemberDTO(String mSno, String mId, String mName, String mPw, String mAddr, String mEmail, String mPhone,
			int mNo, int mPno, int mPayment, int mPoint, char mGrade, Date mRegdate) {
		super();
		this.mSno = mSno;
		this.mId = mId;
		this.mName = mName;
		this.mPw = mPw;
		this.mAddr = mAddr;
		this.mEmail = mEmail;
		this.mPhone = mPhone;
		this.mNo = mNo;
		this.mPno = mPno;
		this.mPayment = mPayment;
		this.mPoint = mPoint;
		this.mGrade = mGrade;
		this.mRegdate = mRegdate;
	}
	
	// -----------------------------------------------
	public String getmSno() {
		return mSno;
	}
	public void setmSno(String mSno) {
		this.mSno = mSno;
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
	public String getmPw() {
		return mPw;
	}
	public void setmPw(String mPw) {
		this.mPw = mPw;
	}
	public String getmAddr() {
		return mAddr;
	}
	public void setmAddr(String mAddr) {
		this.mAddr = mAddr;
	}
	public String getmEmail() {
		return mEmail;
	}
	public void setmEmail(String mEmail) {
		this.mEmail = mEmail;
	}
	public String getmPhone() {
		return mPhone;
	}
	public void setmPhone(String mPhone) {
		this.mPhone = mPhone;
	}
	public int getmNo() {
		return mNo;
	}
	public void setmNo(int mNo) {
		this.mNo = mNo;
	}
	public int getmPno() {
		return mPno;
	}
	public void setmPno(int mPno) {
		this.mPno = mPno;
	}
	public int getmPayment() {
		return mPayment;
	}
	public void setmPayment(int mPayment) {
		this.mPayment = mPayment;
	}
	public int getmPoint() {
		return mPoint;
	}
	public void setmPoint(int mPoint) {
		this.mPoint = mPoint;
	}
	public char getmGrade() {
		return mGrade;
	}
	public void setmGrade(char mGrade) {
		this.mGrade = mGrade;
	}
	public Date getmRegdate() {
		return mRegdate;
	}
	public void setmRegdate(Date mRegdate) {
		this.mRegdate = mRegdate;
	}
	
	
}
