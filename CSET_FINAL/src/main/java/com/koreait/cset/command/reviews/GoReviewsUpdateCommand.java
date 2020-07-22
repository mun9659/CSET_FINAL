package com.koreait.cset.command.reviews;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.cset.common.CsetCommand;
import com.koreait.cset.dto.ReviewsDTO;

public class GoReviewsUpdateCommand implements CsetCommand {
	
	// 리뷰 수정 페이지로 이동하기 위해
	@Override
	public void execute(SqlSession sqlSession, Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
	
	
		ReviewsDTO rDTO = (ReviewsDTO) request.getSession().getAttribute("rDTO");
		// session에서 받아온 rDTO(안에 rNo가 있을 것)
	}
}
