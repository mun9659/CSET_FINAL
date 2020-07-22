package com.koreait.cset.command.reviews;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.cset.common.CsetCommand;
import com.koreait.cset.dao.ReviewsDAO;
import com.koreait.cset.dto.ReviewsJoinVO;

public class MyContentListCommand implements CsetCommand {

	// reviewList = rList
	@Override
	public void execute(SqlSession sqlSession, Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = ( HttpServletRequest ) map.get( "request" );
		HttpSession session = request.getSession();
		
		ReviewsDAO rDAO = sqlSession.getMapper( ReviewsDAO.class );
		
		// 로그인한 mId의 reviewsList
		String mId = request.getParameter("mId");
		ArrayList<ReviewsJoinVO> myRereviewList = rDAO.selectMyReviewsList( mId );
		// 세션에 올라간 rDTO 내리기
		session.removeAttribute("rDTO");
		
		// 데이터 넘겨주기
		
		model.addAttribute("myRereviewList", myRereviewList);
		// My Review 수
		model.addAttribute("myReriewList", myRereviewList.size());
				
	}

}
