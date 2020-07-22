package com.koreait.cset.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.koreait.cset.command.board.BoardDeleteCommand;
import com.koreait.cset.command.board.BoardDownloadCommand;
import com.koreait.cset.command.board.BoardInsertCommand;
import com.koreait.cset.command.board.BoardListCommand;
import com.koreait.cset.command.board.BoardQueryCommand;
import com.koreait.cset.command.board.BoardUpdateCommand;
import com.koreait.cset.command.board.BoardViewCommand;
import com.koreait.cset.command.board.FaqBoardListCommand;
import com.koreait.cset.command.board.FaqViewCommand;
import com.koreait.cset.command.board.ReplyInsertCommand;
import com.koreait.cset.common.CsetCommand;

@Controller
public class BoardController {

	
	// Fields
	@Autowired
	private SqlSession sqlSession;
	private CsetCommand boardCommand;
	
	
	// 1. 게시글 전체 조회
	@RequestMapping( "boardListPage" )
	public String boardListPage( HttpServletRequest request, Model model ) {

		model.addAttribute("request", request);
		
		// 어떤 게시판을 보여줄지 bClass 속성으로 구분한다.
		// bClass의 값은 parameter로 전달받는다
		// bClass에 아무 값도 전달되지 않았을 경우 QNA 페이지로 이동
		String bClassStr = request.getParameter("bClass");
		if( bClassStr == null || bClassStr.isEmpty() ) {
			bClassStr = "1";
		}
		int bClass = Integer.parseInt( bClassStr );
		
		String path = "board/";
		
		switch( bClass ) {
		case 0: 
			path += "noticeBoardListPage"; 
			boardCommand = new BoardListCommand();
			break;
		case 1: 
			path += "qnaBoardListPage"; 
			boardCommand = new BoardListCommand();
			break;
		case 2: path += "faqBoardListPage"; 
			boardCommand = new FaqBoardListCommand();
		break;
		}
		
		
		boardCommand.execute(sqlSession, model);
		
		return path;
	}
	
	
	// 2. 게시글 검색
	@RequestMapping( "boardQuery" )
	public String boardQuery( HttpServletRequest request, Model model ) {
		
		int bClass = Integer.parseInt( request.getParameter("bClass") );
		String path = "board/";		
		
		switch( bClass ) {
		case 0: path += "noticeBoardListPage"; break;
		case 1: path += "qnaBoardListPage"; break;
		case 2: path += "faqBoardListPage"; break;
		}
				
		model.addAttribute( "request", request );
		boardCommand = new BoardQueryCommand();
		boardCommand.execute(sqlSession, model);

		return path;
	}
	
	
	// 3. 게시글 하나 조회
	@RequestMapping( "boardViewPage" )
	public String boardViewPage( HttpServletRequest request, Model model ) {
		model.addAttribute("request", request);
		boardCommand = new BoardViewCommand();
		boardCommand.execute(sqlSession, model);
		return "board/boardViewPage";
	}
	
	
	// 3-1) FAQ 게시글 조회
	@RequestMapping( "faqViewPage" )
	public String faqViewPage( HttpServletRequest request, Model model ) {
		model.addAttribute("request", request);
		boardCommand = new FaqViewCommand();
		boardCommand.execute(sqlSession, model);
		return "board/faqViewPage";
	}
	
	
	// 4. 게시글 작성(삽입)
	// 4-1) 작성 페이지로 이동
	//		작성할 게시글의 종류 (bClass)를 가지고 이동한다
	@RequestMapping( "boardInsertPage" )
	public String boardInsertPage( HttpServletRequest request) {
		request.setAttribute( "bClass",  request.getParameter("bClass"));
		return "board/boardInsertPage";
	}
	
	// 4-2) 작성한 게시글 삽입
	@RequestMapping( value="boardInsert", method=RequestMethod.POST )
	public String boardInsert( MultipartHttpServletRequest mr, RedirectAttributes rttr, Model model ) {
		model.addAttribute( "mr", mr );
		model.addAttribute( "rttr", rttr );
		boardCommand = new BoardInsertCommand();
		boardCommand.execute(sqlSession, model);		
		return "redirect:boardListPage?bClass="+ mr.getParameter("bClass");
	}
	
	
	// 5. 게시글 수정
	// 5-1) 수정 페이지로 이동
	@RequestMapping( "boardUpdatePage" )
	public String boardUpdatePage() {
		return "board/boardUpdatePage";
	}
	
	// 5-2) 실제 수정 작업
	@RequestMapping( value="boardUpdate", method=RequestMethod.POST )
	public String boardUpdate( MultipartHttpServletRequest mr, RedirectAttributes rttr, Model model ) {		
		model.addAttribute( "mr", mr );
		model.addAttribute( "rttr", rttr );
		boardCommand = new BoardUpdateCommand();
		boardCommand.execute(sqlSession, model);
		return "redirect:boardViewPage?bNo="+mr.getParameter("bNo");
	}
	
	
	// 6. 답글 달기
	// 6-1) 답글 달기 페이지로 이동
	@RequestMapping( "replyInsertPage" )
	public String replyInsertPage() {
		return "board/replyInsertPage";
	}
	
	// 6-2) 답글 달기
	@RequestMapping( "replyInsert" )
	public String replyInsert( MultipartHttpServletRequest mr, RedirectAttributes rttr, Model model) {
		model.addAttribute( "mr", mr );
		model.addAttribute( "rttr", rttr );
		boardCommand = new ReplyInsertCommand();
		boardCommand.execute(sqlSession, model);
		return "redirect:boardListPage";
	}
	
	
	// 7. 글 삭제
	@RequestMapping( "boardDelete" )
	public String boardDelete( HttpServletRequest request, RedirectAttributes rttr, Model model ) {
		model.addAttribute( "request", request );
		model.addAttribute( "rttr", rttr );
		boardCommand = new BoardDeleteCommand();
		boardCommand.execute(sqlSession, model);
		return "redirect:boardListPage";
	}
	
	
	// 8. 파일 다운로드
	@RequestMapping( "boardDownload" )
	public void boardDownload( HttpServletRequest request, HttpServletResponse response, Model model ) {
		model.addAttribute( "request", request );
		model.addAttribute( "response", response );
		boardCommand = new BoardDownloadCommand();
		boardCommand.execute(sqlSession, model);
	}
}
