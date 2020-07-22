package com.koreait.cset.dao;

import com.koreait.cset.dto.OrderDTO;

public interface OrderDAO {
	
	// 1. 주문 입력 ()
	public int orderInsert(OrderDTO oDTO);
	
	// 2. 주문 리스트 총액
	public int orderSumMoney(String mId);
	
	// 3. 주문 취소 시 주문 리스트 삭제
	public void orderListDelete(String mId);
	
	// 4-1. 주문 완료 시 회원의 총 포인트 변경(포인트 사용시)
	public void memberUpdateMinusmPoint(int usemPoint, int mNo);
	
	// 4-2. 주문 완료 시 회원의 총 포인트 변경(포인트 미사용시)
	public void memberUpdatePlusmPoint(int addmPoint, int mNo);
	
	// 5. 주문 완료 시 회원의 등급 변경
	public void memberUpdatemGrade(String mId, char afterGrade);
	
	// 6. 주문 완료 후 장바구니 클리어
	public void cartClearCommand(String mId);
	
	// 7. 주문 완료 후 재고에서 수량 감소
	public void stockMinusUpdate(int pNo, String oSize, int oAmount);
	
	
}

