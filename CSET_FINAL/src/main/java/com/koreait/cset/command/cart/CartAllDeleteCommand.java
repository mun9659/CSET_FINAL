package com.koreait.cset.command.cart;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.cset.common.CsetCommand;
import com.koreait.cset.dao.CartDAO;
import com.koreait.cset.dto.MemberDTO;

public class CartAllDeleteCommand implements CsetCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		HttpSession session = request.getSession();
		MemberDTO loginDTO = (MemberDTO) session.getAttribute("loginDTO");
		String mId = loginDTO.getmId();
		
		CartDAO cDAO = sqlSession.getMapper(CartDAO.class);
		
		cDAO.cartAllDelete(mId);
	}

}
