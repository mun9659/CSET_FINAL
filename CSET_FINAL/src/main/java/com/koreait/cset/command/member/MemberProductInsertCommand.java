package com.koreait.cset.command.member;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.koreait.cset.common.CsetCommand;
import com.koreait.cset.dao.MemberDAO;

public class MemberProductInsertCommand implements CsetCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		MemberDAO mDAO = sqlSession.getMapper(MemberDAO.class);
		
		Map<String, Object> map = model.asMap();
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest) map.get("mr");
		
		String pName =mr.getParameter("pName");
		int pPrice =Integer.parseInt(mr.getParameter("pPrice"));
		String pCategory =mr.getParameter("pCategory");
		String pCategory_sub =mr.getParameter("pCategory_sub");
		String pBrand =mr.getParameter("pBrand");

		int sAmount_S =Integer.parseInt(mr.getParameter("sAmount_S"));
		int sAmount_M =Integer.parseInt(mr.getParameter("sAmount_M"));
		int sAmount_L =Integer.parseInt(mr.getParameter("sAmount_L"));
		
		List<MultipartFile> fileList = mr.getFiles("files");
		
		
		for ( MultipartFile file : fileList ) {  // 첨부를 하나씩 file 에 저장하고 처리
			
			if ( !file.isEmpty() ) {
				
				// 업로드 할 파일의 이름 / 확장자 분리하기
				// 동일한 이름을 가진 파일이 업로드 되지 않도록 직접 파일 이름을 수정해서 올린다.
				// 업로드 된 원래 파일명(확장자도 포함)
				String originFilename = file.getOriginalFilename();
				
				// originFilename 에서 확장자 분리
				String extName = originFilename.substring(originFilename.lastIndexOf(".") + 1);
				
				String saveFilename = null;
				
				// 저장할 파일 이름 만들기 / 업로드 / 파일이름 DB 에 저장
				try {					
					// 1) 저장할 파일 이름 만들기
					// 파일명 중복 방지 대책으로 서버에 저장할 파일의 이름에 업로드 시간을 추가한다.
					// 서버에 저장될 파일명 : 원래파일명_업로드시간.확장자
					// 원래파일명 : originFilename.substring(0, originFilename.lastIndexOf("."))
					// 업로드시간 : System.currentTimeMillis()
					saveFilename = originFilename.substring(0, originFilename.lastIndexOf(".")) +
									"_" +
									System.currentTimeMillis() +
									"." + extName;
					
					
					// 2) 업로드
					
					// 2-1) 파일이 저장될 서버 내 경로(/resources/storage)를 알아낸다.
					String realPath = mr.getSession().getServletContext().getRealPath("/resources/product_photos");
					
					// 2-2) /resources/storage 경로가 존재하지 않으면 필요한 경로(디렉토리)를 만든다.
					// new File(경로) : 경로로 디렉토리만 사용되면 디렉토리로 인식한다.
					File directory = new File(realPath);
					if ( !directory.exists() ) {
						directory.mkdirs();
					}
					
					// 2-3) 서버에 저장할 파일을 만든다.
					File saveFile = new File(realPath, saveFilename);
					
					// 2-4) 업로드한다.
					file.transferTo(saveFile);
					
					// 3) DB 에 저장
					//		pName pPrice pCategory pCategory_sub pBrand
					// iWriter, iTitle, iContent, saveFilename
					
					mDAO.memberProductInsert(pName, saveFilename, pPrice, pCategory, pCategory_sub, pBrand);
					 
					int pNo= mDAO.memeberSelectPno();
								
					mDAO.memberStockInsertS(pNo,sAmount_S);
					mDAO.memberStockInsertM(pNo,sAmount_M);
					mDAO.memberStockInsertL(pNo,sAmount_L);
					//mDAO.memberStockInsert(sAmount_S, sAmount_M, sAmount_L);
				} catch (Exception e) {
					e.printStackTrace();
				}
				
			}
			
		}
	}

}
