package com.koreait.cset.command.member;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.cset.common.CsetCommand;
import com.koreait.cset.dao.MemberDAO;

public class MemberInsertCommand implements CsetCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		
		String mSno1 = request.getParameter("mSno1");
		String mSno2 = request.getParameter("mSno2");
		String mSno = mSno1+"-"+mSno2;
		
		String mId = request.getParameter("mId");
		String mName = request.getParameter("mName");
		String mPw = request.getParameter("mPw");
		String mAddr = request.getParameter("mAddr");
		String mEmail = request.getParameter("mEmail");
		String mPhone = request.getParameter("mPhone");
		int mPno =Integer.parseInt(request.getParameter("mPno"));
		
		 
		String mAddr1 = request.getParameter("mAddr1");
		String mAddr2 = request.getParameter("mAddr2");
		
		mAddr="".concat(mAddr1).concat(mAddr2)+" ".concat(mAddr);
		
		
		MemberDAO mDAO = sqlSession.getMapper(MemberDAO.class);
		
		mDAO.memberInsert(mSno, mId, mName, mPw, mAddr,mPno, mEmail, mPhone);

	}

}
