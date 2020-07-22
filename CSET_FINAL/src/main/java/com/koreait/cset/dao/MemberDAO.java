package com.koreait.cset.dao;

import java.util.ArrayList;

import com.koreait.cset.dto.JoinVO;
import com.koreait.cset.dto.MemberDTO;
import com.koreait.cset.dto.ProductsDTO;

public interface MemberDAO {

	//회원가입
	public void memberInsert(String mSno,String mId,String mName,String mPw,String mAddr,int mPno,String mEmail,String mPhone);
	//로그인하기
	public MemberDTO selectBymIdmPw(MemberDTO mDTO);
	//회원목록보기(관리자로그인한에서만)
	public ArrayList<MemberDTO> memberselectList();
	//회원 탈퇴하기
	public void memeberDelete(String mId);
	//회원정보변경하기
	public void memberChange(String mName,String mEmail,String mPhone,String mAddr,int mNo);
	//회원정보회원번호로 보기
	public MemberDTO memberselectByNo(int mNo);
	//아이디조회하기
	public MemberDTO memberselectBymId(String mId);
	//이메일로아이디찾기
	public MemberDTO memberselectBymEmail(String mEmail); 
	//관리자로 상품업로드하기
	//	pName pPrice pCategory pCategory_sub pBrand
	public void memberProductInsert(String pName,String saveFilename,int pPrice,String pCategory,String pCategory_sub,String pBrand);
//	public void memberProductInsert(String pName,String saveFilename,int pPrice,String pCategory,String pCategory_sub,String pBrand,int sAmount_S,int sAmount_M,int sAmount_L);
	//관리자가 상품업로드한페이지보기
	public ArrayList<ProductsDTO> selectProductList();
	//관리자가 상품 가격변경하기
	public void memberProductPriceChange(int afterPrice ,int pNo);
	//관리자가 상품할인율변경하기
	public void memberUpdatedisrateChange(int afterDisrate ,int pNo);
	//관리자가 회원등급변경하기
	public void memberUpdateGrade(char afterGrade, int mNo);
	//관리자가 회원포인트 지급하기
	public void memberUpdatePoint(int afterPoint, int mNo);
	//회원이주문목록확인하기
	public ArrayList<JoinVO> memberOrderView(int mNo);
	
	//회원비밀번호 변경하기 07-14
	public void memberChangePw(String mPw,String mId);
	//관리자가 회원을지우기위해 회원이 작성한리뷰테이블내용제거-1
	public void memberDeleteReview(String mId);
	//관리자가 회원을지우기위해 회원이 작성한주문테이블내용제거-2
	public void memberDeleteOrder(int mNo);
	//관리자가 회원을지우기위해 회원이 작성한게시판테이블내용제거-3
	public void memberDeleteBoard(String mId);
	//관리자가 회원을지우기위해 회원이 작성한 카트테이블내용제거-4
	public void memberDeleteCart(String mId);

	
	// 관리자 회원목록 검색0716
	public ArrayList<MemberDTO> memberSelectByQuery( String query );
	
	//관리자가 회원주문조회기간입력후0716
	public ArrayList<JoinVO> memberOrderPeriod(int mNo ,String startDate,String endDate);
	
	
	//상품번호 가져오기
	public  int memeberSelectPno();
	//관리자가 상품 재고 삽입
	public void memberStockInsertS(int pNo,int sAmount_S);
	public void memberStockInsertM(int pNo ,int sAmount_M);
	public void memberStockInsertL(int pNo ,int sAmount_L);
	
	
	
	
}
