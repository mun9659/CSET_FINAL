package com.koreait.cset.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.koreait.cset.command.member.MemberQueryCommand;
import com.koreait.cset.command.member.MemberChangeCommand;
import com.koreait.cset.command.member.MemberDeleteCommand;
import com.koreait.cset.command.member.MemberDetailCommand;
import com.koreait.cset.command.member.MemberEmailAuthCommand;
import com.koreait.cset.command.member.MemberInsertCommand;
import com.koreait.cset.command.member.MemberListCommand;
import com.koreait.cset.command.member.MemberLoginCommand;
import com.koreait.cset.command.member.MemberLogoutCommand;
import com.koreait.cset.command.member.MemberOrderPeriodViewCommand;
import com.koreait.cset.command.member.MemberOrderView;
import com.koreait.cset.command.member.MemberProductInsertCommand;
import com.koreait.cset.command.member.MemberProductListCommand;
import com.koreait.cset.command.products.ProductsOrderByRank;
import com.koreait.cset.common.CsetCommand;
import com.koreait.cset.dao.MemberDAO;
import com.koreait.cset.dto.MemberDTO;

@Controller
public class MemberController {
	
	@Autowired
	private SqlSession sqlSession;
	private CsetCommand memberCommand;
	private CsetCommand productsCommand;
	
	
	//회원가입페이지로이동하기
	@RequestMapping("memberInsertPage")
	public String memberInsertPage() {
		return "member/memberInsertPage";
	}
	//1.회원가입하기
	@RequestMapping(value="memberInsert",method=RequestMethod.POST)
	public String memberJoin(HttpServletRequest request ,Model model) {
		model.addAttribute("request",request);
		memberCommand = new MemberInsertCommand();
		memberCommand.execute(sqlSession, model);	
		return"redirect:memberLoginPage";

	}
	//2.회원가입 아이디 유무확인
	@ResponseBody
	@RequestMapping(value="memberIdCheck", produces="application/json; charset=utf-8")
	public String memberIdCheck(@RequestParam("mId") String mId,
				HttpServletRequest request,
				Model model){
		JSONObject obj = new JSONObject();
		MemberDTO mDTO = new MemberDTO();
		MemberDAO mDAO = sqlSession.getMapper(MemberDAO.class);
		mDTO = mDAO.memberselectBymId(mId);
		
		if ( mDTO != null ) {
			obj.put("result", "EXIST");
		} else {
			obj.put("result", "");
		}
		
		return obj.toJSONString();
	}
	
	//3.로그인페이지로이동하기
	@RequestMapping("memberLoginPage")
	public String memberLoginPage() {
		return"member/memberLoginPage";
	}
	
	//4.로그인 하기
   @RequestMapping(value="memberLogin",method=RequestMethod.POST)
   public String memberLogin(HttpServletRequest request ,		   				
                     HttpServletResponse response,
                     Model model) {
      model.addAttribute("request",request);
      model.addAttribute("response",response);
      memberCommand = new MemberLoginCommand();
      memberCommand.execute(sqlSession, model);
      return index(request, model);
   }
   
   private String index(HttpServletRequest request, Model model) {
      productsCommand = new ProductsOrderByRank();
      productsCommand.execute(sqlSession, model);
      return "index";
   }
	
	//5.회원목록가기(관리자입장에서) 
	@RequestMapping("memberListPage")
	public String memberListPage(HttpServletRequest request,
								HttpServletResponse response,
									Model model
									) {
		model.addAttribute("request",request);
		model.addAttribute("response",response);
		memberCommand = new MemberListCommand();
		memberCommand.execute(sqlSession, model);
		return"member/memberListPage";
	}
	//6.로그아웃하기
	@RequestMapping("memberLogout")
	public String memberLogout(HttpServletRequest request ,
								HttpServletResponse response,
								Model model) {
		model.addAttribute("request",request);
		model.addAttribute("response",response);
		memberCommand = new MemberLogoutCommand();
		memberCommand.execute(sqlSession, model);
		return"redirect:/";
	}
	//7.마이페이지
	@RequestMapping("memberViewPage")
	public String memberViewPage() {
		return"member/memberViewPage";
	}
	//8.회원탈퇴 페이지로이동하기
	@RequestMapping("memberLeavePage")
	public String memberLeavePage() {
		return"member/memberLeavePage";
	}
	
	//9.회원탈퇴하기
	@RequestMapping("memberLeave")
	public String memberLeave(HttpServletRequest request ,
								HttpServletResponse response,
								Model model) {
		model.addAttribute("request",request);
		model.addAttribute("response",response);
		
		memberCommand = new MemberDeleteCommand();
		memberCommand.execute(sqlSession, model);
		return"redirect:/";
	}
	
	//11.회원정보변경하기 
	@RequestMapping("memberUpdate")
	public String memberChange(HttpServletRequest request ,
								HttpServletResponse response,
										Model model) {
		model.addAttribute("request",request);
		model.addAttribute("response",response);
		
		memberCommand = new MemberChangeCommand();
		memberCommand.execute(sqlSession, model);
		return"redirect:memberViewPage";
		
	}
	//12.회원정보 세부페이지로이동하기
	@RequestMapping("memberDetailPage")
	public String memberDetailPage(HttpServletRequest request ,
									RedirectAttributes rttr,
											Model model
											) {
		model.addAttribute("request",request);
		model.addAttribute("rttr",rttr);
		
		memberCommand = new MemberDetailCommand();
		memberCommand.execute(sqlSession, model);
		return"member/memberDetailPage";
	}
	
	//13.회원아이디찾기페이지로이동하기
	@RequestMapping("memberFindIdPage")
	public String memberFindIdPage() {
		return"member/memberFindIdPage";
	}
	//14.아이디찾기
		@ResponseBody
		@RequestMapping(value="memberFindId",  produces="text/html; charset=utf-8")
		public String memberFindId(@RequestParam("mEmail") String mEmail,
					HttpServletRequest request,
					Model model){			
			MemberDTO mDTO = new MemberDTO();
			MemberDAO mDAO = sqlSession.getMapper(MemberDAO.class);
			mDTO = mDAO.memberselectBymEmail(mEmail);
			
			String responseText = null;
			if (mDTO != null) {
				responseText = mDTO.getmId();
			} else {
				responseText = "NO";  // 이메일과 일치하는 회원이 없을 때 응답결과는 스스로 정한다.
			}
			
			
			return responseText;
		}
	
	
	//15.관리자페이지 상품업로드
	@RequestMapping("memberProductInsertPage")
	public String memberProductInsertPage() {
			return "member/memberProductInsertPage";
	}	
		

	// 16관리자페이지에서 상품업로드
	@RequestMapping(value="memberProductInsert", method=RequestMethod.POST)
	public String memberProductInsert(MultipartHttpServletRequest mr,
														Model model) {		
		model.addAttribute("mr", mr);
		memberCommand = new MemberProductInsertCommand();		
		memberCommand.execute(sqlSession, model);		
		return "redirect:memberProductListPage";	
		
	}
		
	//17.관리자페이지 상품리스트memberProductListPage 수정중 페이지 에러잡기위해
	@RequestMapping("memberProductListPage")
	public String memberProductListPage(HttpServletRequest request ,
										HttpServletResponse response,			
												Model model) {
		model.addAttribute("request",request);
		model.addAttribute("response",response);
		memberCommand = new MemberProductListCommand();
		memberCommand.execute(sqlSession, model);	
		
		return "member/memberProductListPage";
	}
		
		
	
	
	//18.관리자상품가격변경하기
	@ResponseBody
	@RequestMapping(value="memberUpdatePrice", method=RequestMethod.POST, produces="application/json; charset=utf-8")
	public String memberupdatePrice(@RequestParam("afterPrice") int afterPrice,
													@RequestParam("pNo") int pNo,
																Model model){
		
		JSONObject obj = new JSONObject();			
		MemberDAO mDAO = sqlSession.getMapper(MemberDAO.class);
	    mDAO.memberProductPriceChange( afterPrice, pNo );
		
		obj.put("result", afterPrice );
		
		
		return obj.toJSONString();
	}
	
	//19.관리자상품할인율변경 memberUpdatedisrate
	@ResponseBody
	@RequestMapping(value="memberUpdatedisrate", method=RequestMethod.POST, produces="application/json; charset=utf-8")
	public String memberUpdatedisrate(@RequestParam("afterDisrate") int afterDisrate,
														@RequestParam("pNo") int pNo,
																		Model model){
		JSONObject obj = new JSONObject();		
		MemberDAO mDAO = sqlSession.getMapper(MemberDAO.class);
		mDAO.memberUpdatedisrateChange(afterDisrate, pNo);
		
		obj.put("result", afterDisrate);
		
		return obj.toJSONString();
	}
	
	//20.관리자가 회원 등급변경
	@ResponseBody
	@RequestMapping(value="memberUpdateGrade", method=RequestMethod.POST, produces="text/html; charset=utf-8")
	public String memberUpdateGrade(@RequestParam("afterGrade") char afterGrade,
													@RequestParam("mNo") int mNo,
														Model model) {
		
		MemberDAO mDAO = sqlSession.getMapper(MemberDAO.class);
		mDAO.memberUpdateGrade(afterGrade, mNo);		
		String responseText = afterGrade+"";
			
		return responseText;
	}
	
	//21.관리자가 회원 포인트 지급
	@ResponseBody
	@RequestMapping(value="memberUpdatePoint", method=RequestMethod.POST, produces="application/json; charset=utf-8")
	public String memberUpdatePoint(@RequestParam("afterPoint") int afterPoint,
													@RequestParam("mNo") int mNo,
																	Model model){
		JSONObject obj = new JSONObject();
		MemberDAO mDAO = sqlSession.getMapper(MemberDAO.class);	
	
		mDAO.memberUpdatePoint(afterPoint, mNo);
		
		obj.put("result", afterPoint);
		
		return obj.toJSONString();
	}
	
	//22 회원 주문페이지로 이동하기
	
	@RequestMapping("memberOrderViewPage")
	public String memberOrderViewPage(HttpServletRequest request ,
									HttpServletResponse response,
											Model model) {
		model.addAttribute("request",request);
		model.addAttribute("response",response);
		memberCommand = new MemberOrderView();
		memberCommand.execute(sqlSession, model);	
		return "member/memberOrderViewPage";
	}	
	
	//23클로셋 회원 주문현황 페이지 이동하기(관리자) 0720
	
		@RequestMapping("memberOrderPeriodViewPage")
		public String memberOrderPeriodViewPage(HttpServletRequest request
												, Model model) {
			model.addAttribute("request",request);
			memberCommand = new MemberDetailCommand();				
			memberCommand.execute(sqlSession, model);
			return "member/memberDetailPage";
		}	
		
	//24 클로셋회원 삭제하기07-14
	@ResponseBody
	@RequestMapping(value="memberDeleteAdmin", method=RequestMethod.POST, produces="application/json; charset=utf-8")
	public Object memberDeleteAdmin(@RequestParam(value="mIdList[]") List<String> mIdList
									, @RequestParam(value="mNoList[]") List<Integer> mNoList													
									, Model model) {
		
		MemberDAO mDAO = sqlSession.getMapper(MemberDAO.class);
		
		for(String mId:mIdList) {
			mDAO.memberDeleteReview(mId);
			
		}
		for(Integer mNo:mNoList) {
			mDAO.memberDeleteOrder(mNo);			
		}
		for(String mId:mIdList) {			
			mDAO.memberDeleteBoard(mId);
			mDAO.memberDeleteCart(mId);
			//회원을 제거하기위해 그동안회원의 기록을 제거를 해야합니다.
			mDAO.memeberDelete(mId);			
		}
		
			int count = mIdList.size();	
		JSONObject obj = new JSONObject();
			obj.put("count",count );
		return obj.toJSONString();
	}
	

	//25-1.회원 이메일을 통해서 비밀번호변경하기
	
	@RequestMapping("membeFindPwPage")
	public String membeFindPwPage() {
		return "member/membeFindPwPage";
	}	
	//25-2.회원 이메일을 통해서 비밀번호변경하기
	@Autowired
	private JavaMailSender mailSender; // root-context.xml 빈 자동 객체 주입
		
	//25-3.회원 이메일을 통해서 비밀번호변경하기
	@PostMapping("memberemailAuth")
	public String emailAuth(HttpServletRequest request, Model model) {
			
		model.addAttribute("request", request);
		model.addAttribute("mailSender", mailSender);
			
		memberCommand = new MemberEmailAuthCommand();
		memberCommand.execute(sqlSession, model);	
		return "member/memberemailAuthConfirm"; 
	}
	
	//25-4이메일최종변경페이지
	@RequestMapping(value="memberChangePwpage", method=RequestMethod.POST )
	public String memberChangePwpage( HttpServletRequest request, Model model ) {
		model.addAttribute("mId", request.getParameter("mId"));		
		return "member/memberChangePwpage";
	}	
	//25-5 이메일최종변경페이지 ajax로 변경하기	
	@ResponseBody
	@RequestMapping(value="memberChangePw", method=RequestMethod.POST, produces="application/json; charset=utf-8")
	public String memberChangePw(@RequestParam("mId") String mId,
								@RequestParam("mPw") String mPw,
												Model model){
		JSONObject obj = new JSONObject();		
		MemberDAO mDAO = sqlSession.getMapper(MemberDAO.class);
		mDAO.memberChangePw(mPw, mId);
		obj.put("result", mId);
	
		return obj.toJSONString();
	}
	
	//26 ADMIN권한 : 회원관리페이지에서 회원 검색
	@RequestMapping(value="memberQuery", method=RequestMethod.POST)
	public String memberQuery( HttpServletRequest request, Model model ) {
		
		model.addAttribute( "request", request );
		memberCommand = new MemberQueryCommand();
		memberCommand.execute(sqlSession, model);
		
		return "member/memberListPage";
	}

	
	//27회원이 주문 날짜조회가능함
	@RequestMapping("memberOrderPeriodView")
	public String memberOrderPeriodView(HttpServletRequest request ,									
														Model model) {
		model.addAttribute("request",request);
		memberCommand =new MemberOrderPeriodViewCommand();				
		memberCommand.execute(sqlSession, model);
		return "member/memberOrderViewPage";
	}		
	
	
	
	//회원가입 아이디 유무확인
	@ResponseBody
	@RequestMapping(value="memberEmailCheck", produces="application/json; charset=utf-8")
	public String memberEmailCheck(@RequestParam("mEmail") String mEmail,
			HttpServletRequest request,
			Model model){
		JSONObject obj = new JSONObject();
		MemberDTO mDTO = new MemberDTO();
		MemberDAO mDAO = sqlSession.getMapper(MemberDAO.class);
		//mDTO = mDAO.memberselectBymId(mId);
		mDTO = mDAO.memberselectBymEmail(mEmail);
		if ( mDTO != null ) {
			obj.put("result", "EXIST");
		} else {
			obj.put("result", "");
		}
		
		return obj.toJSONString();
}
	
	
}
