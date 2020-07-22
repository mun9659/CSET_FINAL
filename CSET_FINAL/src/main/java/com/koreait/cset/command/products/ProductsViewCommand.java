package com.koreait.cset.command.products;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.cset.common.CsetCommand;
import com.koreait.cset.common.ReviewsPageMaker;
import com.koreait.cset.dao.ProductsDAO;
import com.koreait.cset.dao.ReviewsDAO;
import com.koreait.cset.dto.ProductsDTO;
import com.koreait.cset.dto.ReviewsDTO;
import com.koreait.cset.dto.StockDTO;

public class ProductsViewCommand implements CsetCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		HttpSession session = request.getSession();
		int pNo = Integer.parseInt(request.getParameter("pNo"));
		
		ProductsDAO pDAO = sqlSession.getMapper(ProductsDAO.class);
		ProductsDTO pDTO = pDAO.productsSelectBypNo(pNo);
		
		model.addAttribute("pDTO", pDTO);
		
		/*****************재고 조회하기***************/
		ArrayList<StockDTO> stockList = pDAO.stockSelectBypNo(pNo);
		model.addAttribute("stockList", stockList);
		
		/*****************리뷰 리스트*****************/
		
		ReviewsDAO rDAO = sqlSession.getMapper( ReviewsDAO.class );
		
		// 페이지 생성 
		
		// pNo마다 리뷰를 달 수 있음 -> 리뷰 번호 가져오기(위에 있음)
		
		// 현제 페이지가 없거나 비어있으면 1페이지
		String rPage = request.getParameter( "page" );
		if ( rPage == null || rPage.isEmpty() ) {
			rPage = "1";
		}
		int page = Integer.parseInt( rPage );
		
		// 페이지 관련 정보
		// 1 .페이지당 게시글 수 7개
		int recordPerPage = 7;
		// 2. 시작 게시글 번호 // 끝 게시글 번호
		int beginRecord = ( page - 1 ) * recordPerPage + 1;
		int endRecord = beginRecord + recordPerPage - 1;
		// 전체 게시글 수
		int totalRecord = rDAO.reviewsTotalRecords( pNo );
		// 페이지에 보일 게시글 목록 가져오기
		ArrayList<ReviewsDTO> rList = rDAO.selectReviewsList( pNo, beginRecord, endRecord );
		// 0716 수정
		String reviewPageView = ReviewsPageMaker.getPageView( "productsViewPage", pNo, page, recordPerPage, totalRecord );
		
		
		// 세션에 올라간 rDTO 내리기
		session.removeAttribute("rDTO");
		
		// 데이터 넘겨주기
		model.addAttribute( "pNo", pNo );
		model.addAttribute( "rList", rList );
		model.addAttribute( "totalRecord", totalRecord );
		model.addAttribute( "page", page );
		model.addAttribute( "reviewPageView", reviewPageView );
				
	}

}
