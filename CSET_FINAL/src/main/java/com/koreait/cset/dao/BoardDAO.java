package com.koreait.cset.dao;

import java.util.ArrayList;

import com.koreait.cset.dto.BoardDTO;

public interface BoardDAO {

	// 1. 페이지에 보일 게시글 목록 가져오기 (NOTICE / QNA)
	public ArrayList<BoardDTO> boardSelectList( int bClass, int beginRecord, int endRecord );
	
	// 1-1) FAQ 목록 가져오기
	public ArrayList<BoardDTO> faqSelectList();
	
	// 2. 게시글 전체 개수 조회
	public int boardTotalRecords( int bClass );
	
	// 3. 게시글 검색
	public ArrayList<BoardDTO> boardSelectByQuery( 
			int bClass
			, int beginRecord
			, int endRecord
			, String queryType
			, String query );

	// 3-1) FAQ 검색
	public ArrayList<BoardDTO> faqBoardSelectByQuery( String queryType, String query );
	
	// 3-2) 게시글 검색 결과 총 개수 조회 (페이지 계산용)
	public int boardQueryTotalRecords( int bClass, String queryType, String query );
	
	// 4. 게시글 하나 조회
	public BoardDTO boardSelectBybNo( int bNo );
	
	// 4-1. FAQ 게시글 조회 (bRef로 질문글과 관련 글 모두 가져오기)
	public ArrayList<BoardDTO> boardSelectBybRef( int bNo );
	
	// 5. 게시글 조회수 증가
	public void	boardUpdateHit( int bNo );
	
	// 6. 게시글 삽입
	public int boardInsert( BoardDTO bDTO );
	
	// 7. 게시글 수정
	public int boardUpdate( BoardDTO bDTO );
	
	// ----------------- 댓글 -------------------
	// 8. 원글이 같은(bRef가 같은) 기존 글들 모두 bStep 1씩 증가
	public void boardUpdatebStep( int bRef );
	
	// 9. 댓글 삽입
	public int replyInsert( BoardDTO replyDTO );
	// -------------------------------------------
	
	// 10. 게시글 삭제 
	public int boardDelete( int bNo );
	
	// 11. Q&A 게시판에서 구매했던 상품Number, 상품이름 띄우기
	// public ArrayList<ProductDTO> userPurchase 
	
	// 12. 내가 작성한 게시글 보기
	public ArrayList<BoardDTO> boardSelectBymId( String mId );
	
}
 