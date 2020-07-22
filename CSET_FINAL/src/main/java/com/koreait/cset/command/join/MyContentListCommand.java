package com.koreait.cset.command.join;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.cset.common.CsetCommand;
import com.koreait.cset.dao.BoardDAO;
import com.koreait.cset.dao.ReviewsDAO;
import com.koreait.cset.dto.BoardDTO;
import com.koreait.cset.dto.ReviewsJoinVO;

public class MyContentListCommand implements CsetCommand {

	// reviewList = rList
	@Override
	public void execute(SqlSession sqlSession, Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = ( HttpServletRequest ) map.get( "request" );
		
		ReviewsDAO rDAO = sqlSession.getMapper( ReviewsDAO.class );
		
		String mId = request.getParameter("mId");
		ArrayList<ReviewsJoinVO> myReviewList = rDAO.selectMyReviewsList( mId );
		
		
		// ------ 내가 작성한 게시글 보기(Board) --------
		BoardDAO bDAO = sqlSession.getMapper( BoardDAO.class );
		ArrayList<BoardDTO> myBoardList = bDAO.boardSelectBymId( mId );
		
		// 세션에 올라간 rDTO 내리기
		
		
		// 데이터 넘겨주기
		
		model.addAttribute("myReviewList", myReviewList);
		// My Review 수
		model.addAttribute("totalMyReviews", myReviewList.size());
		// 내가 작성한 게시글 넘겨주기(Board)
		model.addAttribute( "myBoardList", myBoardList );
		// 내가 작성한 게시글 수
		model.addAttribute( "totalMyBoard", myBoardList.size() );
				
	}

}
