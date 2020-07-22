package com.koreait.cset.command.products;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.cset.common.CsetCommand;
import com.koreait.cset.dao.ProductsDAO;

public class ProductsListCommand implements CsetCommand {

	@Override
	public void execute( SqlSession sqlSession, Model model ) {
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		String pCategory = request.getParameter("pCategory");
		String pCategory_sub = request.getParameter("pCategory_sub");
		String pBrand = request.getParameter("pBrand");
		
		
		ProductsDAO pDAO = sqlSession.getMapper( ProductsDAO.class );
		model.addAttribute("productsList", pDAO.productsSelectList(pCategory, pCategory_sub, pBrand) );
		
	}

}
