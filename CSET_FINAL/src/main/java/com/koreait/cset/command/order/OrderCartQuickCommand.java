package com.koreait.cset.command.order;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.cset.common.CsetCommand;
import com.koreait.cset.dao.CartDAO;
import com.koreait.cset.dto.CartJoinVO;

public class OrderCartQuickCommand implements CsetCommand {
	
	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		
		int cNo = Integer.parseInt(request.getParameter("cNo"));
		
		CartJoinVO cJVO = new CartJoinVO();
		CartDAO cDAO = sqlSession.getMapper(CartDAO.class);
		
		cJVO = cDAO.selectCartBycNo(cNo);
		
		int total_price = (cJVO.getpPrice() * cJVO.getcAmount() * (1-(cJVO.getpDisrate()/100))); // 상품 번호의 값
		int fee = total_price >= 100000 ? 0 : 3000;
		
		List<CartJoinVO> cjList = new ArrayList<CartJoinVO>();
		
		cjList.add(cJVO);
		
		model.addAttribute("cjList", cjList);
		model.addAttribute("total_price", total_price);
		model.addAttribute("fee", fee);
	}
}
