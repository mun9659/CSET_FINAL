package com.koreait.cset.command.products;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.cset.common.CsetCommand;
import com.koreait.cset.dao.ProductsDAO;

public class ProductsOrderByDynamicCommand implements CsetCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		
		String[] pCategoryList = request.getParameterValues("pCategoryList");
		String[] pCategory_subList = request.getParameterValues("pCategory_subList");
		String[] pBrandList = request.getParameterValues("pBrandList");
		String searchBox = request.getParameter("searchBox");
		String searchOrderBy = request.getParameter("searchOrderBy");
		
		
		ProductsDAO pDAO = sqlSession.getMapper(ProductsDAO.class);
		model.addAttribute("productsList" , pDAO.productsOrderByDynamic( pCategoryList
																						, pCategory_subList
																						, pBrandList
																						, searchBox
																						, searchOrderBy));
	}

}
