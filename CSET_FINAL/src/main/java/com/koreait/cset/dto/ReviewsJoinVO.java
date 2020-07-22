package com.koreait.cset.dto;

import java.sql.Date;

public class ReviewsJoinVO {
	
	private int rNo, pNo, mNo, rRating;
	private String mId, pName, rContent, pFilename;
	private Date rRegdate;
	
	public ReviewsJoinVO() {}

	public ReviewsJoinVO(int rNo, int pNo, int mNo, int rRating, String mId, String pName, String rContent,
			String pFilename, Date rRegdate) {
		super();
		this.rNo = rNo;
		this.pNo = pNo;
		this.mNo = mNo;
		this.rRating = rRating;
		this.mId = mId;
		this.pName = pName;
		this.rContent = rContent;
		this.pFilename = pFilename;
		this.rRegdate = rRegdate;
	}

	public int getrNo() {
		return rNo;
	}

	public void setrNo(int rNo) {
		this.rNo = rNo;
	}

	public int getpNo() {
		return pNo;
	}

	public void setpNo(int pNo) {
		this.pNo = pNo;
	}

	public int getmNo() {
		return mNo;
	}

	public void setmNo(int mNo) {
		this.mNo = mNo;
	}

	public int getrRating() {
		return rRating;
	}

	public void setrRating(int rRating) {
		this.rRating = rRating;
	}

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}

	public String getpName() {
		return pName;
	}

	public void setpName(String pName) {
		this.pName = pName;
	}

	public String getrContent() {
		return rContent;
	}

	public void setrContent(String rContent) {
		this.rContent = rContent;
	}

	public String getpFilename() {
		return pFilename;
	}

	public void setpFilename(String pFilename) {
		this.pFilename = pFilename;
	}

	public Date getrRegdate() {
		return rRegdate;
	}

	public void setrRegdate(Date rRegdate) {
		this.rRegdate = rRegdate;
	}

	

}