package com.koreait.cset.command.member;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.cset.common.CsetCommand;
import com.koreait.cset.dao.MemberDAO;
import com.koreait.cset.dao.OrderDAO;
import com.koreait.cset.dto.JoinVO;

public class MemberOrderView implements CsetCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		
		int mNo = Integer.parseInt(request.getParameter("mNo"));
		String mId = request.getParameter("mId");
		MemberDAO mDAO = sqlSession.getMapper(MemberDAO.class);
		OrderDAO oDAO = sqlSession.getMapper(OrderDAO.class);
		ArrayList<JoinVO> list = mDAO.memberOrderView(mNo);
		
		int totalPrice = oDAO.orderSumMoney(mId);
		
		
		model.addAttribute("list", list);
		model.addAttribute("totalPrice", totalPrice);
		
		
		
	}

}
