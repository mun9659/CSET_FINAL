package com.koreait.cset.dao;

public interface StockDAO {
	
	// 1. 재고와 상품 구매 수량과 비교
	public int stockSelectBypNopSize(int pNo, String pSize);
 	
}
