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

public class BoardQueryCommand implements CsetCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		BoardDAO bDAO = sqlSession.getMapper(BoardDAO.class);	
		
		
		// 1. request에 담긴 내용 가져오기
		String queryType = request.getParameter("queryType"); // 검색 종류
		String query = request.getParameter("query");		  // 검색 내용		
		int bClass = Integer.parseInt( request.getParameter("bClass") ); // 게시판 종류
		
		
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
		int totalRecord = bDAO.boardQueryTotalRecords( bClass, queryType, query );
		
		
		// 5. 페이지 생성
		String pageView = PageMaker.getPageView( "boardListPage", page, recordPerPage, totalRecord );
 		
		// 6. 페이지에 보일 게시글 목록 가져오기
		ArrayList<BoardDTO> bList = null;
		// 6-1) NOTICE, Q&A 검색
		if ( bClass != 2 ) {
			bList = bDAO.boardSelectByQuery(bClass, beginRecord, endRecord, queryType, query);		
		// 6-2) FAQ 검색
		} else {
			bList = bDAO.faqBoardSelectByQuery( queryType, query );
		}
		
	
		
		// 7. "open" 세션(조회수 작업 위한 세션) 삭제
		HttpSession session = request.getSession();
		session.removeAttribute( "open" );

		model.addAttribute( "bList", bList );
		model.addAttribute( "page", page );
		model.addAttribute( "pageView", pageView );
		
		
		
		

	}

}
