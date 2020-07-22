package com.koreait.cset.dto;

public class ProductsDTO {
	private int pNo, pPrice, pDisrate;
	private double pRating;
	private String pName, pFilename, pCategory, pCategory_sub, pBrand;

	public ProductsDTO() {
		// TODO Auto-generated constructor stub
	}

	public ProductsDTO(int pNo, int pPrice, int pDisrate, double pRating, String pName, String pFilename,
			String pCategory, String pCategory_sub, String pBrand) {
		super();
		this.pNo = pNo;
		this.pPrice = pPrice;
		this.pDisrate = pDisrate;
		this.pRating = pRating;
		this.pName = pName;
		this.pFilename = pFilename;
		this.pCategory = pCategory;
		this.pCategory_sub = pCategory_sub;
		this.pBrand = pBrand;
	}

	public int getpNo() {
		return pNo;
	}

	public void setpNo(int pNo) {
		this.pNo = pNo;
	}

	public int getpPrice() {
		return pPrice;
	}

	public void setpPrice(int pPrice) {
		this.pPrice = pPrice;
	}

	public int getpDisrate() {
		return pDisrate;
	}

	public void setpDisrate(int pDisrate) {
		this.pDisrate = pDisrate;
	}

	public double getpRating() {
		return pRating;
	}

	public void setpRating(double pRating) {
		this.pRating = pRating;
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

	public String getpCategory() {
		return pCategory;
	}

	public void setpCategory(String pCategory) {
		this.pCategory = pCategory;
	}

	public String getpCategory_sub() {
		return pCategory_sub;
	}

	public void setpCategory_sub(String pCategory_sub) {
		this.pCategory_sub = pCategory_sub;
	}

	public String getpBrand() {
		return pBrand;
	}

	public void setpBrand(String pBrand) {
		this.pBrand = pBrand;
	}
}
