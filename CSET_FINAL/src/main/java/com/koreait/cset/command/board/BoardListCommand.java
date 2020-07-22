package com.koreait.cset.command.board;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.cset.common.CsetCommand;
import com.koreait.cset.common.PageMaker;
import com.koreait.cset.dao.BoardDAO;
import com.koreait.cset.dto.BoardDTO;

public class BoardListCommand implements CsetCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get( "request" );
		BoardDAO bDAO = sqlSession.getMapper(BoardDAO.class);		
		
		// 1. 게시판 옵션(bClass) 가져오기
		//   전달된 bClass값이 없을 경우 default를 1로 설정 (QNA 게시판으로 ㄱㄱ)
		String bClassStr = request.getParameter( "bClass" );
		if( bClassStr == null || bClassStr.isEmpty()) {
			bClassStr = "1";
		}
		
		int bClass = Integer.parseInt( bClassStr );
		
		// 2. 현재 페이지 가져오기
		String pageStr = request.getParameter( "page" );
		if( pageStr == null || pageStr.isEmpty() ) {
			pageStr = "1";
		}
		int page = Integer.parseInt( pageStr );
		
		// 3. 페이지 관련 정보 설정하기
		int recordPerPage = 10;	// 페이지 당 게시글 10 개 
		// 페이지 첫 | 마지막 게시글의 번호
		int beginRecord = (page - 1) * recordPerPage + 1;
		int endRecord = beginRecord + recordPerPage - 1;
		
		// 4. 전체 게시글 수
		int totalRecord = bDAO.boardTotalRecords( bClass );
		
		
		// 5. 페이지 생성
		String pageView = PageMaker.getPageView( "boardListPage", page, recordPerPage, totalRecord );
 		
		// 6. 페이지에 보일 게시글 목록 가져오기
		ArrayList<BoardDTO> bList = bDAO.boardSelectList(bClass, beginRecord, endRecord);
		
		// 7. "open" 세션(조회수 작업 위한 세션) 삭제
		HttpSession session = request.getSession();
		session.removeAttribute( "open" );
		
		// 8. viewPage에서 올렸던 세션 정보 제거
		session.removeAttribute( "bDTO" );
		
		// Q&A에서 회원이 구매했던 제품 고를 수 있도록 데이터 넘겨주기

		model.addAttribute( "bClass", bClass );
		model.addAttribute( "bList", bList );
		model.addAttribute( "page", page );
		model.addAttribute( "pageView", pageView );
		

	}

}
