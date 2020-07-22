package com.koreait.cset.command.reviews;

import java.io.File;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.cset.common.CsetCommand;
import com.koreait.cset.dao.ReviewsDAO;

public class ReviewsDeleteCommand implements CsetCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		
		int rNo = Integer.parseInt(request.getParameter("rNo"));
		
		ReviewsDAO rDAO = sqlSession.getMapper(ReviewsDAO.class);
		rDAO.deleteReviews(rNo);	
		
		String rFilename = request.getParameter( "rFilename" );
		
		if( rFilename != null && !rFilename.isEmpty() ) {
			File fileToDelete
			= new File( request.getSession().getServletContext().getRealPath("resources/reviewsStorage")
						,rFilename);
			
			fileToDelete.delete();
			
		}
	}

}
