package com.koreait.cset.dao;

import java.util.List;

import com.koreait.cset.dto.CartDTO;
import com.koreait.cset.dto.CartJoinVO;

public interface CartDAO {
	
	// 1. 장바구니 목록 (clear)
	public List<CartJoinVO> cartListPage(String mId); 
	
	// 2. 장바구니 추가 (not)
	public void cartInsert(CartDTO cDTO);
	
	// 3. 장바구니 개별 삭제 (clear)
    public void cartDelete(int cNo); 
    
    // 4. 장바구니 비우기 (clear)
    public void cartDeleteSelect(int cNo); 
    
    // 5. 장바구니 수량 수정 ( + / - )
    public void cartAmountPlus(int cNo, int cAmount); 
    
    public void cartAmountMinus(int cNo, int cAmount); 
    
    // 6. 장바구니 금액 합계 (clear)
    public int cartSumMoney(String mId);
	
    // 7. 장바구니 가져오기
 	public CartJoinVO selectCartBycNo(int cNo);
 	
 	// 8. 취소하면 카트 목록 지우기(mId 로 특정)
 	public void cartAllDelete(String mId);
 	
}
