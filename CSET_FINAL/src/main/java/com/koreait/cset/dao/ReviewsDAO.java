package com.koreait.cset.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.koreait.cset.dto.ReviewsDTO;
import com.koreait.cset.dto.ReviewsJoinVO;

public interface ReviewsDAO {
	
	//  상품별 전체 리뷰 수 조회
	public int reviewsTotalRecords( int pNo );
	
	// 리뷰 목록
	public ArrayList<ReviewsDTO> selectReviewsList( int pNo , int beginRecord, int endRecord);
	
	
	// 리뷰 개별 항목 (reviewsViewPage)
	public ReviewsDTO selectByrNo( int rNo );

	// 리뷰 수정 (reviewsUpdatePage)
	public void updateReviews( ReviewsDTO rDTO );
	// 리뷰 삭제
	public void deleteReviews( @Param("rNo") int rNo );
	
	// 리뷰 작성(int pNo, int mId -> 임의로 삽입)
	public int insertReviews( ReviewsDTO rDTO );
	
	// 마이페이지 리뷰 목록
	public ArrayList<ReviewsJoinVO> selectMyReviewsList( String mId );

}
