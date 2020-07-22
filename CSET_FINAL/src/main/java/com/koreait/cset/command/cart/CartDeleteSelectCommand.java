package com.koreait.cset.command.cart;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.cset.common.CsetCommand;
import com.koreait.cset.dao.CartDAO;
import com.koreait.cset.dto.CartDTO;
import com.koreait.cset.dto.MemberDTO;

public class CartDeleteSelectCommand implements CsetCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		
		List<Integer> chArr = (List<Integer>) map.get("chArr"); // 체크된 카트번호 리스트
		CartDTO cDTO = new CartDTO();
		CartDAO cDAO = sqlSession.getMapper(CartDAO.class);
		int cNo = 0;
		
		for (int i : chArr) {
			cNo = i;
			cDAO.cartDeleteSelect(cNo);
		}
	}

}
