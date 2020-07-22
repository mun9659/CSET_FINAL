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

public class ReviewsInsertCommand implements CsetCommand {

   @Override
   public void execute(SqlSession sqlSession, Model model) {
      Map<String, Object> map = model.asMap();
      RedirectAttributes rttr = (RedirectAttributes) map.get("rttr");
      MultipartHttpServletRequest mr = (MultipartHttpServletRequest) map.get("mr");
      ReviewsDAO rDAO = sqlSession.getMapper(ReviewsDAO.class);
      
      // 페이지에서 삽입할 데이터
      String rContent = mr.getParameter("rContent");
      int rRating = Integer.parseInt(mr.getParameter("rRating"));
      String rFilename = mr.getParameter("rFilename");
      // 받는 값
      int pNo = Integer.parseInt(mr.getParameter("pNo"));
      String mId = mr.getParameter("mId"); 
      
      // 0717수정
      ReviewsDTO rDTO = new ReviewsDTO();
      rDTO.setrContent(rContent);
      rDTO.setrRating(rRating);
      rDTO.setrFilename(rFilename);
      rDTO.setmId(mId);
      rDTO.setpNo(pNo);
      
      MultipartFile file = mr.getFile("rFilename");
      
      if ( file.isEmpty() == false ) {
    	  
    	  // 저장할 파일 이름 만들기
    	  try {
    		  // 업로드 할 파일의 이름 / 확장자 분리하기
    		  String originFilename = file.getOriginalFilename();
    		  String extName = originFilename.substring(originFilename.lastIndexOf(".")+ 1 );
    		  
    		  String saveFilename = null;
    		  
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
    		  
    		  // DB에 저장
    		  rDTO.setrFilename(saveFilename);
    		  
    	  } catch (Exception e) {
    		  e.printStackTrace();
    	  }
    	  
      }
   
         
         rttr.addFlashAttribute("insertResult", rDAO.insertReviews(rDTO));
         //rDAO.insertReviews( pNo, mId, rContent, saveFilename, rRating);
         rttr.addFlashAttribute("beInserted", true);
         
         rttr.addFlashAttribute("pNo", pNo);
         
         //model.addAttribute( "pNo", pNo );
         model.addAttribute("mId", mId);
         }
   }

