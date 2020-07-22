package com.koreait.cset.command.board;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.cset.common.CsetCommand;
import com.koreait.cset.dao.BoardDAO;
import com.koreait.cset.dto.BoardDTO;

public class FaqBoardListCommand implements CsetCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		BoardDAO bDAO = sqlSession.getMapper( BoardDAO.class );
		
		ArrayList<BoardDTO> bList = bDAO.faqSelectList();
		
		model.addAttribute( "bList", bList );

	}

}
