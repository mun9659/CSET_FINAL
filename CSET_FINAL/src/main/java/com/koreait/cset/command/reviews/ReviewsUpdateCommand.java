package com.koreait.cset.command.reviews;

import java.io.File;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.koreait.cset.common.CsetCommand;
import com.koreait.cset.dao.ReviewsDAO;
import com.koreait.cset.dto.ReviewsDTO;

public class ReviewsUpdateCommand implements CsetCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest) map.get("mr");
		RedirectAttributes rttr = (RedirectAttributes) map.get("rttr");
		// 수정에 필요한 정보 받아오기
		int rNo = Integer.parseInt(mr.getParameter("rNo"));
		String rFilename = mr.getParameter("rFilename");
		String rContent = mr.getParameter("rContent");
		int rRating = Integer.parseInt(mr.getParameter("rRating"));
		
		MultipartFile file = mr.getFile("rFilename");
		
		
		
		// DAO 메소드에 전달할 데이터 담은 DTO 삭제
		ReviewsDTO rDTO = new ReviewsDTO();
		rDTO.setrNo(rNo);
		rDTO.setrContent(rContent);
		rDTO.setrFilename(rFilename);
		rDTO.setrRating(rRating);
		
		// 파일이 있을 경우
		if( file.isEmpty() == false ) {
		
       	  
			 // 업로드 할 파일의 이름 / 확장자 분리하기
              String originFilename = file.getOriginalFilename();
              String extName = originFilename.substring(originFilename.lastIndexOf(".")+ 1 );
      
              String saveFilename = null;
              
              try {  
	              saveFilename = originFilename.substring(0, originFilename.lastIndexOf(".")) +
	                          "-" + 
	                          System.currentTimeMillis() +
	                          "." + extName;
	                    
	              // 업로드
	              // 파일이 저장될 경로 알아내기
	              String realPath = mr.getSession().getServletContext().getRealPath("resources/reviewsStorage");
	              // 경로가 없다면 만들기
	              File directory = new File(realPath);
	              if ( !directory.exists()) {
	                 directory.mkdirs();
	              }     
	              // 서버에 저장할 파일 만들기
	              File saveFile = new File(realPath, saveFilename);
	                    
	              // 업로드
	              file.transferTo(saveFile);
	                    
	              // DAO에 전달할 데이터
	              rDTO.setrFilename(saveFilename);
	              // DB에 저장
	              String beforeFile = mr.getParameter("beforeFile");
	              File fileToDelete = new File(realPath, beforeFile);
	              fileToDelete.delete();
	              
           } catch (Exception e) {
              
           }
           
		}else {	
		}
		// page와 bNo도 전달해야 함.
		rttr.addFlashAttribute("rNo", rNo);
		ReviewsDAO rDAO = sqlSession.getMapper(ReviewsDAO.class);
		rDAO.updateReviews(rDTO);  

	}

}
