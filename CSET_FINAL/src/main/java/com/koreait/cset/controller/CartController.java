package com.koreait.cset.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koreait.cset.command.cart.CartAllDeleteCommand;
import com.koreait.cset.command.cart.CartDeleteSelectCommand;
import com.koreait.cset.command.cart.CartInsertCommand;
import com.koreait.cset.command.cart.CartListCommand;
import com.koreait.cset.command.products.ProductsOrderByRank;
import com.koreait.cset.common.CsetCommand;
import com.koreait.cset.dao.CartDAO;

@Controller
public class CartController {
	
	// Field
	@Autowired
	private SqlSession sqlSession;
	private CsetCommand productsCommand;
	
	@RequestMapping("homepage")
	public String goHome() {
		return "index";
	}
	
	@RequestMapping("cartInsert")
	public String cartInsert(HttpServletResponse response,
							 HttpServletRequest request,
						     Model model) {
		model.addAttribute("request", request);
		model.addAttribute("response", response);
		CsetCommand csetCommand = new CartInsertCommand();
		csetCommand.execute(sqlSession, model);
		return "redirect:selectView"; // 선택 가능하게 하는 뷰로 보내기
	}
	
	@RequestMapping("selectView")
	public String selectView() {
		return "cart/selectView";
	}
	
	// 장바구니에 상품 넣으면 장바구니 페이지로 가기
	@RequestMapping("cartListPage")
	public String cartListPage(HttpServletRequest request,
							   Model model) {
		model.addAttribute("request", request);
		CsetCommand csetCommand = new CartListCommand();
		csetCommand.execute(sqlSession, model);
		return "cart/cartListPage";
	}
	
	// 선택 카트 삭제
	@ResponseBody
	@RequestMapping(value="cartDeleteSelect", method=RequestMethod.POST)
	public void cartDeleteAll(@RequestParam(value="chk[]") List<Integer> chArr, Model model) {
		model.addAttribute("chArr", chArr);
		CsetCommand csetCommand = new CartDeleteSelectCommand();
		csetCommand.execute(sqlSession, model);
	}
	
	@ResponseBody
	@RequestMapping(value="cartPlusCalc", produces="application/json; charset=utf-8")
	public String cartPlusCalc(@RequestParam("cNo") int cNo
							   , @RequestParam("cAmount") int cAmount) {
		
		cAmount += 1;
		CartDAO cDAO = sqlSession.getMapper(CartDAO.class);
		cDAO.cartAmountPlus(cNo, cAmount);
		
		JSONObject obj = new JSONObject();
		obj.put("result", cAmount);
		
		return obj.toString();
	}
	
	@ResponseBody
	@RequestMapping(value="cartMinusCalc", produces="application/json; charset=utf-8")
	public String cartMinusCalc(@RequestParam("cNo") int cNo
								, @RequestParam("cAmount") int cAmount) {
		cAmount -= 1;
		CartDAO cDAO = sqlSession.getMapper(CartDAO.class);
		cDAO.cartAmountMinus(cNo, cAmount);
		
		JSONObject obj = new JSONObject();
		obj.put("result", cAmount);
		
		return obj.toString();
	}
	
	
	@RequestMapping("cartAllDelete")
	public String cartAllDelete(HttpServletRequest request,
								 Model model) {
		model.addAttribute("request", request);
		CsetCommand csetCommand = new CartAllDeleteCommand();
		csetCommand.execute(sqlSession, model);
		return index(request, model);
	}
	
	private String index(HttpServletRequest request, Model model) {
	      productsCommand = new ProductsOrderByRank();
	      productsCommand.execute(sqlSession, model);
	      return "index";
	   }
}
