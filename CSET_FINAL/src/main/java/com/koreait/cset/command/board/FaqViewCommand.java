package com.koreait.cset.command.board;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.cset.common.CsetCommand;
import com.koreait.cset.dao.BoardDAO;
import com.koreait.cset.dto.BoardDTO;

public class FaqViewCommand implements CsetCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
	
		// 질문글(원글) 정보 모두와 원글에 달린 답글 전부 조회
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		BoardDAO bDAO = sqlSession.getMapper( BoardDAO.class );
		
		// 1.
		int bNo = Integer.parseInt( request.getParameter("bNo") );
		
		// 질문글과 답글 모두 가져오기
		// 가져온 글 중에서 질문글은 bDepth == 0, 답글은 bDepth > 0
		ArrayList<BoardDTO> bList = bDAO.boardSelectBybRef(bNo);
		
		model.addAttribute( "bList", bList );
		
		

	}

}
