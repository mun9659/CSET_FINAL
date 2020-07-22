package com.koreait.cset.command.products;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.cset.common.CsetCommand;
import com.koreait.cset.dao.ProductsDAO;

public class ProductsOrderByRank implements CsetCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		ProductsDAO pDAO = sqlSession.getMapper( ProductsDAO.class );
		model.addAttribute( "productsOrderByRank", pDAO.productsOrderByRank() );
		
	}

}
