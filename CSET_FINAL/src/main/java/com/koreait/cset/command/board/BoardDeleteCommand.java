package com.koreait.cset.command.board;

import java.io.File;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.cset.common.CsetCommand;
import com.koreait.cset.dao.BoardDAO;

public class BoardDeleteCommand implements CsetCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
	
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
//		RedirectAttributes rttr = (RedirectAttributes) map.get("rttr");
		BoardDAO bDAO = sqlSession.getMapper( BoardDAO.class );
		
		// 여러 bNo를 받아서 삭제
		String[] bNoStr = request.getParameterValues("bNo");
		for ( int i = 0; i < bNoStr.length; i++ ) {
			int bNo = Integer.parseInt( bNoStr[i] );
			bDAO.boardDelete(bNo);			
		}
		
		
		// 삭제
		
		// 파일도 삭제 위해 파일 이름 가져오기
		String bFilename = request.getParameter( "bFilename" );
		
		// 삭제할 파일이 존재할 경우 파일 연결하기
		if( bFilename != null && !bFilename.isEmpty() ) {
			File fileToDelete 
			= new File( request.getSession().getServletContext().getRealPath("/resources/boardStorage")
					, bFilename );
			// 파일 삭제
			fileToDelete.delete();			
		}
		
		// 삭제 결과 보내기
//		rttr.addFlashAttribute( "deleteResult", deleteResult );
//		rttr.addFlashAttribute( "isDeleted", true );
		

	}

}
