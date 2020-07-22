package com.koreait.cset.command.member;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.cset.common.CsetCommand;
import com.koreait.cset.dao.MemberDAO;
import com.koreait.cset.dto.MemberDTO;

public class MemberQueryCommand implements CsetCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
		MemberDAO mDAO = sqlSession.getMapper( MemberDAO.class );
		
		String query = request.getParameter("member-query");
		
		ArrayList<MemberDTO> list =  mDAO.memberSelectByQuery(query);
		model.addAttribute( "list", list );
		
		

	}

}
