package com.koreait.cset.command.member;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.cset.common.CsetCommand;
import com.koreait.cset.dao.MemberDAO;
import com.koreait.cset.dto.MemberDTO;

public class MemberChangeCommand implements CsetCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		
		int mNo = Integer.parseInt(request.getParameter("mNo"));
		String mName = request.getParameter("mName");
		String mEmail = request.getParameter("mEmail");
		String mPhone = request.getParameter("mPhone");
		String mAddr = request.getParameter("mAddr");
		
		String mPw = request.getParameter("mPw");
		String mId = request.getParameter("mId");
		
		MemberDAO mDAO = sqlSession.getMapper(MemberDAO.class);
		
		mDAO.memberChange( mName, mEmail, mPhone, mAddr,mNo);
		
		//수정내역 0713
		MemberDTO mDTO = new MemberDTO();
		mDTO.setmId(mId);
		mDTO.setmPw(mPw);
		HttpSession session = null;
		MemberDTO loginDTO =mDAO.selectBymIdmPw(mDTO);
		session = request.getSession();
		session.setAttribute("loginDTO", loginDTO);
		model.addAttribute("loginDTO",loginDTO);
	}

}
