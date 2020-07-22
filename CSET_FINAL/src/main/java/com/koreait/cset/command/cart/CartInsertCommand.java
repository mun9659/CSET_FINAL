package com.koreait.cset.command.cart;

import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.cset.common.CsetCommand;
import com.koreait.cset.dao.CartDAO;
import com.koreait.cset.dao.StockDAO;
import com.koreait.cset.dto.CartDTO;
import com.koreait.cset.dto.MemberDTO;

public class CartInsertCommand implements CsetCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		HttpServletResponse response = (HttpServletResponse) map.get("response");
		HttpSession session = request.getSession();
		StockDAO sDAO = sqlSession.getMapper(StockDAO.class);
		MemberDTO loginDTO = (MemberDTO) session.getAttribute("loginDTO");
		
		if(loginDTO != null) {
	         String mId = loginDTO.getmId();
	         int pNo = Integer.parseInt(request.getParameter("pNo"));
	         int pAmount = Integer.parseInt(request.getParameter("pAmount"));
	         String pSize = request.getParameter("pSize");
	         
	         /*  특정 상품의 특정 사이즈 재고량  */
	         int sAmount = sDAO.stockSelectBypNopSize(pNo, pSize);
	         
	         if(pAmount <= sAmount) {
	            CartDTO cDTO = new CartDTO();
	            
	            cDTO.setmId(mId);
	            cDTO.setpNo(pNo);
	            cDTO.setcAmount(pAmount);
	            cDTO.setcSize(pSize);
	            
	            CartDAO cDAO = sqlSession.getMapper(CartDAO.class);
	            
	            cDAO.cartInsert(cDTO);
	         } else {
	            PrintWriter out;
	            try {
	               response.setContentType("text/html; charset=utf-8");
	               out = response.getWriter();
	               out.println("<script type='text/javascript'>");
	               out.println("alert('재고가 부족합니다.');");
	               out.println("history.back();");
	               out.println("</script>");
	               out.close();
	            } catch (Exception e) {
	               e.printStackTrace();
	            }
	         }
	      } else {
	         PrintWriter out;
	         try {
	            response.setContentType("text/html; charset=utf-8");
	            out = response.getWriter();
	            out.println("<script type='text/javascript'>");
	            out.println("alert('로그인 후 이용이 가능합니다.');");
	            out.println("location.href='memberLoginPage'");
	            out.println("</script>");
	            out.close();
	         } catch (Exception e) {
	            e.printStackTrace();
	         }
	      }
	}

}
