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

public class ReplyInsertCommand implements CsetCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest) map.get( "mr" );
		RedirectAttributes rttr = (RedirectAttributes) map.get( "rttr" );
		BoardDAO bDAO = sqlSession.getMapper( BoardDAO.class );
		
		// mr로부터 정보 받아오기
		String bTitle = mr.getParameter("bTitle");
		String bContent = mr.getParameter("bContent");
		String mId = mr.getParameter("mId");
		String bPw = mr.getParameter("bPw");
		int bClass = Integer.parseInt( mr.getParameter("bClass") );
		int bNo = Integer.parseInt( mr.getParameter( "bNo" )); // 원글의 번호
		
		String page = mr.getParameter( "page" );
		
		// replyDTO 생성
		BoardDTO replyDTO = new BoardDTO();
		replyDTO.setbTitle(bTitle);
		replyDTO.setbContent(bContent);
		replyDTO.setbPw(bPw);
		replyDTO.setmId(mId);	
		replyDTO.setbClass(bClass);
		
		// 댓글이 달릴 원글(bDTO) 가져오기
		BoardDTO bDTO = bDAO.boardSelectBybNo(bNo);
		
		// 원글(bDTO) 정보로 댓글(replyDTO) 채우기
		replyDTO.setbRef( bDTO.getbRef() );
		replyDTO.setbDepth( bDTO.getbDepth() + 1 );
		replyDTO.setbStep( bDTO.getbStep() + 1 );
		
		// 기존 댓글들의 bStep 값을 1씩 증가시키기
		// 가장 오래된(가장 먼저 달린) 댓글의 bStep 값이 가장 커진다.
		bDAO.boardUpdatebStep( replyDTO.getbRef() );
				
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
				replyDTO.setbFilename(saveFilename);					
				
			}catch (Exception e) {
				e.printStackTrace();
			}
						
		}
		// replyDTO DB에 삽입
		int replyInsertResult = bDAO.replyInsert( replyDTO );
		
		// 목록으로 이동하기 위한 정보
		rttr.addFlashAttribute( "page", page );
		rttr.addFlashAttribute( "bClass", bClass );	
		rttr.addFlashAttribute( "replyInsertResult", replyInsertResult );

	}

}
