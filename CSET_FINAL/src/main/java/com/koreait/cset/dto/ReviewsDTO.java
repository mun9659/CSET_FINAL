package com.koreait.cset.dto;

import java.sql.Date;

public class ReviewsDTO {
	
	private int rNo;
	private int pNo; // Product Number
	private String mId; // Member Id
	private String rContent, rFilename, rPw;
	private Date rRegdate;
	private int rLike , rRating; // 좋아요 수(다른 고객), 별점(구매 고객)
	
	public ReviewsDTO() {}

	public ReviewsDTO(int rNo, int pNo, String mId, String rContent, String rFilename, String rPw, Date rRegdate,
			int rLike, int rRating) {
		super();
		this.rNo = rNo;
		this.pNo = pNo;
		this.mId = mId;
		this.rContent = rContent;
		this.rFilename = rFilename;
		this.rPw = rPw;
		this.rRegdate = rRegdate;
		this.rLike = rLike;
		this.rRating = rRating;
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

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}

	public String getrContent() {
		return rContent;
	}

	public void setrContent(String rContent) {
		this.rContent = rContent;
	}

	public String getrFilename() {
		return rFilename;
	}

	public void setrFilename(String rFilename) {
		this.rFilename = rFilename;
	}

	public String getrPw() {
		return rPw;
	}

	public void setrPw(String rPw) {
		this.rPw = rPw;
	}

	public Date getrRegdate() {
		return rRegdate;
	}

	public void setrRegdate(Date rRegdate) {
		this.rRegdate = rRegdate;
	}

	public int getrLike() {
		return rLike;
	}

	public void setrLike(int rLike) {
		this.rLike = rLike;
	}

	public int getrRating() {
		return rRating;
	}

	public void setrRating(int rRating) {
		this.rRating = rRating;
	}

	
	
}
