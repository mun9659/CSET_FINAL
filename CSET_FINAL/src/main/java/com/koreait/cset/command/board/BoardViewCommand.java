package com.koreait.cset.command.board;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.cset.common.CsetCommand;
import com.koreait.cset.dao.BoardDAO;
import com.koreait.cset.dto.BoardDTO;

public class BoardViewCommand implements CsetCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		// request에 담긴 정보 꺼내오기
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		int bNo = Integer.parseInt( request.getParameter("bNo") );
		String page = request.getParameter("page");
		
		
		// DAO 객체 생성
		BoardDAO bDAO = sqlSession.getMapper(BoardDAO.class);
		
		
		// DAO 메소드 이용해 게시글 정보 가져오기
		BoardDTO bDTO = bDAO.boardSelectBybNo(bNo);
		
		
		// 조회수 증가
		HttpSession session = request.getSession();
		String open = (String) session.getAttribute( "open" );
		if ( open == null ) {
			session.setAttribute( "open", "opened" );
			bDAO.boardUpdateHit( bNo );
			
		}
		
		// 게시글 정보를 session에 올려 수정 및 삭제에 활용
		session.setAttribute( "bDTO", bDTO );
		// 페이지 정보도 세션에 올려 view 관련 작업 후에도 페이지를 계속 유지
		session.setAttribute( "page", page );
		
		

	}

}
