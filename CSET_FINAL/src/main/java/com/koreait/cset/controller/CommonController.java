package com.koreait.cset.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.koreait.cset.command.products.ProductsOrderByRank;
import com.koreait.cset.common.CsetCommand;

@Controller
public class CommonController {
	
	@Autowired
	private SqlSession sqlSession;
	private CsetCommand productsCommand;
	
	@RequestMapping("/")
	public String goIndex(HttpServletRequest request, Model model) {
		productsCommand = new ProductsOrderByRank();
		productsCommand.execute(sqlSession, model);
		return "index";
	}

}
