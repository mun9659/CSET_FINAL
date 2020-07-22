package com.koreait.cset.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koreait.cset.command.products.ProductsListCommand;
import com.koreait.cset.command.products.ProductsOrderByDynamicCommand;
import com.koreait.cset.command.products.ProductsSearchCommand;
import com.koreait.cset.command.products.ProductsViewCommand;
import com.koreait.cset.common.CsetCommand;
import com.koreait.cset.dao.ProductsDAO;

@Controller
public class ProductsController {
	@Autowired
	private SqlSession sqlSession;
	
	private CsetCommand productsCommand;
	@RequestMapping( "productsSearch" )
	public String productsSerach( HttpServletRequest request,Model model) {
		model.addAttribute("request",request);
		productsCommand = new ProductsSearchCommand();
		productsCommand.execute( sqlSession, model );
		return "member/memberProductListPage";
	}
	
	// 상품 목록
	@RequestMapping( "productsListPage" ) 
	public String productsListPage( HttpServletRequest request, Model model ) {
		model.addAttribute( "request", request );
		productsCommand = new ProductsListCommand();
		productsCommand.execute( sqlSession, model );
		return "products/productsListPage";
	}
	
	// 상품 정렬
	@RequestMapping("productsOrderByDynamic")
	public String productsOrderByDynamic( HttpServletRequest request, Model model ) {
		model.addAttribute("request",request);
		productsCommand = new ProductsOrderByDynamicCommand();
		productsCommand.execute(sqlSession, model);
		return "products/productsListPage";
	}
	
	// 상품 상세
	@RequestMapping( "productsViewPage" )
	public String productsViewPage( HttpServletRequest request, Model model ) {
		model.addAttribute( "request", request );
		productsCommand = new ProductsViewCommand();
		productsCommand.execute( sqlSession, model );
		return "products/productsViewPage";
	}

	// 상품 등록하기 페이지로 이동
	@RequestMapping("productsInsertPage")
	public String productsInsertPage() {
		return "products/productsInsertPage";
	}
	
		
	@RequestMapping("reviews")
	public String reviews() {
		return "products/reviews";
	}
	
	// 선택한 제품의 수량과 재고 비교하기 위한 코드
	@ResponseBody
	@RequestMapping(value="stockSelect", method=RequestMethod.GET, produces="application/json; charset=utf-8")
	public String stockSelect(
			@RequestParam("pSize") String pSize,
			@RequestParam("pNo") int pNo,
			@RequestParam("pAmount") int pAmount,
			HttpServletRequest request,
				Model model){
		JSONObject obj = new JSONObject();
		
		ProductsDAO pDAO =sqlSession.getMapper(ProductsDAO.class);
		int stock =pDAO.stockSelectBypNopSize(pSize, pNo);

		if ( pAmount>stock ) {
			obj.put("result", "NOSTOCK");
		} else {
			obj.put("result", "YES");
		}
		
		return obj.toJSONString();
	}
	
}
