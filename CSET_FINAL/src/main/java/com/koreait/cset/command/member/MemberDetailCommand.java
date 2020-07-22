package com.koreait.cset.command.member;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.cset.common.CsetCommand;
import com.koreait.cset.dao.MemberDAO;
import com.koreait.cset.dto.JoinVO;
import com.koreait.cset.dto.MemberDTO;

public class MemberDetailCommand implements CsetCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		int mNo = Integer.parseInt( request.getParameter("mNo"));		
		MemberDAO mDAO = sqlSession.getMapper(MemberDAO.class);
		
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		
		ArrayList<JoinVO> list = null;
		
		if( startDate != null || endDate != null ) {
			list = mDAO.memberOrderPeriod(mNo, startDate, endDate);
		} else {
			list = mDAO.memberOrderView(mNo);			
		}
		
		MemberDTO mDTO = mDAO.memberselectByNo(mNo);
		
		model.addAttribute("mDTO", mDTO);
		model.addAttribute("list", list);
	
	}

}
