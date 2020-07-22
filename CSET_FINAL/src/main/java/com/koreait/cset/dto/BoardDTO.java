package com.koreait.cset.dto;

import java.sql.Date;

public class BoardDTO {
	
	// Fields
	private int bNo, bHit, bRef, bStep, bDepth, bClass;
	private String mId, bTitle, bContent, bPw, bFilename; 
	private Date bRegdate;
	
	
	// Constructors
	public BoardDTO() {
		// TODO Auto-generated constructor stub
	}

	public BoardDTO(int bNo, int bHit, int bRef, int bStep, int bDepth, int bClass, String mId,
			String bTitle, String bContent, String bPw, String bFilename, Date bRegdate) {
		super();
		this.bNo = bNo;
		this.bHit = bHit;
		this.bRef = bRef;
		this.bStep = bStep;
		this.bDepth = bDepth;
		this.bClass = bClass;
		this.mId = mId;
		this.bTitle = bTitle;
		this.bContent = bContent;
		this.bPw = bPw;
		this.bFilename = bFilename;
		this.bRegdate = bRegdate;
	}


	
	// Methods
	public int getbNo() {
		return bNo;
	}


	public void setbNo(int bNo) {
		this.bNo = bNo;
	}


	public int getbHit() {
		return bHit;
	}


	public void setbHit(int bHit) {
		this.bHit = bHit;
	}


	public int getbStep() {
		return bStep;
	}


	public void setbStep(int bStep) {
		this.bStep = bStep;
	}


	public int getbDepth() {
		return bDepth;
	}


	public void setbDepth(int bDepth) {
		this.bDepth = bDepth;
	}


	public int getbClass() {
		return bClass;
	}


	public void setbClass(int bClass) {
		this.bClass = bClass;
	}


	public String getmId() {
		return mId;
	}


	public void setmId(String mId) {
		this.mId = mId;
	}


	public String getbTitle() {
		return bTitle;
	}


	public void setbTitle(String bTitle) {
		this.bTitle = bTitle;
	}


	public String getbContent() {
		return bContent;
	}


	public void setbContent(String bContent) {
		this.bContent = bContent;
	}


	public String getbPw() {
		return bPw;
	}


	public void setbPw(String bPw) {
		this.bPw = bPw;
	}

	public Date getbRegdate() {
		return bRegdate;
	}

	public void setbRegdate(Date bRegdate) {
		this.bRegdate = bRegdate;
	}

	public int getbRef() {
		return bRef;
	}

	public void setbRef(int bRef) {
		this.bRef = bRef;
	}

	public String getbFilename() {
		return bFilename;
	}

	public void setbFilename(String bFilename) {
		this.bFilename = bFilename;
	}	
	
	

}
