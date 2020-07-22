package com.koreait.cset.command.member;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.cset.common.CsetCommand;
import com.koreait.cset.dao.MemberDAO;
import com.koreait.cset.dto.JoinVO;

public class MemberOrderPeriodViewCommand implements CsetCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		
		
		int mNo = Integer.parseInt(request.getParameter("mNo"));
	
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		MemberDAO mDAO = sqlSession.getMapper(MemberDAO.class);

		ArrayList<JoinVO> list = mDAO.memberOrderPeriod(mNo, startDate, endDate);
		
		
		
		
		model.addAttribute("list", list);

	}

}
