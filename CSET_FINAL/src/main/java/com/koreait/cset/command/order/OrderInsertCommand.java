package com.koreait.cset.command.order;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.cset.common.CsetCommand;
import com.koreait.cset.dao.MemberDAO;
import com.koreait.cset.dao.OrderDAO;
import com.koreait.cset.dto.MemberDTO;
import com.koreait.cset.dto.OrderDTO;

public class OrderInsertCommand implements CsetCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {

		// int mNo, int pNo, int oAmount, String oAddr, String oPhone, int oPayment, int oPrice
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		HttpSession session = request.getSession();
		OrderDAO oDAO = sqlSession.getMapper(OrderDAO.class);
		OrderDTO oDTO = new OrderDTO();
		MemberDAO mDAO = sqlSession.getMapper(MemberDAO.class);
		MemberDTO loginDTO = (MemberDTO) session.getAttribute("loginDTO");
		
		String mId = loginDTO.getmId();
		int mNo = loginDTO.getmNo();
		String[] pNoArr = request.getParameterValues("pNo");
		String[] oSizeArr = request.getParameterValues("oSize");
		String[] oAmountArr = request.getParameterValues("oAmount");
		String[] oPriceArr = request.getParameterValues("oPrice");
		String oPhone = request.getParameter("rPhone"); // 수령인 전화번호
		String oAddr = request.getParameter("rAddr"); // 수령인 주소
		int selectNote = Integer.parseInt(request.getParameter("selectNote"));  // 주문 메모 번호
		String selectNoteDirect = request.getParameter("selectNoteDirect");  // 직접 입력한 주문 메모
		// int total_price = Integer.parseInt(request.getParameter("total_price"));
		int total_price = 0;
		String oNote = "";  // 주문 메모
		
		int mPoint = loginDTO.getmPoint();
				
		switch(selectNote) {
		case 1: oNote += "부재시 경비(관리)실에 맡겨주세요"; break;
		case 2: oNote += "부재시 문앞에 놓아주세요"; break;
		case 3: oNote += "직접 받겠습니다"; break;
		case 4: oNote += "배송전에 연락해주세요"; break;
		case 5: oNote += selectNoteDirect; break;
		}
		
		for (int i = 0; i < pNoArr.length; i++) {
			int pNo = Integer.parseInt(pNoArr[i]);
			String oSize = oSizeArr[i];
			int oAmount = Integer.parseInt(oAmountArr[i]);
			int oPrice = Integer.parseInt(oPriceArr[i]);
			
			oDTO.setmNo(mNo);
			oDTO.setpNo(pNo);
			oDTO.setoAmount(oAmount);
			oDTO.setoAddr(oAddr);
			oDTO.setoPhone(oPhone);
			oDTO.setoNote(oNote);
			oDTO.setoPrice(oPrice);
			oDTO.setoSize(oSize);
			
			/* 구매 완료 후 주문 DB에 저장 */
			oDAO.orderInsert(oDTO);
			
			/* 구매가 완료되면 재고에서 구매한 수량을 뺀다. */
			oDAO.stockMinusUpdate(pNo, oSize, oAmount);
			
			/* 만약 상품 재고를 뺀 나머지가 들어온다면 total_price의 값이 변동 */
			total_price += oPrice;
		}
		
		/* 포인트를 사용 했을 시 필요한 것들 */
		String usemPointStr = request.getParameter("usemPoint");
		if( usemPointStr == null || usemPointStr.isEmpty() ) {
			usemPointStr = "0";
		}
		int usemPoint = Integer.parseInt(usemPointStr); // 사용된 포인트
		
		/* 포인트 미사용시 포인트 적립 */
		if(usemPoint == 0) {
			
			int addmPoint = (int) (total_price * 0.02);
			addmPoint = Math.round(addmPoint / 10) * 10;
			oDAO.memberUpdatePlusmPoint(addmPoint, mNo);
		}
		/* 포인트 사용시 포인트 차감 */
		oDAO.memberUpdateMinusmPoint(usemPoint, mNo);
		
		/* 상품 구매시 누적금액에 따라 변동되는 mGrade */
		int totaloPrice = oDAO.orderSumMoney(mId);
		char afterGrade;
		
		if(totaloPrice < 100000) {
			afterGrade ='D';
			oDAO.memberUpdatemGrade(mId, afterGrade);
		}else if(totaloPrice < 400000) {
			afterGrade ='C';
			oDAO.memberUpdatemGrade(mId, afterGrade);
		}else if(totaloPrice < 700000) {
			afterGrade ='B';
			oDAO.memberUpdatemGrade(mId, afterGrade);
		}else {
			afterGrade ='A';
			oDAO.memberUpdatemGrade(mId, afterGrade);
		}
		
		/* 구매가 완료되면 장바구니에 있는 것을 지운다. */
		oDAO.cartClearCommand(mId);
		
		model.addAttribute("mPoint", mPoint); // 사용되기 전 포인트 resultPage에 보여주기
		
		/* 로그인 한 것을 새로고침한다. */
		loginDTO = mDAO.selectBymIdmPw(loginDTO);
		int totalPrice = oDAO.orderSumMoney(mId); // 지금까지 산 상품 구매값 세션에 저장
		

		// 현재 등급, 다음 등급까지 남은 액수 표시하기 위한 정보
		int gradeChangeLimit = 100000;	
		
		char nextGrade;
		if(totalPrice<100000) {
			nextGrade ='C';
			gradeChangeLimit = 100000;
		}else if(totalPrice<400000) {
			nextGrade ='B';
			gradeChangeLimit = 400000;
		}else if(totalPrice<700000) {
			nextGrade ='A';
			gradeChangeLimit = 700000;
		}else {
			nextGrade ='A';
			gradeChangeLimit = 1000000;
		}
		
		
		session.setAttribute("loginDTO", loginDTO);
		session.setAttribute("totalPrice", totalPrice);
		session.setAttribute("nextGrade", nextGrade);
		session.setAttribute("gradeChangeLimit", gradeChangeLimit);
		
		model.addAttribute("usemPoint", usemPoint);
		model.addAttribute("total_price", total_price);		
		model.addAttribute("afterGrade", afterGrade);  // 변화된 등급

		
	}
}