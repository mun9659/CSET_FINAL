package com.koreait.cset.command.board;

import java.io.File;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.koreait.cset.common.CsetCommand;
import com.koreait.cset.dao.BoardDAO;
import com.koreait.cset.dto.BoardDTO;

public class BoardInsertCommand implements CsetCommand{
	
	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest) map.get( "mr" );
		RedirectAttributes rttr = (RedirectAttributes) map.get( "rttr" );
		BoardDAO bDAO = sqlSession.getMapper( BoardDAO.class );
		
		
		// Request로부터 정보 받아오기
		String bTitle = mr.getParameter("bTitle");
		String bContent = mr.getParameter("bContent");
		String mId = mr.getParameter("mId");
		String bPw = mr.getParameter("bPw");
		int bClass = Integer.parseInt( mr.getParameter("bClass") );
		
		
		// DAO 메소드에 전달할 정보 모으기	
		BoardDTO bDTO = new BoardDTO();
		bDTO.setbTitle(bTitle);
		bDTO.setbContent(bContent);
		bDTO.setmId(mId);
		bDTO.setbPw(bPw);
		bDTO.setbClass(bClass);
		
		
		MultipartFile file = mr.getFile("bFilename");
		
		// 업로드 된 파일이 있을 경우에만 다음 작업 수행
		if( file.isEmpty() == false ) {
			
			try {				
				// 업로드 할 파일의 이름/확장자 분리하기
				String originalFilename = file.getOriginalFilename();
				String ext = originalFilename.substring( originalFilename.lastIndexOf(".") + 1 );			
				
				// 저장할 파일 이름 생성
				// 서버 현재 시각을 millisec 단위로 변환하여 파일명에 추가
				String saveFilename = originalFilename.substring( 0, originalFilename.lastIndexOf(".") )
						+ "_" + System.currentTimeMillis()
						+ "." + ext;
				
				// 업로드
				// 1) 파일이 저장될 서버 내 경로(/resources/storage)알아내기
				String realPath = mr.getSession().getServletContext().getRealPath("/resources/boardStorage");
				// 2) 만약 위 경로가 존재하지 않으면 해당 경로를 생성한다
				File dir = new File( realPath );
				if( !dir.exists() ) { dir.mkdirs(); }
				// 3) 서버에 저장할 파일 생성
				File saveFile = new File( realPath, saveFilename );
				// 4) 업로드
				file.transferTo(saveFile);			
				
				// DAO에 전달할 데이터
				bDTO.setbFilename(saveFilename);					
				
			}catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		
		
		// 삽입이 정상적으로 이루어졌는지 확인하기 위한 코드
		rttr.addFlashAttribute( "insertResult", bDAO.boardInsert( bDTO ) );
		rttr.addFlashAttribute( "isInserted", true );
		
		
		
		// 새로운 게시물이 작성된 게시판으로 이동하기 위해 게시판 분류 전달
		model.addAttribute( "bClass", bClass );
		
		
	}
	
}
