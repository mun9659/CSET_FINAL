package com.koreait.cset.command.reviews;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.cset.common.CsetCommand;

public class GoReviewsInsertCommand implements CsetCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		HttpSession session = request.getSession();
		
		// pNo값을 가지고 reviewsInsertPage로 간다.
		int pNo = Integer.parseInt(request.getParameter("pNo"));
	   
	}

}
