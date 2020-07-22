package com.koreait.cset.command.order;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.cset.common.CsetCommand;
import com.koreait.cset.dao.ProductsDAO;
import com.koreait.cset.dao.StockDAO;
import com.koreait.cset.dto.CartJoinVO;
import com.koreait.cset.dto.ProductsDTO;

public class OrderProductQuickCommand implements CsetCommand {
	
	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		HttpServletResponse response = (HttpServletResponse) map.get("response");
		CartJoinVO cJVO = new CartJoinVO();
		ProductsDTO pDTO = new ProductsDTO();
		ProductsDAO pDAO  = sqlSession.getMapper(ProductsDAO.class);
		StockDAO sDAO = sqlSession.getMapper(StockDAO.class);
		
		int pNo = Integer.parseInt(request.getParameter("pNo"));
		String cSize = request.getParameter("pSize");
		int cAmount = Integer.parseInt(request.getParameter("pAmount"));
		
		/*  특정 상품의 특정 사이즈 재고량  */
		int sAmount = sDAO.stockSelectBypNopSize(pNo, cSize);
		
		pDTO = pDAO.productsSelectBypNo(pNo);
		String pName = pDTO.getpName();
		String pBrand = pDTO.getpBrand();
		int pPrice = pDTO.getpPrice();
		String pFilename = pDTO.getpFilename();
		int pDisrate = pDTO.getpDisrate();
		int total_price = pPrice * cAmount * (1-(pDisrate/100)); // 상품 번호의 값
		int fee = total_price >= 100000 ? 0 : 3000;
		
		List<CartJoinVO> cjList = new ArrayList<CartJoinVO>();
		
		/* 재고량 비교 후  */
		if (cAmount <= sAmount) {
			cJVO.setpNo(pNo);
			cJVO.setpName(pName);
			cJVO.setpBrand(pBrand);
			cJVO.setpPrice(pPrice);
			cJVO.setcAmount(cAmount); // 상품 수량
			cJVO.setcSize(cSize); // 상품 사이즈
			cJVO.setpFilename(pFilename);
			cJVO.setpDisrate(pDisrate);
			
			cjList.add(cJVO);			
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
		
		model.addAttribute("cjList", cjList);
		model.addAttribute("total_price", total_price);
		model.addAttribute("fee", fee);
		
	}
}
